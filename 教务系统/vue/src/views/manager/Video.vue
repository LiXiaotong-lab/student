<template>
  <div>
    <!-- 查找 -->
    <div class="search">
      <el-input
        placeholder="请输入话题查询"
        style="width: 200px"
        v-model="topic"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)"
        >查询</el-button
      >
      <el-button type="warning" plain style="margin-left: 10px" @click="reset"
        >重置</el-button
      >
    </div>
    <!-- 增加，删除按钮 -->

    <div class="operation">
      <el-button
        type="primary"
        v-if="user.role === 'ADMIN' || user.role === 'TEACHER'"
        plain
        @click="handleAdd"
        >新增</el-button
      >
      <el-button
        type="danger"
        plain
        @click="delBatch"
        v-if="user.role === 'ADMIN'"
        >批量删除</el-button
      >
    </div>

    <div class="table">
      <el-table :data="tableData" border fit stripe
        @selection-change="handleSelectionChange">
        <!-- 多选 -->
        <el-table-column
          type="selection"
          width="55"
          align="center"
          v-if="user.role === 'ADMIN'"></el-table-column>
<!-- 
        <el-table-column
          prop="id"
          label="序号"
          width="80"
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
          width="270"></el-table-column>

        <el-table-column
          prop="teacherName"
          label="拍摄作者"
          show-overflow-tooltip
          align="center"
          width="180"></el-table-column>

        <!-- 信息后面的操作按钮 -->
        <el-table-column
          label="操作"
          align="center"
          width="180"
          v-if="user.role === 'ADMIN'">
          <template v-slot="scope">
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              >编辑</el-button
            >
            <el-button
              size="mini"
              type="danger"
              plain
              @click="del(scope.row.id)"
              v-if="user.role === 'ADMIN' || user.role === 'TEACHER'"
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
        <!-- 编辑信息---------------------------------------------------- -->
        <el-dialog
          title="视频信息"
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
            <el-form-item label="话题" prop="topic">
              <el-input v-model="form.topic" placeholder="话题"></el-input>
            </el-form-item>

            <el-form-item label="视频" prop="filename">
              <el-input v-model="form.filename" placeholder="视频"></el-input>
            </el-form-item>
            <el-form-item label="拍摄作者" prop="author">
              <el-input
                v-model="form.author"
                placeholder="拍摄作者(请输入教师编号)"></el-input>
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
      tableData: [], // 所有的数据
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
topic: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
topic: [{ required: true, message: "请输入话题", trigger: "blur" }],
filename: [{ required: true, message: "请输入直播内容", trigger: "blur" }],
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
            url: this.form.id ? "/video/update" : "/video/add",
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
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/video/delete/" + id).then((res) => {
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
            .delete("/video/delete/batch", { data: this.ids })
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
      this.$request
        .get("/video/selectPage", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            topic: this.topic,
          },
        })
        .then((res) => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
    },
    reset() {
      this.topic = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
   
  },
};
</script>

<style scoped></style>
