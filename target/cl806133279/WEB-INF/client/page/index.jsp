<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>ssm+jsp的图书管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/animate.min.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/wow.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.js"></script>
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
            <div class="swiper-row">
                <page-swiper></page-swiper>
            </div>
            <div class="news-row">
                <!-- 公告通知 -->
                <div class="news-box">
                    <div class="title"><span>公告通知</span></div>
                    <div class="list">
                        <div class="item" v-for="item in newsList" :key="item.id" @click="newsDetailClick(item.id)">
                            <img v-if="isHttp(item.picture)" :src="item.picture.split(',')[0]">
                            <img v-else :src="item.picture?baseUrl + item.picture.split(',')[0]:''">
                            <div class="info">
                                <div class="news-title">{{item.title}}</div>
                                <div class="news-introduction">{{item.introduction}}</div>
                                <div class="news-addTime">{{item.addtime.split(' ')[0]}}</div>
                            </div>
                        </div>
                    </div>
                    <div class="more" @click="moreClick('news')">
                        <span>查看更多</span>
                    </div>
                </div>
            </div>
            <div class="recommend-row">
                <template v-if="shujixinxiRecomList?.length">
                    <!-- 书籍信息推荐 -->
                    <div class="recommend-box">
                        <div class="title"><span>书籍信息推荐</span></div>
                        <div class="list">
                            <div class="item" v-for="item in shujixinxiRecomList" :key="item.id" @click="detailClick('shujixinxi',item.id)">
                                <img v-if="isHttp(item.fengmian)" :src="item.fengmian.split(',')[0]">
                                <img v-else :src="item.fengmian?baseUrl + item.fengmian.split(',')[0]:''">
                                <div class="info">
                                    <div class="info-item">书籍名称：{{item.shujimingcheng}}</div>
                                    <div class="info-item">书籍分类：{{item.shujifenlei}}</div>
                                    <div class="info-item">ISBN：{{item.bianma}}</div>
                                </div>
                            </div>
                        </div>
                        <div class="more" @click="moreClick('shujixinxi')">
                            <span>查看更多</span>
                        </div>
                    </div>
                </template>
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
            return {
                shujixinxiRecomList:[],
                newsList:[],
                token:toolUtil.storageGet("Token"),
            }
        },
        created(){
            this.init()
        },
        methods: {
            init(){
                this.getshujixinxiRecomList()
                this.getNewsList()
            },
            //书籍信息推荐
            getshujixinxiRecomList(){
                let autoSortUrl = 'shujixinxi/autoSort'
                if(toolUtil.storageGet('Token')){
                    autoSortUrl = "shujixinxi/autoSort2"
                }
                http.get(autoSortUrl,{
                    params:{
                        page: 1,
                        limit: 8
                    }
                }).then(res=>{
                    this.shujixinxiRecomList = res.data.data.list
                })
            },
            getNewsList(){
                http.get('news/list',{
                    params:{
                        page:1,
                        limit:7
                    }
                }).then(res=>{
                    this.newsList = res.data.data.list
                })
            },
            newsDetailClick(id=null){
                if(id){
                    location.href = `news/detail?id=`+id
                }
            },
            //判断图片链接是否带http
            isHttp(str){
                return str && str.substr(0,4)=='http';
            },
            //跳转详情
            detailClick(table,id){
                location.href = table + `/detail?id=` + id
            },
            moreClick(table){
                location.href = table +  `/list`
            },
        }
    })
</script>
<script>
//须先设置css盒子的animation-duration

new WOW({
    boxClass: 'search-box', //目标dom的class
    animateClass: 'animate__fadeInDown', //动画名
}).init()

new WOW({
    boxClass: 'recommend-box',
    animateClass: 'animate__fadeInUp',
}).init()

new WOW({
    boxClass: 'about-box',
    animateClass: 'animate__fadeInUp',
}).init()

new WOW({
    boxClass: 'show-box',
    animateClass: 'animate__fadeInLeft',
}).init()

new WOW({
    boxClass: 'news-box',
    animateClass: 'animate__fadeInRight',
}).init()

new WOW({
    boxClass: 'systemInfo-box',
    animateClass: 'animate__fadeInUp',
}).init()


</script>
<style>

.el-main {
    padding:0;
}





/*轮播图盒子*/
.swiper-row{
   width: 80%;
   margin: 20px auto;
   border: 0px solid #ffffff;
}
.swiper-wrapper{
}
.swiper-wrapper .swiper-slide .item{
   width: 100%;
}
.swiper-wrapper .swiper-slide .item img{
   width: 100%;
   height: 450px;
   object-fit:cover;
   border-radius:30px;
}
/*自定义分页器样式*/
.swiper-pagination{ margin-bottom:15px; }
.swiper-pagination span{ width:8px; height:8px; background:var(--swiper-theme-color); border-radius:100%;
}
/*信息展示*/
.recommend-row{
    width:var(--body-width);
    margin: 20px auto;
    position: relative;
    order:2;
}
/*信息总盒子*/
.recommend-box {
    width: 100%;
    background: none;
    margin: 40px auto;
    padding: 0px;
    position: relative;
}

.recommend-box .title{
    width:100%;
    font-size: 26px;
    color: #000000;
    text-align: left;
    padding-left:100px; 
    font-weight: 500;
    height:90px;
    line-height: 60px;
    background:url('http://clfile.zggen.cn/20251105/20c0fb3469164cdd9f4c6c590ae25e5f.png')no-repeat left center;
    margin-bottom:20px;
}
.recommend-box .title span {
    position: relative;
}
.recommend-box .title span:before {
    content: "ProductList";
    position: absolute;
    top: 18px;
    left: 0px;
}

/*信息盒子*/
.recommend-box .list {
    width: calc(100% + 20px);
    display: flex;
    flex-wrap: wrap;
    margin: 30px 0 0 -10px;
    background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(255,247,242,1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102,102,102,0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding: 30px 10px 10px;   
}
.recommend-box .list .item {
    width: calc(25% - 20px);
    margin: 0 10px 20px;
    overflow: hidden;
    background: #fff;
    padding: 10px 20px;
    border-radius: 20px;
    display: flex;
}
.recommend-box .list .item:hover {
    cursor: pointer;
}
/*图片*/
.recommend-box .list .item img{
    width: calc(50% - 10px);
    height: 100px;
    object-fit: cover;
    border-radius: 10px;
    margin:0 10px 0 0;
}
/*内容盒子*/
.recommend-box .list .item .info{
    width: calc(50% - 0px);
    height: 100%;
    object-fit: cover;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-content: center;
    background: none;
    flex:1;
}
/*标题*/
.recommend-box .info .info-item{
    width:100%;
    padding: 2px 0px;
    color: #333;
    text-align: left;
    margin-bottom: 0px;
    display:-webkit-box;
    text-overflow:ellipsis;
    overflow:hidden; 
    -webkit-line-clamp:3;
    -webkit-box-orient:vertical;
}
.recommend-box .info .price{
    width:100%;
    padding: 2px 0px;
    color: #f00;
}

/* 更多 */
.recommend-box .more{
   position:absolute;
   top:30px;
   right:0;
   cursor: pointer;
}
.recommend-box .more span{
   font-weight: 400;
   font-size: 16px;
   color:#B2B3B5;
   border-radius:10px;
   padding:5px 10px;
   font-weight: 400;
   font-size: 20px;
   background:url('http://clfile.zggen.cn/20251105/3408dd841a294b9eb357e34e70486a9b.png')left center no-repeat;
   padding-left:180px
}
/*end*/
.news-row{
    width: 100%;
}
/*新闻资讯*/
.news-box {
    width:var(--body-width);
    margin: 20px auto;
    position: relative;
}

.news-box .title{
    width:100%;
    font-size: 26px;
    color: #000000;
    text-align: left;
    padding-left:100px; 
    font-weight: 500;
    height:90px;
    line-height: 60px;
    background:url('http://clfile.zggen.cn/20251105/3af3fa29213d4428bbd0fe91a8821a8c.png') no-repeat left center;
    margin-bottom:20px;
}
.news-box .title span {
    position: relative;
}
.news-box .title span:before {
    content: "NewsCenter";
    position: absolute;
    top: 18px;
    left: 0px;
}

.news-box .list {
    margin-top: 20px;
    display: flex;
    flex-wrap:wrap;
    background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(255,247,242,1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102,102,102,0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding:20px 20px 20px 600px;
    position:relative;
}
.news-box .item {
    width:100%;
    display: flex;
    flex-wrap:wrap;
    padding: 10px;
    cursor: pointer;
    height: auto;
    margin:0 0 10px;
    background: #fff;
    border-radius: 20px 20px 20px 20px;
    border: 1px solid #eee;
}
.news-box .item img {
    width: 160px;
    height: 120px;
    flex-shrink: 0;
    object-fit: cover;
    margin-right: 16px;
    border-radius: 4px;
    display: none; 
}
.news-box .item .info {
    width: 100%;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
}
.news-box .item .info .news-title {
    font-weight: 700;
    font-size: 16px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.news-box .item .info .news-introduction {
    line-height: 22px;
    margin-top: 10px;
    color: #666;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
}
.news-box .item .info .news-addTime {
    margin-top: auto;
    text-align: right;
    color: #999;
    font-size: 14px;
}

.news-box .item:first-child {
    width:550px;
    position: absolute;
    left:20px;
    top:20px;
    padding:0;
    background: none; 
    box-shadow: none;  
    border-radius: 0;
    border: 0;
}
.news-box .item:first-child img{
    display: block; 
    width: 100%;
    height: 380px;
    object-fit: cover;
    border-radius: 20px;
    margin:0 0 20px;
}
.news-box .item:first-child .info {
    background: #fff;
    border-radius: 20px 20px 20px 20px;
    padding:20px;
    height:235px;
    border: 1px solid #eee;
}
.news-box .item:first-child .info .news-introduction {
    line-height: 22px;
    margin-top: 10px;
    color: #666;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 4;
    -webkit-box-orient: vertical;
}

/* 更多 */
.news-box .more{
   position:absolute;
   top:30px;
   right:0;
   cursor: pointer;
}
.news-box .more span{
   font-weight: 400;
   font-size: 16px;
   color:#B2B3B5;
   border-radius:10px;
   padding:5px 10px;
   font-weight: 400;
   font-size: 20px;
   background:url('http://clfile.zggen.cn/20251105/3408dd841a294b9eb357e34e70486a9b.png')left center no-repeat;
   padding-left:180px
}
/*end*/
</style>
</html>
