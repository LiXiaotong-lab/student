<template>
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
          <div style="flex: 3; margin-left: 20px">教师开课信息</div>
          <div class="search">
            <el-select
              v-model="searchType"
              placeholder="选择查询类型"
              style="width: 150px">
              <el-option label="课程编号" value="courseId"></el-option>
              <el-option label="教师编号" value="teacherId"></el-option>
            </el-select>
            <el-input
              :placeholder="`请输入${
                searchType === 'courseId'
                  ? '课程编号'
                  : searchType === 'teacherId'
                  ? '教师编号'
                  : ''
              }查询`"
              style="width: 200px; margin-left: 10px"
              v-model="searchValue"></el-input>
            <el-button
              type="info"
              plain
              style="margin-left: 10px"
              @click="loadArrange(1)"
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
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table :data="arrangeData" stripe>
              <!-- <el-table-column
                prop="id"
                label="序号"
                width="70"
                align="center"
                sortable></el-table-column> -->
              <el-table-column
                prop="courseId"
                label="课程编号"
                align="center"></el-table-column>
              <el-table-column
                prop="courseName"
                label="课程名称"
                align="center"></el-table-column>
              <el-table-column
                prop="teacherId"
                label="教师编号"
                align="center"></el-table-column>
              <el-table-column
                prop="teacherName"
                label="教师姓名"
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
                    @click="choose(scope.row.id)"
                    v-if="user.role === 'STUDENT'"
                    >选课</el-button
                  >
                  <el-button
                    size="mini"
                    type="danger"
                    plain
                    @click="del(scope.row.id)"
                    v-if="user.role === 'TEACHER'"
                    >退选</el-button
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
  data() {
    return {
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      arrangeData: [],
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      searchType: "", // 查询类型
      searchValue: "", // 查询值
    };
  },
  mounted() {
    this.loadArrange(1);
  },
  methods: {
    // 加载课程安排数据
    loadArrange(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      const params = {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      };
      if (this.searchValue) {
        params[this.searchType] = this.searchValue;
      }
      this.$request.get("/arrange/selectPage", { params }).then((res) => {
        if (res.code === "200") {
          this.arrangeData = res.data?.list;
          this.total = res.data?.total;
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    // 处理分页变化
    handleCurrentChange(pageNum) {
      this.loadArrange(pageNum);
    },
    // 跳转函数
    navTo(url) {
      location.href = url;
    },
    choose(id) {
      // 学生选课
      this.$confirm("您确定选课吗？", "确认选课", { type: "info" })
        .then(() => {
          this.$request.post("/arrange/choose/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("选课成功");
            } else {
              this.$message.success("已选择该课程！"); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    // 教师退选
    del(id) {
      this.$request.delete("/arrange/delete/" + id).then((res) => {
        if (res.code === "200") {
          this.$message.success("退选成功");
          this.loadArrange(1);
        } else {
          this.$message.error("已有学生选择课程,退选失败!");
        }
      });
    },
    // 重置查询条件
    reset() {
      this.searchType = "";
      this.searchValue = "";
      this.loadArrange(1);
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
