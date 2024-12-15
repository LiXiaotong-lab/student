<template>

  <div class="main-content">
    
    <div style="height: 60px; background-color: #C566F6FF"></div>
    <div style="display: flex">

      
      <div class="left"></div>
      <div style="width: 70%; background-color: #CEADE7; margin-bottom: 50px    border-radius: 50px">
        <div style="color: #666666; margin: 15px 15px 15px 15px; font-weight: bold; font-size: 20px">欢迎进入山河大学教务系统</div>

          <div style="flex: 5; margin-top: 15px">
            <div>
              <el-carousel height="150px" style="border-radius: 20px">
                <el-carousel-item v-for="item in carousel_top">
                  <img :src="item" alt="" style="width: 100%; height: 300px; border-radius: 10px">
                </el-carousel-item>
              </el-carousel>
            </div>
            
            <div style="margin-top: 20px; display: flex">
              <div style="flex: 1">
                <el-carousel height="200px" style="border-radius: 10px">
                  <el-carousel-item v-for="item in carousel_left">
                    <img :src="item" alt="" style="width: 100%; height: 200px; border-radius: 10px">
                  </el-carousel-item>
                </el-carousel>
              </div>
              <div style="flex: 1; margin-left: 5px">
                <el-carousel height="200px" style="border-radius: 10px">
                  <el-carousel-item v-for="item in carousel_right">
                    <img :src="item" alt="" style="width: 100%; height: 200px; border-radius: 10px">
                  </el-carousel-item>
                </el-carousel>
              </div>
            </div>
          </div>
          <div style="flex: 3; background-color: #CEADE7; margin-top: -30px; margin-left: 0px; margin-right: 0px; 
           
          border-radius: 15px">
            <div style="text-align: center; margin-top: 40px " >
              <img  :src="user.avatar" alt="" style="width: 110px; height: 105px; border-radius: 50%">
              <div style="margin-top: 10px">Hi，{{user.name}}</div>
            </div>
            
            <div style="margin: 20px 10px 10px 10px; width: 250px; white-space: nowrap; overflow: ; text-overflow: ellipsis">
              <i class="el-icon-bell"></i>
              <span style="font-weight: bold">公告</span>
              <span style="color: #000000;">：{{ top }}</span>
            </div>
            <div style="display: flex; margin-top: 20px"  >
             
               <div style="flex: 1; text-align: center">
  <a href="#" @click="navTo('/front/video')">
    <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
    <div style="margin-bottom: 20px">视频信息</div>
  </a>
</div>
               <div style="flex: 1; text-align: center">
  <a href="#" @click="navTo('/front/live')">
    <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
    <div style="margin-bottom: 20px">直播信息</div>
  </a>
</div>
               <div style="flex: 1; text-align: center">
  <a href="#" @click="navTo('/front/college')">
    <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
    <div style="margin-bottom: 20px">学院信息</div>
  </a>
</div>
               <div style="flex: 1; text-align: center">
  <a href="#" @click="navTo('/front/major')">
    <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
    <div style="margin-bottom: 20px">专业信息</div>
  </a>
</div>
              
             <div style="flex: 1; text-align: center">
  <a href="#" @click="navTo('/front/course')">
    <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
    <div style="margin-bottom: 20px">课程信息</div>
  </a>
</div>
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/arrange')">
                  <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
                  <div>教师开课信息</div>
                </a>
              </div>
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/timetable')">
                  <img src="@/assets/imgs/收藏.png" alt="" style="height: 25px; width: 25px">
                  <div>选课记录</div>
                </a>
              </div>
              
            </div>
          </div>
        </div>

      
      </div>
      <div class="right"></div>
    </div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      typeData: [],
      top: null,
      notice: [],
      goodsData: [],
      recommendData: [],
      // 上方轮播图
      carousel_top: [
        require('@/assets/imgs/carousel-1.png'),
        require('@/assets/imgs/carousel-2.png'),
        require('@/assets/imgs/carousel-3.png'),
      ],
      // 左侧轮播图
      carousel_left: [
        require('@/assets/imgs/carousel-4.png'),
        require('@/assets/imgs/carousel-5.png'),
        require('@/assets/imgs/carousel-6.png'),
      ],
      // 右侧轮播图
      carousel_right: [
        require('@/assets/imgs/carousel-7.png'),
        require('@/assets/imgs/carousel-8.png'),
        require('@/assets/imgs/carousel-9.png'),
      ],
    }
  },
  mounted() {
    this.loadType()
    this.loadNotice()
    this.loadGoods()
    this.loadRecommend()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadRecommend() {
      this.$request.get('/goods/recommend').then(res => {
        if (res.code === '200') {
          this.recommendData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    //公告
    loadType() {
      this.$request.get('/type/selectAll').then(res => {
        if (res.code === '200') {
          this.typeData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadNotice() {
      this.$request.get('/notice/selectAll').then(res => {
        this.notice = res.data
        let i = 0
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content
          setInterval(() => {
            this.top = this.notice[i].content
            i++
            if (i === this.notice.length) {
              i = 0
            }
          }, 2500)
        }
      })
    },
    
  
    navTo(url) {
      location.href = url
    },
  }
}
</script>

<style scoped>
.main-content {
  min-height: 100vh;
  /*overflow: hidden;*/
  background-size: 100%;
  background-image: url('@/assets/imgs/img.png');
}
.left {
  width: 17%;
  background-repeat: no-repeat;
  /* background-image: url('@/assets/imgs/left-img.png'); */
}
.right {
  width: 17%;
  background-repeat: no-repeat;
  background-image: url('@/assets/imgs/right-img.png')
}
.el-col-5{
  width: 20%;
  max-width: 20%;
  padding: 10px 10px;
}
</style>