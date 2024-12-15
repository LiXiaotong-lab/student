<template>
  <div>
    <!-- 查找 -->
    <div class="search">
      <el-input
        placeholder="请输入学院名称查询"
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
    <div class="operation"  v-if="user.role === 'ADMIN'">
      <el-button type="primary" plain @click="handleAdd">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <!-- 表格内容 -->
    <div class="table">
      <el-table :data="tableData" border fit stripe
        @selection-change="handleSelectionChange">
        <!-- 多选 -->
        <el-table-column
          type="selection"
          width="55"
          align="center"   v-if="user.role === 'ADMIN'"></el-table-column>

        <!-- <el-table-column
          prop="id"
          label="序号"
          width="80"
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
          width="820"
          align="center"
          show-overflow-tooltip></el-table-column>

        <!-- 信息后面的操作按钮 -->
        <el-table-column label="操作" align="center" width="180"   v-if="user.role === 'ADMIN'">
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
        title="学院信息"
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
          <el-form-item label="学院编号" prop="collegeId">
            <el-input
              v-model="form.collegeId"
              placeholder="学院编号"></el-input>
          </el-form-item>
          <el-form-item label="学院名称" prop="name">
            <el-input v-model="form.name" placeholder="学院名称"></el-input>
          </el-form-item>
          <el-form-item label="学院描述" prop="description">
            <el-input
              v-model="form.description"
              placeholder="学院描述"></el-input>
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
collegeId: [{ required: true, message: "请输入学院编号", trigger: "blur" }],
        name: [{ required: true, message: "请输入学院名称", trigger: "blur" }],
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
            url: this.form.id ? "/college/update" : "/college/add",
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
          this.$request.delete("/college/delete/" + id).then((res) => {
            if (res.code === "200") {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error("此学院已存在专业或者教师，无法删除！"); // 弹出错误的信息
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
            .delete("/college/delete/batch", { data: this.ids })
            .then((res) => {
              if (res.code === "200") {
                // 表示操作成功
                this.$message.success("操作成功");
                this.load(1);
              } else {
                this.$message.error("存在学院已有专业或者教师，无法删除！"); // 弹出错误的信息
              }
            });
        })
        .catch(() => {});
    },
    load(pageNum) {
      // 分页查询
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .get("/college/selectPage", {
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
    reset() {
      this.name = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
  },
};
</script>

<style scoped></style>
