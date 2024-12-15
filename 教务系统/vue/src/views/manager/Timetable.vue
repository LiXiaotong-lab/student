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
        <el-option label="学生学号" value="studentId"></el-option>
      </el-select>

      <el-input
        :placeholder="`请输入${
          searchType === 'teacherId'
            ? '教师编号'
            : searchType === 'courseId'
            ? '课程编号'
            : '学生学号' === 'studentId'
            ? '学生学号'
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
          prop="studentId"
          label="学生学号"
          width="160"
          align="center"></el-table-column>
        <el-table-column
          prop="studentName"
          label="学生姓名"
          width="150"
          align="center"></el-table-column>

        <el-table-column
          prop="courseId"
          label="课程编号"
          width="150"
          align="center"></el-table-column>

        <el-table-column
          prop="courseName"
          label="课程名称"
          width="220"
          align="center"></el-table-column>

        <el-table-column
          prop="teacherId"
          label="教师编号"
          width="150"
          align="center"></el-table-column>

        <el-table-column
          prop="teacherName"
          label="教师姓名"
          width="180"
          align="center"></el-table-column>

        <el-table-column
          prop="time"
          label="上课时间"
          width="180"
          align="center"></el-table-column>
        <el-table-column
          prop="room"
          label="教室"
          show-overflow-tooltip
          align="center"></el-table-column>
        <el-table-column
          prop="testtime"
          label="考试时间"
          width="180"
          align="center"></el-table-column>
        <el-table-column
          prop="testroom"
          label="考试教室"
          show-overflow-tooltip
          align="center"></el-table-column>
        <el-table-column
          prop="score"
          label="成绩"
          width="150"
          align="center"></el-table-column>
        <el-table-column
          prop="evaluate"
          label="教师评价"
          width="150"
          align="center"></el-table-column>
        <!-- 信息后面的操作按钮 -->
        <el-table-column label="操作" align="center" width="180">
          <template v-slot="scope">
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              v-if="user.role === 'ADMIN'"
              >编辑</el-button
            >
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              v-if="user.role === 'TEACHER'"
              >打分</el-button
            >
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del1(scope.row.id)"
              v-if="user.role === 'ADMIN'"
              >删除</el-button
            >
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              v-if="user.role === 'STUDENT'"
              >评价</el-button
            >
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              v-if="user.role === 'STUDENT'"
              >退选</el-button
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
        <!-- 编辑信息---------------------------------------------------- -->
        <el-dialog
          title="选课信息"
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
              label="学生学号"
              prop="studentId"
              v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.studentId"
                placeholder="学生学号"></el-input>
            </el-form-item>

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

            <el-form-item
              label="上课时间"
              prop="time"
              v-if="user.role === 'ADMIN'">
              <el-input v-model="form.time" placeholder="上课时间"></el-input>
            </el-form-item>

            <el-form-item label="教室" prop="room" v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.room"
                placeholder="教室"
                v-if="user.role === 'ADMIN'"></el-input>
            </el-form-item>
            <el-form-item
              label="考试时间"
              prop="testtime"
              v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.testtime"
                placeholder="考试时间"></el-input>
            </el-form-item>

            <el-form-item
              label="考试教室"
              prop="testroom"
              v-if="user.role === 'ADMIN'">
              <el-input
                v-model="form.testroom"
                placeholder="考试教室"></el-input>
            </el-form-item>

            <el-form-item
              label="成绩"
              prop="score"
              v-if="user.role === 'ADMIN' || user.role === 'TEACHER'">
              <el-input v-model="form.score" placeholder="成绩"></el-input>
            </el-form-item>
            <el-form-item
              label="教师评价"
              prop="evaluate"
              v-if="user.role === 'ADMIN' || user.role === 'STUDENT'">
              <el-input
                v-model="form.evaluate"
                placeholder="教师评价"></el-input>
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
  </div>
</template>

<script>
export default {
  name: "Admin",
  data() {
    return {
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      tableData: [], // 所有的数据
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      searchType: null, // 默认查询类型
      searchValue: null, // 查询内容
      fromVisible: false,
      form: {},

      rules: {
studentId: [
          { required: true, message: "请输入学生学号", trigger: "blur" },
        ],
        teacherId: [{ required: true, message: "请输入教师编号", trigger: "blur" }],
        courseId: [{ required: true, message: "请输入课程编号", trigger: "blur" }],
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
            url: this.form.id ? "/timetable/update" : "/timetable/add",
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

    del(id) {
      // 单个删除
      this.$confirm("您确定退选吗？", "确认退选", { type: "warning" })
        .then((response) => {
          this.$request.delete("/timetable/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error("此课程已有学生选择，无法退选！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    del1(id) {
      // 单个删除
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/timetable/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error("此课程已有学生选择，无法删除！"); // 弹出错误的信息
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
            .delete("/timetable/delete/batch", { data: this.ids })
            .then((res) => {
              if (res.code === "200") {
                // 表示操作成功
                this.$message.success("操作成功");
                this.load(1);
              } else {
                this.$message.error("存在课程已有学生选择，无法删除！"); // 弹出错误的信息
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
      this.$request.get("/timetable/selectPage", { params }).then((res) => {
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
