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
            <div style="flex: 3; margin-left: 20px">课程信息</div>
            <!-- 查找 -->
            <div class="search">
              <el-input
                placeholder="请输入课程名称查询"
                style="width: 200px"
                v-model="name"></el-input>
              <el-button
                type="info"
                plain
                style="margin-left: 10px"
                @click="loadCourse(1)"
                >查询</el-button
              >
              <el-button
                type="warning"
                plain
                style="margin-right: 50px"
                @click="reset"
                >重置</el-button
              >
            </div>
          </div>
        </div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table
              :data="courseData"
              strip
              @selection-change="handleSelectionChange">
              <!-- <el-table-column
                prop="id"
                label="序号"
                width="70"
                align="center"
                sortable></el-table-column> -->
              <el-table-column
                prop="courseId"
                label="课程编号"
                width="100"
                align="center"></el-table-column>
              <el-table-column
                prop="name"
                label="课程名称"
                width="250"
                align="center"></el-table-column>
              <el-table-column
                prop="majorName"
                label="所属专业"
                width="200"
                align="center"></el-table-column>

              <el-table-column
                prop="creditHours"
                label="学分"
                width="70"
                align="center"></el-table-column>
              <el-table-column
                prop="syllabus"
                label="教学大纲"
                width="500"
                show-overflow-tooltip
                align="center"></el-table-column>
              <el-table-column
                prop="semester"
                label="学期"
                width="70"
                align="center"></el-table-column>

              <el-table-column
                label="操作"
                align="center"
                width="180"
                v-if="user.role === 'TEACHER'">
                <template v-slot="scope">
                  <!-- 教师选课功能 -->
                  <el-button
                    size="mini"
                    type="primary"
                    plain
                    @click="choose(scope.row.id)"
                    >选课</el-button
                  >
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
  </div>
</template>

<script>
export default {
  // data：页面中需要的一些数据
  data() {
    return {
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      courseData: [],
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      formVisible: false,
      form: {},
      name: null,
    };
  },

  // mounted：页面加载完毕后立即执行的函数
  mounted() {
    this.loadCourse(1);
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadCourse(pageNum) {
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
          if (res.code === "200") {
            this.courseData = res.data?.list;
            this.total = res.data?.total;
          } else {
            this.$message.error(res.msg);
          }
        });
    },
    handleSelectionChange(rows) {
      // 当前选中的所有的行数据
      this.ids = rows.map((v) => v.id);
    },
    choose(id) {
      // 选课
      this.$confirm("您确定选课吗？", "确认选课", { type: "info" })
        .then(() => {
          this.$request.post("/course/choose/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("选课成功");
            } else {
              this.$message.success("此课程已选上！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },

    handleCurrentChange(pageNum) {
      this.loadCourse(pageNum);
    },
    // 跳转函数
    navTo(url) {
      location.href = url;
    },
    reset() {
      this.name = null;
      this.loadCourse(1);
    },
  },
};
</script>
