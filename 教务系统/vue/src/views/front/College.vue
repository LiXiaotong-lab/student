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
            <div style="flex: 3; margin-left: 20px">学院信息</div>
            <!-- 查找 -->
            <div class="search">
              <el-input
                placeholder="请输入学院名称查询"
                style="width: 200px"
                v-model="name"></el-input>
              <el-button
                type="info"
                plain
                style="margin-left: 10px"
                @click="loadCollege(1)"
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
              :data="collegeData"
              strip
              @selection-change="handleSelectionChange">
              <!-- <el-table-column
                prop="id"
                label="序号"
                width="70"
                align="center"
                sortable></el-table-column> -->
              <el-table-column
                prop="collegeId"
                label="学院编号"
                width="130"
                align="center"></el-table-column>
              <el-table-column
                prop="name"
                label="学院名称"
                width="250"
                align="center"></el-table-column>

              <el-table-column
                prop="description"
                label="学院描述"
                width="900"
                align="center"
                show-overflow-tooltip></el-table-column>
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
      collegeData: [],
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      formVisible: false,
      form: {},
      name: null, // 搜索的学院名称
    };
  },

  mounted() {
    this.loadCollege(1);
  },

  methods: {
    loadCollege(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .get("/college/selectPage", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.name, // 加入搜索条件
          },
        })
        .then((res) => {
          if (res.code === "200") {
            this.collegeData = res.data?.list;
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

    handleCurrentChange(pageNum) {
      this.loadCollege(pageNum);
    },
    // 跳转函数
    navTo(url) {
      location.href = url;
    },

    reset() {
      this.name = null;
      this.loadCollege(1);
    },
  },
};
</script>
