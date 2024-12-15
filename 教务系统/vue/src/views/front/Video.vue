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
            <div style="flex: 3; margin-left: 20px">视频信息</div>
            <!-- 查找 -->
            <div class="search">
              <el-input
                placeholder="请输入话题查询"
                style="width: 200px"
                v-model="topic"></el-input>
              <el-button
                type="info"
                plain
                style="margin-left: 10px"
                @click="loadvideo(1)"
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
          <!-- 表格内容 -->
          <div class="table">
            <el-table
              :data="videoData"
              strip
              @selection-change="handleSelectionChange">
              <!-- <el-table-column
                prop="id"
                label="序号"
                width="70"
                align="center"
                sortable></el-table-column> -->
              <el-table-column
                prop="topic"
                label="话题"
                align="center"></el-table-column>

              <el-table-column
                prop="filename"
                label="视频"
                show-overflow-tooltip
                align="center"
></el-table-column>

              <el-table-column
                prop="teacherName"
                label="拍摄作者"
                show-overflow-tooltip
                align="center"
></el-table-column>
            </el-table>
            <!-- 分页 -->
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
      videoData: [],
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      formVisible: false,
      form: {},
      topic: null,
    };
  },

  // mounted：页面加载完毕后立即执行的函数
  mounted() {
    this.loadvideo(1);
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadvideo(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .get("/video/selectPage", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            topic: this.topic, // 搜索时候输入话题
          },
        })
        .then((res) => {
          if (res.code === "200") {
            this.videoData = res.data?.list;
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
    // 分页
    handleCurrentChange(pageNum) {
      this.loadvideo(pageNum);
    },

    // 跳转函数
    navTo(url) {
      location.href = url;
    },
    reset() {
      this.topic = null;
      this.loadvideo(1);
    },
  },
};
</script>
