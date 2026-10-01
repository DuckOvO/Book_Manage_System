<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>用户</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/animate.min.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/wow.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/formModel.css">
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
                <page-swiper></page-swiper>
                <div class="content-box">
                    <div class="header-wrapper">
                        <div class="header-view">
                            <el-button v-if="centerType" @click="history.go(-1)" :attr="{}" >返回</el-button>
                            <el-breadcrumb separator-class="el-icon-arrow-right" >
                                <el-breadcrumb-item>{{centerType?"个人中心":"首页"}}</el-breadcrumb-item>
                                <el-breadcrumb-item>用户</el-breadcrumb-item>
                            </el-breadcrumb>
                        </div>
                        <el-form class="search-view" :model="searchQuery" :inline="true" >
                            <el-form-item class="query-input" label="用户名">
                                <el-input class="search_inp" v-model="searchQuery.yonghuming" placeholder="用户名" clearable></el-input>
                            </el-form-item>
                            <el-form-item class="option-btn">
                                <el-button class="search-btn" type="primary" @click="searchClick">搜索</el-button>
                                <el-button class="add-btn" type="primary" v-if="btnAuth('yonghu','新增')" @click="addClick">新增</el-button>
                            </el-form-item>
                        </el-form>
                    </div>
                    <div class="category-wrapper">
                        <div class="list-view">
                            <div class="list" v-if="list.length">
                                <div class="item" v-for="(item,index) in list" :key="index" @click="detailClick(item.id)">
                                    <div class="img-wrapper">
                                    </div>
                                    <div class="infoItem-wrapper">
                                    </div>
                                </div>
                            </div>
                            <el-empty description="空空如也"  v-else></el-empty>
                            <div class="pagination-row">
                                <el-pagination
                                        :total="total"
                                        :page-size="listQuery.limit"
                                        :current-page.sync="listQuery.page"
                                        :page-sizes="pageSizes"
                                        @size-change="sizeChange"
                                        @current-change="currentChange"
                                        layout="prev, pager, next" :background="true" next-text="下一页" prev-text="上一页" >
                                </el-pagination>
                            </div>
                        </div>
                    </div>
                </div>


                <yonghu-form ref="formRef" @change="getList"></yonghu-form>
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
<script src="${pageContext.request.contextPath}/static/client/page/yonghu/formComponent.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/swiper.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/page-swiper.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return{
                tableName:'yonghu',
                formName:'用户',
                list:[],
                total:0,
                listQuery:{
                    page: 1,
                    limit: 9,
                },
                listLoading:false,
                pageSizes:[20,50,100,200],
                centerType:false,
                searchQuery:{},
            }
        },
        created(){
            this.centerType = toolUtil.getUrlParamsByKey("centerType")
            this.init()
        },
        methods: {
            sizeChange(size){
                this.listQuery.limit = size
                this.getList()
            },
            currentChange(page){
                this.listQuery.page = page
                this.getList()
            },
            //权限验证
            btnAuth(e,a){
                if(this.centerType){
                    return toolUtil.isBackAuth(e,a)
                }else{
                    return toolUtil.isAuth(e,a)
                }
            },
            addClick(){
                this.\$refs['formRef'].init()
            },
            init(){
                this.getList()
            },
            searchClick(){
                this.listQuery.page = 1
                this.getList()
            },
            getList(){
                this.listLoading = true
                let params = JSON.parse(JSON.stringify(this.listQuery))
                if(this.searchQuery.yonghuming && this.searchQuery.yonghuming!=''){
                    params.yonghuming = '%' + this.searchQuery.yonghuming + '%'
                }
                http.get(this.tableName+`/`+(this.centerType?'page':'list'),{
                    params: params
                }).then(res=>{
                    this.listLoading = false
                    this.list = res.data.data.list
                    this.total = Number(res.data.data.total)
                })
            },
            tableDetailClick(row){
                location.href = `detail?id=`+row.id+(this.centerType?'&&centerType=1':'')
            },
            detailClick(id){
                location.href = `detail?id=`+id+(this.centerType?'&&centerType=1':'')
            },
        }
    })
</script>
<style>

.el-main {
    padding: 0 0 30px;
    background: none;
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
    width: 100%;
    margin: 0 auto;
}


.header-wrapper {
    width: var(--body-width);
    margin:0 auto;
    padding: 0 0px;
    border-radius: 0px;
    background: none;
    margin-top:20px;
}

.header-view {
    width: 100%;
    background:url(http://clfile.zggen.cn/20260119/d20eec697d0a4a32beba05d7964a7b44.jpg) no-repeat right center / auto 100%,#fff;
    padding:0 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #edeef0;
    height: 50px;
    align-items: center;
    border-radius: 6px;   
}

.header-view .el-breadcrumb {
}

.header-view .el-button{
 order:2;
}
.header-view .el-button:focus,.header-view .el-button:hover {
}
.header-view .el-button:active {
}


.search-view {
    padding-top: 30px;
    text-align:center;
}

.search-view .el-form-item__content{
}

.search-view .el-form-item__content .el-input__inner{
    border: none;
    border: 1px solid #eee;
    border-radius: 0px;
    max-width:250px;
}
.search-view .el-form-item__content .el-input__inner:focus {
}
.el-input__inner .el-range-separator{
    min-width:40px;
}

.search-view .el-form-item__content .search-btn{
    color: #fff;
    background: var(--theme);
    border-color: var(--theme);
    padding:0 10px;
    height:40px;
    line-height:40px;
    min-width:80px;
    border-radius: 4px;
}
.search-view .el-form-item__content .search-btn:hover{
}
.search-view .el-form-item__content .add-btn{
    color: #fff;
    background: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
    padding:0 10px;
    height:40px;
    line-height:40px;
    min-width:80px;
    border-radius: 4px;
}
.search-view .el-form-item__content .add-btn:hover{

}

.category-wrapper{
    width: var(--body-width);
    margin:0 auto;
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    align-content: flex-start;
    background: #FFF7F1;
    box-shadow: inset 0px -20px 30px 0px #FFFFFF, inset 0px 10px 10px 0px rgba(102, 102, 102, 0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #FFFFFF;
    padding: 0 20px 20px;
}


.category-view {
    width: 100%;
    margin: 0px 0px 0 0;
}

.category-list {
    width: 100%;
    margin: 0px auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    background: none;
    border-radius: 10px 10px 10px 10px;
    padding: 20px 10% 0;
    gap: 20px;
    background: url(http://clfile.zggen.cn/20260119/4435a219ee554c0eb2a86ccd4916e5a5.png) no-repeat;
    background-size: 100% 100%;
    min-height:100px;
}
.category-list .category-item {
    width: auto;
    font-weight: 400;
    font-size: 18px;
    color: #000000;
    padding-left: 10px;
    padding-right: 10px;
    height: 40px;
    line-height: 40px;
    background: #FFFFFF;
    box-shadow: 0px 0px 5px 0px #E7EBEE, inset 0px -5px 10px 0px rgba(251, 126, 48, 0.33);
    border-radius: 5px 5px 5px 5px;
}
.category-list .category-item:hover{
    background: var(--theme);
    border-color: var(--theme);
    color: #fff;
    box-shadow: inset 0px -5px 10px 0px #FFFFFF;
    border-radius: 5px 5px 5px 5px;
    cursor: pointer;
}
.category-list .category-item.selected {
    background: var(--theme);
    border-color: var(--theme);
    color: #fff;
    box-shadow: inset 0px -5px 10px 0px #FFFFFF;
    border-radius: 5px 5px 5px 5px
}



.list-wrapper {

}

.list-view {
    background: none;
    margin-top: 20px;
    padding: 0px;
    border-radius: 0px;
    flex: 1;
    width: 100%;
    box-sizing: border-box;
}

.list-view .table{
    margin-bottom: 20px;
}
.list-view .table .el-image__inner{
    max-width:100px;
}


.list {
    width: calc(100% + 20px);
    display: flex;
    flex-wrap: wrap;
    margin: 0px 0 20px -10px;
}
.list .item {
    background: #fff;
    width: calc(33.33% - 20px);
    cursor: pointer;
    border-radius: 0px;
    margin: 0 10px 20px;
    display: flex;
    justify-content: space-between;
    border-radius: 10px;
    padding:10px;
}
.list .el-image {
    height: 160px;
    width: 100%;
    border-radius: 10px;  
}

.list .item .play-wrapper {
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 220px;
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(0,0,0,0.5);
    transition: 300ms;
}
.list .item:hover .play-wrapper {
    top: 0;
    left: 0px;
}

.list .item .play-wrapper .play .iconfont {
    font-size: 66px;
    color: rgba(255,255,255,0.8);
}


.list .item .infoItem-wrapper{
    padding: 10px;
    flex: 1;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-content: center;
}
.list .item:hover .infoItem-wrapper{
}


.list .item .infoItem-wrapper .infoItem{
    line-height: 24px;
}
.list .item:hover .infoItem-wrapper .infoItem{
    color:var(--theme);
}

.list .item .infoItem-wrapper .price{
    width:100%;
    color: #c00;
    line-height: 24px;
}



.pagination-row {
    text-align: center;
    background: none;
    padding: 0px 0;
    border-radius: 0 0 8px 8px;
}

.pagination-row .el-pager{
}
.pagination-row .el-pager .number{
    background: #fff;
}
.el-pagination.is-background .btn-next, .el-pagination.is-background .btn-prev, .el-pagination.is-background .el-pager li {
    margin: 0 5px;
    background-color: #fff;
    color: #606266;
    min-width: 30px;
    border-radius: 2px;
}
.pagination-row .btn-prev{
    padding: 0 10px !important;
}
.pagination-row .btn-next{
    padding: 0 10px !important;
}
.pagination-row .el-pager .number:hover{
    background: var(--theme);
    color: #fff !important;
}
.pagination-row .el-pager .active{
    background: var(--theme) !important;
    color: #fff !important;
}
.pagination-row .el-pager .more:hover{
    background: var(--theme) !important;
    color: #fff !important;
}



.hot-view {
    width: var(--body-width);
    margin: 30px auto;
    padding: 0px 0 20px;  
}

.hot-view .title-row {
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
.hot-view .title-row span{
    position:relative;
}
.hot-view .title-row span:before{
content:"RecommendGood";
position:absolute;
top:20px;
}


.hot-view .hot-list {
    display: flex;
    margin: 20px 0 0 0;
    gap: 20px;
    background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(255,247,242,1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102,102,102,0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding: 20px 10px 10px;   
}
.hot-view .hot-list .hot-item{
    flex: 1;
    padding: 10px;
    background: #fff;
    border-radius: 10px;
    display: flex;
    align-items: center;
}
.hot-view .hot-list .hot-item:hover{
    cursor: pointer;
}

.hot-view .hot-list .hot-item .el-image{
    width: 35%;
    margin:0 20px 0 0;
}
.hot-view .hot-list .hot-item .el-image img{
    width: 100%;
    height: 130px;
    object-fit: cover;
    border-radius: 10px;
}

.hot-view .hot-list .hot-item .hot-text{
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    order: 2;
}
.hot-view .hot-list .hot-item:hover .hot-text{
}
.hot-list::-webkit-scrollbar {
    display: none;
}


</style>
</html>
