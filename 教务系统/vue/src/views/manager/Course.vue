<template>
  <div>
    <!-- 查找 -->
    <div class="search">
      <el-input
        placeholder="请输入课程名称查询"
        style="width: 200px"
        v-model="name"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)"
        >查询</el-button
      >
      <el-button type="warning" plain style="margin-left: 10px" @click="reset"
        >重置</el-button
      >
    </div>
    <!-- 增加，删除按钮 -->
    <div class="operation" v-if="user.role === 'ADMIN'">
      <el-button type="primary" plain @click="handleAdd">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <!-- 表格内容 -->
    <div class="table">
      <el-table
        :data="tableData"
        stripe
        @selection-change="handleSelectionChange"
        border
        fit>
        <!-- 多选 -->
        <el-table-column
          type="selection"
          width="55"
          align="center"
          v-if="user.role === 'ADMIN'"></el-table-column>

        <!-- <el-table-column
          prop="id"
          label="序号"
          width="70"
          align="center"
          sortable></el-table-column> -->

        <el-table-column
          prop="courseId"
          label="课程编号"
          width="120"
          align="center"></el-table-column>

        <el-table-column
          prop="name"
          label="课程名称"
          width="170"
          align="center"></el-table-column>
        <el-table-column
          prop="majorName"
          label="所属专业"
          width="170"
          align="center"></el-table-column>

        <el-table-column
          prop="creditHours"
          label="学分"
          width="70"
          align="center"></el-table-column>
        <el-table-column
          prop="syllabus"
          label="教学大纲"
          show-overflow-tooltip
          align="center"></el-table-column>
        <el-table-column
          prop="semester"
          label="学期"
          width="70"
          align="center"></el-table-column>

        <!-- 信息后面的操作按钮 -->
        <el-table-column
          label="操作"
          align="center"
          width="180"
          v-if="user.role === 'TEACHER' || user.role === 'ADMIN'">
          <template v-slot="scope">
            <!-- 教师选课 -->
            <el-button
              size="mini"
              type="primary"
              plain
              @click="choose(scope.row.id)"
              v-if="user.role === 'TEACHER'"
              >选课</el-button
            >
            <!-- <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              v-if="user.role === 'TEACHER'"
              >退选</el-button
            > -->

            <!-- 管理员编辑 -->
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              v-if="user.role === 'ADMIN'"
              >编辑</el-button
            >

            <!-- 管理员删除 -->
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              v-if="user.role === 'ADMIN'"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          background
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
        </el-pagination>
      </div>

      <!-- 编辑信息---------------------------------------------------- -->
      <el-dialog
        title="课程信息"
        :visible.sync="fromVisible"
        width="40%"
        :close-on-click-modal="false"
        destroy-on-close>
        <el-form
          :model="form"
          label-width="100px"
          style="padding-right: 50px"
          :rules="rules"
          ref="formRef">
          <el-form-item label="课程编号" prop="courseId">
            <el-input v-model="form.courseId" placeholder="课程编号"></el-input>
          </el-form-item>
          <el-form-item label="课程名称" prop="name">
            <el-input v-model="form.name" placeholder="课程名称"></el-input>
          </el-form-item>

          <el-form-item label="所属专业" prop="majorId">
            <el-input
              v-model="form.majorId"
              placeholder="所属专业(请输入专业编号)"></el-input>
          </el-form-item>
          <el-form-item label="学分" prop="creditHours">
            <el-input v-model="form.creditHours" placeholder="学分"></el-input>
          </el-form-item>

          <el-form-item label="教学大纲" prop="syllabus">
            <el-input v-model="form.syllabus" placeholder="教学大纲"></el-input>
          </el-form-item>
          <el-form-item label="学期" prop="semester">
            <el-input v-model="form.semester" placeholder="学期"></el-input>
          </el-form-item>
        </el-form>

        <div slot="footer" class="dialog-footer">
          <el-button @click="fromVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </div>
      </el-dialog>
      <!-- 编辑信息------------------------------------------------------>
    </div>
  </div>
</template>

<script>
export default {
  name: "Admin",
  data() {
    return {
      tableData: [], // 所有的数据
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      name: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
        name: [{ required: true, message: "请输入课程名称", trigger: "blur" }],
        courseId: [
          { required: true, message: "请输入课程编号", trigger: "blur" },
        ],
        majorId: [
          { required: true, message: "请输入专业(专业编号)", trigger: "blur" },
        ],
        creditHours: [
          { required: true, message: "请输入学分", trigger: "blur" },
        ],
        semester: [{ required: true, message: "请输入学期", trigger: "blur" }],
      },
      ids: [],
    };
  },
  created() {
    this.load(1);
  },
  methods: {
    handleAdd() {
      // 新增数据
      this.form = {}; // 新增数据的时候清空数据
      this.fromVisible = true; // 打开弹窗
    },

    // 编辑数据函数
    handleEdit(row) {
      // 编辑数据
      this.form = JSON.parse(JSON.stringify(row)); // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true; // 打开弹窗
    },

    // 保存函数
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? "/course/update" : "/course/add",
            method: this.form.id ? "PUT" : "POST",
            data: this.form,
          }).then((res) => {
            if (res.code === "200") {
              // 表示成功保存
              this.$message.success("保存成功");
              this.load(1);
              this.fromVisible = false;
            } else {
              this.$message.error(res.msg); // 弹出错误的信息
            }
          });
        }
      });
    },
    handleSelectionChange(rows) {
      // 当前选中的所有的行数据
      this.ids = rows.map((v) => v.id); //  [1,2]
    },
    // 删除函数
    del(id) {
      // 单个删除
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/course/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error("此课程已被选择，无法删除！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },

    choose(id) {
      // 选课
      this.$confirm("您确定选课吗？", "确认选课", { type: "info" })
        .then(() => {
          this.$request.post("/course/choose/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("选课成功");
              this.load(1);
            } else {
              this.$message.success("此课程已选上！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },

    delBatch() {
      // 批量删除
      if (!this.ids.length) {
        this.$message.warning("请选择数据");
        return;
      }
      this.$confirm("您确定批量删除这些数据吗？", "确认删除", {
        type: "warning",
      })
        .then((response) => {
          this.$request
            .delete("/course/delete/batch", { data: this.ids })
            .then((res) => {
              if (res.code === "200") {
                // 表示操作成功
                this.$message.success("操作成功");
                this.load(1);
              } else {
                this.$message.error("存在课程已被选择，无法删除！"); // 弹出错误的信息
              }
            });
        })
        .catch(() => {});
    },

    load(pageNum) {
      // 分页查询
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .get("/course/selectPage", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.name,
          },
        })
        .then((res) => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
    },
    // 重置函数
    reset() {
      this.name = null;
      this.load(1);
    },

    // 分页函数
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
  },
};
</script>

<style scoped></style>
