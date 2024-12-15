<template>
  <div>
    <div class="main-content">
      <div
        style="
          width: 90%;
          background-color: white;
          margin: 30px auto;
          border-radius: 20px;
        ">
        <div style="padding-bottom: 10px">
          <div
            style="
              display: flex;
              font-size: 18px;
              color: #000000ff;
              line-height: 80px;
              border-bottom: #cccccc 1px solid;
            ">
            <div style="flex: 3; margin-left: 20px">选课记录</div>
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
                    : searchType === 'studentId'
                    ? '学生学号'
                    : ''
                }查询`"
                style="width: 200px; margin-left: 10px"
                v-model="searchValue"></el-input>

              <el-button
                type="info"
                plain
                style="margin-left: 10px"
                @click="loadTimetable(1)"
                >查询</el-button>
              <el-button
                type="warning"
                plain
                style="margin-right: 50px"
                @click="reset"
                >重置</el-button>
            </div>
          </div>
        </div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table
              :data="timetableData"
              stripe
              @selection-change="handleSelectionChange">
              <!-- <el-table-column
                prop="id"
                label="序号"
                width="70"
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
              <el-table-column
                label="操作"
                align="center"
                width="180"
                v-if="user.role === 'STUDENT' || user.role === 'TEACHER'">
                <template v-slot="scope">
                  <el-button
                    size="mini"
                    type="primary"
                    plain
                    @click="editTimetable(scope.row)"
                    v-if="user.role === 'TEACHER'"
                    >打分</el-button>
                  <el-button
                    size="mini"
                    type="primary"
                    plain
                    @click="editTimetable(scope.row)"
                    v-if="user.role === 'STUDENT'"
                    >评价</el-button>
                  <el-button
                    size="mini"
                    type="danger"
                    plain
                    @click="del(scope.row.id)"
                    v-if="user.role === 'STUDENT'"
                    >退选</el-button>
                </template>
              </el-table-column>
            </el-table>

            <div class="pagination" style="margin-top: 20px">
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
          </div>
        </div>
      </div>
    </div>
    <el-dialog
      title="评价信息"
      :visible.sync="formVisible"
      width="40%"
      :close-on-click-modal="false"
      destroy-on-close>
      <el-form
        label-width="100px"
        style="padding-right: 50px"
        :model="form"
        :rules="rules"
        ref="formRef">
        <el-form-item label="成绩" prop="score" v-if="user.role === 'TEACHER'">
          <el-input v-model="form.score" placeholder="成绩"></el-input>
        </el-form-item>
        <el-form-item
          label="教师评价"
          prop="evaluate"
          v-if="user.role === 'STUDENT'">
          <el-input v-model="form.evaluate" placeholder="教师评价"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="formVisible = false">取 消</el-button>
        <el-button type="primary" @click="save"> 确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  // data：页面中需要的一些数据
  data() {
    return {
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      searchType: null, // 搜索类型
      searchValue: null, // 搜索值
      timetableData: [],
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      formVisible: false,
      form: {},
      rules: {
        evaluate: [
          { required: true, message: "请输入教师评价", trigger: "blur" },
        ],
        score: [{ required: true, message: "请输入成绩", trigger: "blur" }],
      },
    };
  },

  // mounted：页面加载完毕后立即执行的函数
  mounted() {
    this.loadTimetable(1);
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    // 编辑
    editTimetable(row) {
      this.form = JSON.parse(JSON.stringify(row));
      this.formVisible = true;
    },

    // 保存按钮触发的逻辑
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.userId = this.user.id;
          this.$request({
            url: this.form.id ? "/timetable/update" : "/timetable/add",
            method: this.form.id ? "PUT" : "POST",
            data: this.form,
          }).then((res) => {
            if (res.code === "200") {
              // 表示成功保存
              this.$message.success("保存成功");
              this.loadTimetable(1);
              this.formVisible = false;
            } else {
              this.$message.error(res.msg); // 弹出错误的信息
            }
          });
        }
      });
    },
    

    // 加载
    loadTimetable(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      const params = {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      };
      if (this.searchValue) {
        params[this.searchType] = this.searchValue;
      }
      this.$request
        .get("/timetable/selectPage", {
          params,
        })
        .then((res) => {
          if (res.code === "200") {
            this.timetableData = res.data?.list;
            this.total = res.data?.total;
          } else {
            this.$message.error(res.msg);
          }
        });
    },
    // 分页
    handleCurrentChange(pageNum) {
      this.loadTimetable(pageNum);
    },
    // 跳转函数
    navTo(url) {
      location.href = url;
    },
    reset() {
      this.searchType = null;
      this.searchValue = null;
      this.loadTimetable(1);
    },

    // 学生退选
    del(id) {
      this.$request.delete("/timetable/delete/" + id).then((res) => {
        if (res.code === "200") {
          this.$message.success("退选成功");
          this.loadTimetable(1);
        } else {
          this.$message.error(res.msg);
        }
      });
    },
  },
};
</script>

<style scoped>
.main-content {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
