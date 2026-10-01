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
                        </el-breadcrumb>
                    </div>
                    <div class="search">
                        <el-form :inline="true" >
                            <el-form-item class="input-item">
                                <el-input v-model="searchQuery.title" placeholder="标题"></el-input>
                            </el-form-item>
                            <el-form-item class="btn-item">
                                <el-button @click="searchClick" type="primary">搜索</el-button>
                            </el-form-item>
                        </el-form>
                    </div>
                    <div class="newsList">
                        <template v-for="(item,index) in list" :key="index">
                            <div class="news" @click="newsDetail(item.id)">
                                <div class="img-wrapper">
                                                                        <el-image v-if="isHttp(item.picture)" :src="item.picture.split(',')[0]"></el-image>
                                    <el-image v-else :src="item.picture?baseUrl + item.picture.split(',')[0]:''"></el-image>
                                </div>
                                <div class="title-wrapper">
                                    <div class="news-title">{{item.title}}</div>
                                    <div class="news-intro">{{item.introduction}}</div>
                                    <div class="new-time">{{moment(item.addtime).format('YYYY-MM-DD HH:mm:ss')}}</div>
                                </div>
                            </div>
                        </template>
                    </div>
                    <div class="pagination-row">
                        <el-pagination :total="total"
                                       :page-size="listQuery.limit"
                                       :current-page.sync="listQuery.page"
                                       @current-change="currentChange"
                                       layout="prev, pager, next" :background="true" :hide-on-single-page="true" >
                        </el-pagination>
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
                tableName:'news',
                formName:'公告通知',
                list:[],
                listLoading:false,
                listQuery:{
                    page: 1,
                    limit: 6,
                    sort: 'addtime',
                    order: 'desc'
                },
                searchQuery:{
                    title:''
                },
                total:0,
                //判断是否从个人中心跳转
                centerType:false,
            }
        },
        created(){
            if (toolUtil.getUrlParamsByKey("centerType")) {
                this.centerType = true
            }
            this.getList()
        },
        methods: {
            
            currentChange(page){
                this.listQuery.page = page
                this.getList()
            },
            btnAuth(e, a){
                return toolUtil.isAuth(e, a)
            },
            searchClick(size){
                this.listQuery.page = 1
                this.getList()
            },
            getList(){
                this.listLoading = true
                let params = JSON.parse(JSON.stringify(this.listQuery))
                if (this.searchQuery.title.trim() != '') {
                    params['title'] = `%`+this.searchQuery.title+`%`
                }
                http.get(`news/list`,{params}).then(res=>{
                    this.listLoading = false
                    this.list = res.data.data.list
                    this.total = res.data.data.total
                })
            },
            newsDetail(id){
                if (id) {
                    location.href = baseUrl+`client/news/detail?id=`+id
                }
            },
             isHttp(str){
                return str && str.substr(0,4)=='http';
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
    margin: 30px auto 0;
    background-color: none;
    padding: 0px 30px 30px;
    border-radius: 0px;
    box-sizing: border-box;
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


.content-box .search{
    width:100%;
    text-align:center;
}
.content-box .search .el-input__inner{
    width:450px;
    height:44px;
    line-height:44px;
}
.content-box .search .el-input__inner:hover{
    border-color: var(--theme);
}
.el-input__inner:focus {
    outline: none;
    border-color: var(--theme);
}
.content-box .search .el-button--primary {
    color: #fff;
    background: var(--theme);
    border-color: var(--theme);
    height:44px;
    line-height:44px;
    min-width:90px;
}


.newsList {
    width: calc(100% + 20px);   
    display: flex;
    flex-wrap: wrap;
    margin: 20px auto 0 -10px;
    background: linear-gradient(180deg, rgba(255, 255, 255, 1) 0%, rgba(255, 247, 242, 1) 100%);
    box-shadow: inset 0px -20px 30px 0px #FFFFFF, inset 0px 10px 10px 0px rgba(102, 102, 102, 0.13);
    border-radius: 30px 30px 30px 30px;
    border: 2px solid #FFFFFF;
    padding: 30px 20px 20px;
}

.newsList .news {
    width: calc(50% - 0px);
    display: flex;
    flex-wrap: wrap;
    margin: 0px 0px 10px;
    padding: 30px;
    cursor: pointer;
    background: url(https://clfile.zggen.cn/20251105/048311ecedfa4d758bb067a3959b9816.png) no-repeat;
    background-size: 100% 100%;
    border-radius: 15px;
}
.newsList .news:hover{
}
.newsList .news:hover .news-title{
    color:var(--swiper-theme-color);
}
.newsList .news:hover  .title-wrapper .news-intro{
 color:var(--swiper-theme-color);
}


.newsList .news:nth-child(odd){
}

.newsList .news:nth-child(even){
}
.newsList .news .el-image {
    width: 100%;
    height: auto;
    flex-shrink: 0;
    margin-right: 20px;
    display: block;
}
.newsList .news .el-image img {
    width: 140px;
    height: 100px;
    object-fit: cover;
    border-radius: 10px;
}


.newsList .news .title-wrapper {
    width: 0;
    flex: 1;
    display: flex;
    flex-direction: column;
}
.newsList .news .title-wrapper .news-title {
    width:100%;
    font-size: 16px;
    font-weight: 600;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.newsList .news .title-wrapper .news-intro {
    color: #666;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    margin-top: 14px;
    line-height: 1.6em;
}
.newsList .news .title-wrapper .new-time {
    margin-top: auto;
    text-align: right;
    color: #999;
}


.pagination-row {
    text-align: center;
    margin-top: 30px;
}

</style>
</html>
