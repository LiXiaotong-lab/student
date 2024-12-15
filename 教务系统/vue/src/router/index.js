import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

// 解决导航栏或者底部导航tabBar中的vue-router在3.0版本以上频繁点击菜单报错的问题。
const originalPush = VueRouter.prototype.push;
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};

const routes = [
  {
    path: "/",
    name: "Manager",
    component: () => import("../views/Manager.vue"),
    redirect: "/front/home",
    children: [
      {
        path: "403",
        name: "NoAuth",
        meta: { name: "无权限" },
        component: () => import("../views/manager/403"),
      },
      {
        path: "home",
        name: "Home",
        meta: { name: "系统首页" },
        component: () => import("../views/manager/Home"),
      },
      {
        path: "admin",
        name: "Admin",
        meta: { name: "管理员信息" },
        component: () => import("../views/manager/Admin"),
      },

      {
        path: "adminPerson",
        name: "AdminPerson",
        meta: { name: "个人信息" },
        component: () => import("../views/manager/AdminPerson"),
      },

      {
        path: "teacherPerson",
        name: "TeacherPerson",
        meta: { name: "个人信息" },
        component: () => import("../views/manager/TeacherPerson"),
      },
      {
        path: "studentPerson",
        name: "StudentPerson",
        meta: { name: "个人信息" },
        component: () => import("../views/manager/StudentPerson"),
      },

      {
        path: "timetable",
        name: "Timetable",
        meta: { name: "选课信息" },
        component: () => import("../views/manager/Timetable"),
      },
      {
        path: "arrange",
        name: "Arrange",
        meta: { name: "教师选课信息" },
        component: () => import("../views/manager/Arrange"),
      },

      {
        path: "password",
        name: "Password",
        meta: { name: "修改密码" },
        component: () => import("../views/manager/Password"),
      },
      {
        path: "notice",
        name: "Notice",
        meta: { name: "公告信息" },
        component: () => import("../views/manager/Notice"),
      },
      {
        path: "live",
        name: "Live",
        meta: { name: "直播信息" },
        component: () => import("../views/manager/Live"),
      },
      {
        path: "student",
        name: "Student",
        meta: { name: "学生信息" },
        component: () => import("../views/manager/Student"),
      },
      {
        path: "teacher",
        name: "Teacher",
        meta: { name: "老师信息" },
        component: () => import("../views/manager/Teacher"),
      },
      {
        path: "course",
        name: "Course",
        meta: { name: "课程信息" },
        component: () => import("../views/manager/Course"),
      },
      {
        path: "college",
        name: "College",
        meta: { name: "学院信息" },
        component: () => import("../views/manager/College"),
      },
      {
        path: "major",
        name: "Major",
        meta: { name: "专业信息" },
        component: () => import("../views/manager/Major"),
      },

      {
        path: "video",
        name: "Video",
        meta: { name: "视频信息" },
        component: () => import("../views/manager/Video"),
      },
    ],
  },
  {
    path: "/front",
    name: "Front",
    component: () => import("../views/Front.vue"),
    children: [
      {
        path: "home",
        name: "Home",
        meta: { name: "系统首页" },
        component: () => import("../views/front/Home"),
      },
      {
        path: "person",
        name: "Person",
        meta: { name: "个人信息" },
        component: () => import("../views/front/Person"),
      },

      {
        path: "video",
        name: "Video",
        meta: { name: "视频信息" },
        component: () => import("../views/front/Video"),
      },
      {
        path: "live",
        name: "Live",
        meta: { name: "直播信息" },
        component: () => import("../views/front/Live"),
      },
      {
        path: "college",
        name: "College",
        meta: { name: "学院信息" },
        component: () => import("../views/front/College"),
      },
      {
        path: "major",
        name: "Major",
        meta: { name: "专业信息" },
        component: () => import("../views/front/Major"),
      },
      {
        path: "course",
        name: "Course",
        meta: { name: "课程信息" },
        component: () => import("../views/front/Course"),
      },
      {
        path: "arrange",
        name: "Arrange",
        meta: { name: "教师开课信息" },
        component: () => import("../views/front/Arrange"),
      },
      {
        path: "timetable",
        name: "Timetable",
        meta: { name: "选课记录" },
        component: () => import("../views/front/Timetable"),
      },
    ],
  },
  {
    path: "/login",
    name: "Login",
    meta: { name: "登录" },
    component: () => import("../views/Login.vue"),
  },
  {
    path: "/register",
    name: "Register",
    meta: { name: "注册" },
    component: () => import("../views/Register.vue"),
  },
  {
    path: "*",
    name: "NotFound",
    meta: { name: "无法访问" },
    component: () => import("../views/404.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

// 注：不需要前台的项目，可以注释掉该路由守卫
// 路由守卫
// router.beforeEach((to ,from, next) => {
//   let user = JSON.parse(localStorage.getItem("xm-user") || '{}');
//   if (to.path === '/') {
//     if (user.role) {
//       if (user.role === 'USER') {
//         next('/front/home')
//       } else {
//         next('/home')
//       }
//     } else {
//       next('/login')
//     }
//   } else {
//     next()
//   }
// })

export default router;
