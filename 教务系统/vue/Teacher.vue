<template>
  <div>
    <!-- 查找 -->
    <div class="search">
      <el-input
        placeholder="请输入教师编号查询"
        style="width: 200px"
        v-model="username"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)"
        >查询</el-button
      >
      <el-button type="warning" plain style="margin-left: 10px" @click="reset"
        >重置</el-button
      >
    </div>
    <!-- 增加按钮 -->
    <div class="operation">
      <el-button type="primary" plain @click="handleAdd">新增</el-button>

    </div>

    <div class="table">
      <el-table :data="tableData" border fit stripe
        @selection-change="handleSelectionChange">
        <!-- 多选 -->
        <!-- <el-table-column
          type="selection"
          width="55"
          align="center"></el-table-column> -->

        <el-table-column
          prop="id"
          label="序号"
          width="80"
          align="center"
          sortable></el-table-column>

        <el-table-column
          prop="username"
          label="教师编号"
          width="130"
          align="center"></el-table-column>
        <el-table-column
          prop="collegeName"
          label="学院"
          width="200"
          align="center"></el-table-column>

        <el-table-column
          prop="name"
          label="姓名"
          width="90"
          align="center"></el-table-column>
        <el-table-column
          prop="sex"
          label="性别"
          width="50"
          align="center"></el-table-column>
        <el-table-column
          prop="phone"
          label="电话"
          width="130"
          align="center"></el-table-column>
        <el-table-column
          prop="email"
          label="电子邮箱"
          show-overflow-tooltip
          align="center"></el-table-column>
        <el-table-column
          prop="office"
          label="办公地点"
          width="150"
          align="center"></el-table-column>
        <el-table-column
          prop="condi"
          label="状态"
          width="150"
          align="center"></el-table-column>
        <!-- 信息后面的操作按钮 -->
        <el-table-column label="操作" align="center" width="180"  v-if="user.role === 'ADMIN'">
          <template v-slot="scope">
            <el-button
              size="mini"
              type="primary"
              plain
              @click="handleEdit(scope.row)"
              >编辑</el-button
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
          title="教师信息"
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
            <el-form-item label="教师编号" prop="username">
              <el-input
                v-model="form.username"
                placeholder="教师编号"></el-input>
            </el-form-item>
            <el-form-item label="学院" prop="collegeId">
              <el-input
                v-model="form.collegeId"
                placeholder="学院(请输入学院编号)"></el-input>
            </el-form-item>

            <el-form-item label="姓名" prop="name">
              <el-input v-model="form.name" placeholder="姓名"></el-input>
            </el-form-item>

            <el-form-item label="性别" prop="sex">
              <el-input v-model="form.sex" placeholder="性别"></el-input>
            </el-form-item>

            <el-form-item label="电话" prop="phone">
              <el-input v-model="form.phone" placeholder="电话"></el-input>
            </el-form-item>
            <el-form-item label="电子邮箱" prop="email">
              <el-input v-model="form.email" placeholder="电子邮箱"></el-input>
            </el-form-item>

            <el-form-item label="办公地点" prop="office">
              <el-input v-model="form.office" placeholder="办公地点"></el-input>
            </el-form-item>
            <el-form-item label="状态" prop="condi">
              <el-input v-model="form.condi" placeholder="状态"></el-input>
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
      username: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
        username: [{ required: true, message: "请输入编号", trigger: "blur" }],
        name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
        collegeId: [
          { required: true, message: "请输入学院(学院编号)", trigger: "blur" },
        ],
        sex: [{ required: true, message: "请输入性别", trigger: "blur" }],
        phone: [{ required: true, message: "请输入电话", trigger: "blur" }],
        email: [{ required: true, message: "请输入邮箱", trigger: "blur" }],
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
            url: this.form.id ? "/teacher/update" : "/teacher/add",
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
      this.ids = rows.map((v) => v.id);
    },
  
    load(pageNum) {
      // 分页查询
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .get("/teacher/selectPage", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
          },
        })
        .then((res) => {
          this.tableData = res.data?.list;
          this.total = res.data?.total;
        });
    },
    reset() {
      this.username = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
    handleAvatarSuccess(response, file, fileList) {
      // 把头像属性换成上传的图片的链接
      this.form.avatar = response.data;
    },
  },
};
</script>

<style scoped></style>
