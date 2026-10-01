<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>公告通知</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/animate.min.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/wow.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-header height="auto" id="pageHeader">
        <page-header></page-header>
            <nav-menu></nav-menu>
    </el-header>
    <el-container>
        <el-main id="main">
            <div id="child-page">
                <page-swiper></page-swiper>
                <div class="content-box">
                    <div class="header">
                        <el-button size="small" @click="history.go(-1)">返回</el-button>
                        <el-breadcrumb separator-class="el-icon-arrow-right" >
                            <el-breadcrumb-item>首页</el-breadcrumb-item>
                            <el-breadcrumb-item>公告通知</el-breadcrumb-item>
                            <el-breadcrumb-item>详情</el-breadcrumb-item>
                        </el-breadcrumb>
                    </div>
                    <div class="news-content">
                        <div class="news-title"><span>{{info.title}}</span></div>
                        <div class="news-time">发布时间：{{moment(info.addtime).format('YYYY-MM-DD HH:mm:ss')}}</div>
                        <div class="news-picture" v-if="info.picture">
                                                             <el-image v-if="isHttp(info.picture)" :src="info.picture.split(',')[0]"></el-image>
                            <el-image v-else :src="info.picture?baseUrl + info.picture.split(',')[0]:''"></el-image>
                        </div>
                        <div class="article" v-html="info.content"></div>
                    </div>
                </div>
            </div>
        </el-main>
    </el-container>
    <el-footer height="auto">
        
            </el-footer>
</el-container>
</body>
<script src="${pageContext.request.contextPath}/static/client/static/modules/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/system.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/global_mixin.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/toolUtil.js"></script>
<!--引入组件-->
<script src="${pageContext.request.contextPath}/static/client/components/page-header.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/nav-menu.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/swiper.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/page-swiper.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return{
                formName:'公告通知',
                //判断是否从个人中心跳转
                centerType:false,
                info:{},
                id:'',
            }
        },
        created(){
            this.id = toolUtil.getUrlParamsByKey("id")
            if(!this.id){
                location.href = `news/list`
                return
            }
            this.getInfo()
        },
        methods: {
              isHttp(str){
                return str && str.substr(0,4)=='http';
            },
            getInfo(){
                http.get(`news/detail/`+this.id).then(res=>{
                    this.info = res.data.data
                })
            },
        }
    })
</script>
<style>

.el-main {
    padding: 0 0 30px;
    background: #edeef0;
}


.swiper-wrapper{
   margin: 10px auto 0;
   padding:0;
}
.swiper-wrapper .swiper-slide .item{
   width: var(--body-width);
   margin: 10px auto 14px;
}
.swiper-wrapper .swiper-slide .item img{
   width:100%;
   height:400px;
   object-fit:cover;
   border-radius: 30px;
}

.swiper-pagination{ margin-bottom:15px; }
.swiper-pagination span{ width:8px; height:8px; background:var(--swiper-theme-color); border-radius:100%; }


.content-box {
    width: var(--body-width);
    margin: 20px auto;
    position: relative;
    background: linear-gradient(180deg, rgba(255, 255, 255, 1) 0%, rgba(255, 247, 242, 1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102, 102, 102, 0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding: 20px;
}


.content-box .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
    border-bottom: 1px solid #edeef0;
    height: 60px;
}

.content-box .header .el-breadcrumb{
}

.content-box .header .el-button{
    order:2;
}


.content-box  .news-content{
}
.news-title {
    text-align: center;
    font-size: 24px;
    font-weight: 600;
}


.action-row{
    display: flex;
    justify-content: space-between;
}

.action-row .collect_view{
}

.action-row .thumbs_view{
    display: flex;
    justify-content: space-between;
    gap:20px;
}
.action-row .thumbs_view .zan_view span{
    color:#666;
}

.news-time {
    text-align: center;
    padding: 20px 0 30px;
    border-bottom: 1px solid #edeef0;
    color: #999;
}
.news-picture {
    text-align: center;
    margin-top: 30px;
}
.news-picture .el-image {
   max-width: 50%;
}
.article {
    font-size: 16px;
    margin-top: 20px;
}
.comment_view {
    margin-top: 30px;
    border: 0px solid #ccc;
    padding: 0px;
}
.comment_view .title {
    font-size: 20px;
    line-height: 2em;
}
.comment {padding: 20px;}
.comment_user_img img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
}
.comment_top {
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.comment_user {
    display: flex;
    align-items: center;
    column-gap: 12px;
}
.comment_bottom {
    padding-left: 70px;
}
.comment_reply {
    padding-left: 20px;
}

</style>
</html>
