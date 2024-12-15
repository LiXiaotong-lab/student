<template>
  <div>
    <!-- 查找 -->
    <div class="search">
      <el-select
        v-model="searchType"
        placeholder="选择查询类型"
        style="width: 150px">
        <el-option label="教师编号" value="teacherId"></el-option>
        <el-option label="课程编号" value="courseId"></el-option>
      </el-select>
      <el-input
        :placeholder="`请输入${
          searchType === 'teacherId'
            ? '教师编号'
            : searchType === 'courseId'
            ? '课程编号'
            : ''
        }查询`"
        style="width: 200px; margin-left: 10px"
        v-model="searchValue"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)"
        >查询</el-button
      >
      <el-button type="warning" plain style="margin-left: 10px" @click="reset"
        >重置</el-button
      >
    </div>
    <!-- 增加，删除按钮 -->
    <div class="operation" v-if="user.role === 'ADMIN'">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="table">
      <el-table
        :data="tableData"
        border
        fit
        stripe
        @selection-change="handleSelectionChange">
        <!-- 多选 -->
        <el-table-column
          type="selection"
          width="55"
          align="center"
          v-if="user.role === 'ADMIN'"></el-table-column>

        <!-- <el-table-column
          prop="id"
          label="序号"
          width="80"
          align="center"
          sortable></el-table-column> -->
        <el-table-column
          prop="courseId"
          label="课程编号"
          width="200"
          align="center"></el-table-column>
        <el-table-column
          prop="courseName"
          label="课程名称"
          width="360"
          align="center"></el-table-column>
        <el-table-column
          prop="teacherId"
          label="教师编号"
          width="240"
          align="center"></el-table-column>
        <el-table-column
          prop="teacherName"
          label="教师姓名"
          width="220"
          align="center"></el-table-column>

        <!-- 信息后面的操作按钮 -->
        <el-table-column label="操作" align="center" width="180">
          <template v-slot="scope">
            <!-- 管理员编辑 -->
            <el-button
              size="mini"
              type="primary"
              v-if="user.role === 'ADMIN'"
              plain
              @click="handleEdit(scope.row)"
              >编辑</el-button
            >

            <!-- 学生选课 -->
            <el-button
              size="mini"
              type="primary"
              v-if="user.role === 'STUDENT'"
              plain
              @click="choose(scope.row.id)"
              >选课</el-button
            >

            <!-- 教师退选 -->
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              v-if="user.role === 'TEACHER'"
              >退选</el-button
            >

            <!-- 管理员删除 -->
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del1(scope.row.id)"
              v-if="user.role === 'ADMIN'"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 无需修改-->
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

        <!-- 编辑信息 -->
        <el-dialog
          title="教师选课信息"
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
            <el-form-item
              label="课程编号"
              prop="courseId"
              v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.courseId"
                placeholder="课程编号"></el-input>
            </el-form-item>
            <el-form-item
              label="教师编号"
              prop="teacherId"
              v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.teacherId"
                placeholder="教师编号"></el-input>
            </el-form-item>
          </el-form>

          <div slot="footer" class="dialog-footer">
            <el-button @click="fromVisible = false">取消</el-button>
            <el-button type="primary" @click="save">确定</el-button>
          </div>
        </el-dialog>
      </div>
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
      searchType: null, // 默认查询类型
      searchValue: null, // 查询内容
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
        // ///////////////////////////////////////////////////////////////////////////////////////////表单验证规则

        courseId: [
          { required: true, message: "请输入课程编号", trigger: "blur" },
        ],
        teacherId: [
          { required: true, message: "请输入教师编号", trigger: "blur" },
        ],
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
    handleEdit(row) {
      // 编辑数据
      this.form = JSON.parse(JSON.stringify(row)); // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true; // 打开弹窗
    },
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? "/arrange/update" : "/arrange/add",
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
    choose(id) {
      // 选课
      this.$confirm("您确定选课吗？", "确认选课", { type: "info" })
        .then(() => {
          this.$request.post("/arrange/choose/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("选课成功");
              this.load(1);
            } else {
              this.$message.success("已选择该课程！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    del(id) {
      // 单个删除
      this.$confirm("您确定退选吗？", "确认退选", { type: "warning" })
        .then((response) => {
          this.$request.delete("/arrange/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error("已有学生选择课程,退选失败!"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    del1(id) {
      // 单个删除
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/arrange/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error(res.msg); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    handleSelectionChange(rows) {
      // 当前选中的所有的行数据
      this.ids = rows.map((v) => v.id);
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
            .delete("/arrange/delete/batch", { data: this.ids })
            .then((res) => {
              if (res.code === "200") {
                // 表示操作成功
                this.$message.success("操作成功");
                this.load(1);
              } else {
                this.$message.error(res.msg); // 弹出错误的信息
              }
            });
        })
        .catch(() => {});
    },
    load(pageNum) {
      // 分页查询
      if (pageNum) this.pageNum = pageNum;
      const params = {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      };
      if (this.searchValue) {
        params[this.searchType] = this.searchValue;
      }
      this.$request.get("/arrange/selectPage", { params }).then((res) => {
        this.tableData = res.data?.list;
        this.total = res.data?.total;
      });
    },
    reset() {
      this.searchType = null;
      this.searchValue = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
  },
};
</script>

<style scoped></style>
