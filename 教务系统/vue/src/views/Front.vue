<template>
  <div>
    <!--头部-->
    <div class="front-header">
      <div class="front-header-left" @click="navTo('/front/home')">
        <img src="@/assets/imgs/logo.png" alt="" />
        <div class="title">山河大学教务系统</div>
      </div>

      <div class="front-header-center" style="text-align: right"></div>

      <div class="front-header-right">
        <div v-if="!user.username">
          <el-button @click="$router.push('/login')">登录</el-button>
          <el-button @click="$router.push('/register')">注册</el-button>
        </div>

        <div v-else>
          <el-dropdown>
            <div class="front-header-dropdown">
              <img :src="user.avatar" alt="" />
              <div style="margin-left: 10px">
                <span>{{ user.name }}</span
                ><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
              </div>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/home')">
                  后台
                </div>
              </el-dropdown-item>

              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/video')">
                  视频信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/live')">
                  直播信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/college')">
                  学院信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/major')">
                  专业信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/course')">
                  课程信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/arrange')">
                  教师开课信息
                </div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div
                  style="text-decoration: none"
                  @click="navTo('/front/timetable')">
                  选课记录
                </div>
              </el-dropdown-item>

              <el-dropdown-item>
                <div style="text-decoration: none" @click="logout">退出</div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <!--主体-->
    <div class="main-body">
      <router-view ref="child" @update:user="updateUser" />
    </div>
  </div>
</template>

<script>
export default {
  name: "FrontLayout",

  data() {
    return {
      top: "",
      notice: [],
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      name: null,
    };
  },

  mounted() {
    this.loadNotice();
  },

  methods: {
    loadNotice() {
      this.$request.get("/notice/selectAll").then((res) => {
        this.notice = res.data;
        let i = 0;
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content;
          setInterval(() => {
            this.top = this.notice[i].content;
            i++;
            if (i === this.notice.length) {
              i = 0;
            }
          }, 2500);
        }
      });
    },
    updateUser() {
      this.user = JSON.parse(localStorage.getItem("xm-user") || "{}"); // 重新获取下用户的最新信息
    },
    navTo(url) {
      location.href = url;
    },
    // 退出登录
    logout() {
      localStorage.removeItem("xm-user");
      this.$router.push("/login");
    },
    search() {
      let name = this.name ? this.name : "";
      location.href = "/front/search?name=" + name;
    },
  },
};
</script>

<style scoped>
@import "@/assets/css/front.css";
</style>
