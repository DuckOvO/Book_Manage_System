<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>图书续借</title>
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
                <div class="content-box">
                    <div class="header-wrapper">
                        <div class="header-row">
                            <el-button @click="history.go(-1)" size="small">返回</el-button>
                        </div>
                    </div>
                    <div class="swiper-wrapper">
                        <div class="info">
                            <div>
                                <div class="title-view">
                                    <div class="title">
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">租借编号</div>
                                    <div class="value" >
                                        {{detail.zujiebianhao}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">书籍名称</div>
                                    <div class="value" >
                                        {{detail.shujimingcheng}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">书籍分类</div>
                                    <div class="value" >
                                        {{detail.shujifenlei}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">ISBN</div>
                                    <div class="value" >
                                        {{detail.bianma}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">借阅数量</div>
                                    <div class="value" >
                                        {{detail.jieyueshuliang}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">用户名</div>
                                    <div class="value" >
                                        {{detail.yonghuming}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">姓名</div>
                                    <div class="value" >
                                        {{detail.xingming}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">借阅时间</div>
                                    <div class="value" >
                                        {{detail.jieyueshijian}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">归还时间</div>
                                    <div class="value" >
                                        {{detail.guihaishijian}}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="label">续借时间</div>
                                    <div class="value" >
                                        {{detail.xujieshijian}}
                                    </div>
                                </div>
                                <div class="info-item" v-if="centerType">
                                    <div class="label">是否审核</div>
                                    <div class="value">
                                        {{detail.sfsh}}
                                    </div>
                                </div>
                                <div class="info-item" v-if="centerType">
                                    <div class="label">回复内容</div>
                                    <div class="value">
                                        {{detail.shhf}}
                                    </div>
                                </div>
                                <div class="btn-view">
                                    <el-button class="approval" v-if="btnAuth('tushuxujie','审核')" type="warning" @click="approvalClick">审核</el-button>
                                    <el-button class="edit" v-if="centerType&&btnAuth('tushuxujie','修改')" type="primary" @click="editClick">修改</el-button>
                                    <el-button class="delete" v-if="centerType&&btnAuth('tushuxujie','删除')" type="danger" @click="delClick">删除</el-button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <Approval ref="approvalRef" :table-name="tableName" @change="init()"></Approval>
                </div>
                <tushuxujie-form ref="formRef" @change="getDetail"></tushuxujie-form>
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
<script src="${pageContext.request.contextPath}/static/client/static/modules/wangeditor/index.min.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/myEditor.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/wangeditor/style.css"></link>
<!--引入组件-->
<script src="${pageContext.request.contextPath}/static/client/components/page-header.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/nav-menu.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/approval.js"></script>
<script src="${pageContext.request.contextPath}/static/client/page/tushuxujie/formComponent.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return{
                tableName:'tushuxujie',
                formName:'图书续借',
                title:'',
                detail:{},
                centerType:false,   //判断是否从个人中心跳转
            }
        },
        beforeCreate(){
            let anchorPoint = location.href.match(/#[A-z]+$/g)
            if(anchorPoint?.length){
                window.onload = ()=>{
                    setTimeout(()=>{
                        location.href = anchorPoint
                    },0)
                }
            }
        },
        created(){
            this.centerType = toolUtil.getUrlParamsByKey("centerType")
            this.init()
        },
        methods: {
            //权限验证
            btnAuth(e,a){
                if(this.centerType){
                    return toolUtil.isBackAuth(e,a)
                }else{
                    return toolUtil.isAuth(e,a)
                }
            },
            //查看权限验证
            btnFrontAuth(e,a){
                if(this.centerType){
                    return toolUtil.isBackAuth(e,a)
                }else{
                    return toolUtil.isFrontAuth(e,a)
                }
            },
            getDetail(){
                http.get(this.tableName+`/detail/`+toolUtil.getUrlParamsByKey("id")).then(res=>{
                    this.detail = res.data.data
                })
            },
            //下载文件
            downClick(file){
                if(!file){
                    return this.\$message.error('文件不存在')
                }
                const a = document.createElement('a');
                a.style.display = 'none';
                a.setAttribute('target', '_blank');
                a.setAttribute('download', file);
                a.href = baseUrl + file;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            },
            //判断是否从个人中心跳转
            init(){
                if(toolUtil.getUrlParamsByKey("centerType")){
                    this.centerType = true
                }
                this.getDetail()
            },
            approvalClick(btnType='审核'){
                if(!toolUtil.storageGet('Token')){
                    return this.\$message.error('请登录后再操作！')
                }
                if(!this.btnAuth(this.tableName,btnType)){
                    return this.\$message.error('暂无权限操作！')
                }
                let params = {
                    id:this.detail.id,
                    zujiebianhao: this.detail.zujiebianhao,
                    shujimingcheng: this.detail.shujimingcheng,
                    fengmian: this.detail.fengmian,
                    shujifenlei: this.detail.shujifenlei,
                    bianma: this.detail.bianma,
                    jieyueshuliang: this.detail.jieyueshuliang,
                    yonghuming: this.detail.yonghuming,
                    xingming: this.detail.xingming,
                    sfsh: this.detail.sfsh,
                    shhf: this.detail.shhf,
                    jieyueshijian: this.detail.jieyueshijian,
                    guihaishijian: this.detail.guihaishijian,
                    xujieshijian: this.detail.xujieshijian,
                }
                this.\$nextTick(() => {
                    this.\$refs.approvalRef.approvalClick(params)
                })
            },
            //修改
            editClick(){
                this.\$refs['formRef'].init(this.detail.id,'edit')
            },
            //删除
            delClick(){
                this.\$confirm(`是否删除此`+this.formName+`？`, '提示', {
                    confirmButtonText: '是',
                    cancelButtonText: '否',
                    type: 'warning',
                }).then(() => {
                    http.post(this.tableName+`/delete`,[this.detail.id]).then(res => {
                        this.\$message({
                            type:'success',
                            message:'删除成功',
                            onClose:()=>{
                                history.go(-1)
                            }
                        })
                    })
                })
            },
        }
    })
</script>
<style>
*{
box-sizing:border-box !important; 
}


.el-main {
    padding: 30px 0;
    background: #E7EBEE;
}


.content-box {
    width: var(--body-width);
    margin: 0 auto;
    padding: 0;
}


.header-wrapper {
    background: #fff;
    border-radius: 0px;
    padding: 0px 0px;
    display: flex;
    flex-wrap: wrap;
    row-gap: 20px;
    column-gap: 20px;
    margin-bottom:20px;
}

.header-row {
    width: 100%;
}

.header-row .el-button{
    border-radius:0px;
    min-width:80px;
}
.header-row .el-button:focus,.header-row .el-button:hover {
}

.swiper-wrapper{

}


.swiper {
    width: 480px;
    height: 500px;
    object-fit: cover;
    order:0;
    border-radius: 4px;
    margin:0 50px 0 0;
}
.el-carousel {
    border-radius: 10px;
}
.el-carousel img {
    width: 100%;
    height: 500px;
    object-fit:cover;
    background:none;
    border:1px solid #eee;
    box-sizing: border-box;
    border-radius: 10px;
}


.info{
    width: calc(100% - 530px);
    margin: 0;
    box-sizing: border-box;
    background: #f5f5f5;
    padding: 20px 20px;
    border-radius: 6px;
    font-size: 15px;
    display: flex;
    flex-wrap: wrap;
    border: 1px solid rgb(220, 223, 230);
    min-height: 480px;
    align-content: flex-start;
    flex: 1;

    background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(255,247,242,1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102,102,102,0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding: 20px;   
}
.info>div {
    display: flex;
    flex-wrap: wrap;
    row-gap: 10px;
}

.info .info-item {
    display: flex;
    align-items: center;
    font-size: 14px;
    min-width: 50%;
    line-height: 1;
}
.info-item .label {
    width: 100px;
    color: #333;
}
.info-item .value {
    color: #666;
}

.info .info-item.countDown .value {
    color: #ff0000;
}

.info .info-item.price .value{
    color: #ff0000;
}


.info .title-view {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.info .title {
    font-size: 22px;
    font-weight: 600;
}

.coupon-view .el-button--warning{
    color: #fff;
    background-color: var(--theme) !important;
    border-color: var(--theme) !important;
}


.info .storeUp{
    font-size: 16px;
    margin-right: 10px;
    white-space: nowrap;
    cursor: pointer;
}
.info .storeUp>div {
    display: flex;
    align-items: center;
    color:#f60;
}

 .info .storeUp .iconfont {
    font-size:24px;
    padding-left: 10px;
    white-space: nowrap;
    cursor: pointer;
}



.like {
    display:flex;
    justify-content:center;
    align-item:center;
    width: 100%;
    margin-bottom:10px;
    order:5;

}
.like .zan{
    display: inline-block;
    cursor: pointer;
    margin-right:10px;
    width: auto;
    border: 1px solid rgb(221, 221, 221);
    color: rgb(153, 153, 153);
    border-radius: 20px;
    padding: 0px 20px;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    margin: 0px 20px;
    height:38px;
    line-height:38px;
}
.like .cai {
    display: inline-block;
    width: auto;
    border: 1px solid rgb(221, 221, 221);
    color: rgb(153, 153, 153);
    border-radius: 20px;
    padding: 4px 20px;
    box-sizing: border-box;
    cursor: pointer;
    background: rgb(255, 255, 255);
    margin: 0px 20px;
    display: flex;
    align-items: center;
    height:38px;
    line-height:38px;
}



.info-item.file {
    width: 100%;
}
.info-item.file .el-button {
    background: var(--theme) !important;
    color:#fff;
    padding: 0 10px;
    border:1px solid #eee;
    height: 32px;
    line-height: 32px;
}
.info-item.file .el-button:hover {
}
.info-item.file .el-button.empty{
    background: #999 !important;
    color:#fff;
}



#audio {
    height:32px !important;
}



.btn-view .number {
    width: auto;
}
.btn-view .number .el-input__inner{
    height: 42px;
    line-height: 42px;
}
.btn-view .number .el-input-number {
    position: relative;
    display: inline-block;
    width: 150px;
    height: 40px;
    line-height: 40px;
}
.btn-view .number .el-input__inner:focus {
    outline: none;
    border-color: var(--swiper-theme-color);
}
.btn-view .number .el-input-number__decrease,.el-input-number__increase {
    width: 40px;
    height: auto;
    text-align: center;
    background:none; 
    color:#606266; 
}
.btn-view .number .el-input-number__decrease:hover,.btn-view .number .el-input-number__increase:hover {
    color: var(--swiper-theme-color);
}
.btn-view .number .el-input-number__decrease:hover:not(.is-disabled)~.el-input .el-input__inner:not(.is-disabled),.btn-view .number .el-input-number__increase:hover:not(.is-disabled)~.el-input .el-input__inner:not(.is-disabled) {
    border-color: var(--swiper-theme-color);
}


.btn-view {
    display: flex;
    flex-wrap: wrap;
    row-gap: 10px;
    column-gap: 10px;
    width: 100%;
}

.btn-view .el-button {
    height:42px;
    line-height:42px;
    padding:0 10px;
}
.btn-view .el-button:focus,.el-button:hover {
}

.btn-view .cart{
    background: var(--theme);
    color: rgb(255, 255, 255);
    border: none;
    height: 42px;
    margin: 0px 10px 10px 0px;
}
.btn-view .cart:hover{
}

.btn-view .buy{
    background: var(--theme);
    color: rgb(255, 255, 255);
    border: none;
    height: 42px;
    margin: 0px 10px 10px 0px;
}
.btn-view .buy:hover{
}

.btn-view .auction{
    color: #fff;
    background:var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.btn-view .auction:hover{
    color: var(--swiper-theme-color);
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
}

.btn-view .pay{
    color: #fff;
    background:var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.btn-view .pay:hover{
    color: var(--swiper-theme-color);
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
}


.btn-view .new-group{
    color: #fff;
    background:var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.btn-view .new-group:hover{
    color: var(--swiper-theme-color);
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
}

.btn-view .join-group{
    color: #fff;
    background:var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.btn-view .join-group:hover{
    color: var(--swiper-theme-color);
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
}



.tabs-wrapper .tabs {
    background: #fff;
    margin-top: 30px;
    padding: 0px 0px 30px;
    border-radius: 0px;
    min-height: 320px;

    background: #FFF7F1;
    box-shadow: inset 0px -20px 30px 0px #FFFFFF, inset 0px 10px 10px 0px rgba(102, 102, 102, 0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #FFFFFF;
    padding: 0 20px 20px;
}
.tabs-wrapper .tabs .el-tabs__header{
    border-bottom: none !important;
    background: url(http://clfile.zggen.cn/20260119/4435a219ee554c0eb2a86ccd4916e5a5.png) no-repeat;
    background-size: 100% 100%;
    min-height:100px;
}
.tabs-wrapper .tabs .el-tabs__nav{
    width:100%;
    background:none;
    padding:20px 20px 0;
    border: 0;
    border: none !important;
    display: flex !important;
    justify-content: center !important;
}

.tabs-wrapper .tabs .el-tabs__active-bar {
    position: absolute;
    bottom: 0;
    left: 20px;
    height: 2px;
    background: var(--swiper-theme-color);
}
.tabs-wrapper .el-tabs--card>.el-tabs__header .el-tabs__item {
    border-bottom: 0;
    border-left: 0;
    background: #fff;
    box-shadow: 0px 0px 5px 0px #E7EBEE, inset 0px -5px 10px 0px rgba(251, 126, 48, 0.33);
    border-radius: 5px;
    margin:0 20px 0 0;
    transition: all 0s;
}
.tabs-wrapper .tabs .el-tabs__header .el-tabs__item.is-active {
    color: #fff;
    background: #FB7E30;
    box-shadow: inset 0px -5px 10px 0px #FFFFFF;
    border-radius: 5px;
}
.tabs-wrapper .tabs .el-tabs__header .el-tabs__item:hover {
    color: #fff;
    background: #FB7E30;
    box-shadow: inset 0px -5px 10px 0px #FFFFFF;
    border-radius: 5px;
}


.el-tabs__content{

}

.el-table{

}

.el-table .el-table__header tr{
    background: var(--swiper-theme-color);
    color:#fff;
 }
.el-table .el-table__header tr th.el-table__cell {
    background:none;
    padding:6px 0;
}
.el-table tr{
}
.el-table td.el-table__cell,.el-table th.el-table__cell.is-leaf {
    border-bottom: 1px solid #eee;
}
.el-table--border:after,.el-table--group:after,.el-table:before {
    background: none;
}

.el-table .el-image{
    max-width:100px;
    max-height:100px;
    object-fit:contain;
}
.el-table--enable-row-hover .el-table__body tr:hover>td.el-table__cell {
    background: var(--hover-background10);
}


#catalogue{
    padding:0 20px;
}

#catalogue .list-title {
    font-weight: 600;
}

#catalogue .free-list,#catalogue .vip-list {
    display: grid;
    grid-template-columns: repeat(2,1fr);
    grid-column-gap: 20px;
    grid-row-gap: 20px;
    margin: 10px 0;
}
#catalogue .item {
    border: 1px solid #eee;
    line-height: 40px;
    padding: 0 10px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: pointer;
    position: relative;
    text-align: left;
    color:#666;
}
#catalogue .item:hover {
    color: var(--swiper-theme-color);
    border-color: var(--hover-border-color);
    background: var(--hover-background10);
}

#catalogue .item .iconfont {
    position: absolute;
    font-size: 14px;
    top: 8px;
    right: 4px;
}



.tabs-wrapper{
}
.tabs-wrapper .el-tab-pane{
    padding:0 20px;
}

.tabs-wrapper .el-tab-pane .comment-form{
}

.tabs-wrapper .el-tab-pane .comment-form .el-textarea__inner{
    color: #606266;
    background: #fff;
    border: 1px solid #dcdfe6;
    border-radius: 0px;
}
.tabs-wrapper .el-tab-pane .comment-form .el-textarea__inner:focus {
    border-color: var(--swiper-theme-color);
}
.editor—wrapper>.editor-container {
    min-height: 300px;
    background: #fff;
}


.tabs-wrapper .el-tab-pane .comment-form .btns{
}
.tabs-wrapper .el-tab-pane .comment-form .btns .el-button--primary {

}
.tabs-wrapper .el-tab-pane .comment-form .btns .el-button--primary:focus,.tabs-wrapper .el-tab-pane .comment-form .btns .el-button--primary:hover {

}
.tabs-wrapper .el-tab-pane .comment-form .btns .el-button{
    height:32px;
    line-height:32px;
    padding:0 20px;
}
.tabs-wrapper .el-tab-pane .comment-form .btns .el-button:focus,.tabs-wrapper .el-tab-pane .comment-form .btns .el-button:hover {
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
    color: var(--swiper-theme-color);
}
.tabs-wrapper .el-tab-pane .comment-form .btns .el-button:active {
    background: var(--hover-background10);
    border-color: var(--hover-border-color);
    color: var(--swiper-theme-color);
}


.comment-list {
    margin-top: 30px;
}
.comment-list .list{
}
.comment-list .list .item{
    background: #fcfcfc;
    border:1px solid #eee;
    margin-bottom: 20px;
    padding:10px;
}
.comment-list .list .item:hover{
    background: var(--hover-background10);
    border:1px solid var(--hover-border-color);
}

.comment-list .list .item .item-header{
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.comment-list .list .item .item-header .comment-user{
    display: flex;
    align-items: center;
}

.comment-list .list .item .item-header .comment-user .el-image {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

.comment-list .list .item .item-header .comment-user .comment-username {
    font-size: 14px;
    color: #666;
}

.comment-list .list .item .item-header .comment-time{
    margin-left: 20px;
    color: #999;
}

.comment-list .list .item .comment-content {
    padding-left: 50px;
    color: #666;
}

.comment-list .list .item .comment-reply{
    color: #999;
    margin-top: 5px;
}

.comment-list .pagination {
    text-align: center;
    padding-top: 20px;
}
.el-pagination.is-background .el-pager li:hover {
    background: var(--swiper-theme-color);
    color: #fff !important;
}
.el-pagination.is-background .el-pager li:not(.disabled):hover {
    color: var(--swiper-theme-color);
}
.el-pagination.is-background .el-pager li:not(.disabled).active {
    background: var(--swiper-theme-color);
    color: #fff;
}



.seatList {
    display: grid;
    grid-template-columns: repeat(12,1fr);
    grid-gap: 10px;
}
.seatList .item{
    background: none;
    border:0px solid #eee;
    padding:0px;
    text-align: center;
}
.seatList .item:hover{
    background: none;
    border:0px solid var(--hover-border-color);
}
.seatList .item .seat {
    text-align: center;
    display: inline-block;
    cursor: pointer;
}
.seatList .item .seat .selected {
    color: #dd4d41;
}
.seatList .item .seat .active {
    color: var(--swiper-theme-color);
}

.seatList .item .seat .iconfont {
    font-size: 40px;
}

.seatList .item .seat .seatText{
    font-size: 14px;
    color: #333;
}



.hot-wrapper{
    width: 100%;
    margin: 30px auto;
    padding: 0px 0 20px;  
}

.hot {
    width:calc(100% - 0px);
    background: none;
    border-radius: 0px;
    padding:0px 0px;
    flex:2;
}

.hot .title {
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
.hot .title span{
    position:relative;
}
.hot .title span:before{
content:"RecommendGood";
position:absolute;
top:20px;
}


.hot .list {
    display: flex;
    margin: 20px 0 0 0;
    gap: 20px;
    background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(255,247,242,1) 100%);
    box-shadow: inset 0px -20px 30px 0px #ffffff, inset 0px 10px 10px 0px rgba(102,102,102,0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #ffffff;
    padding: 20px 10px 10px;
}
.hot .list .item{
    flex: 1;
    padding: 10px;
    background: #fff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    cursor: pointer;
}

.hot .list .item .el-image {
    width: 35%;
    margin:0 20px 0 0;
}

.hot .list .item .el-image img {
    width: 100%;
    height: 130px;
    object-fit: cover;
    border-radius: 10px;
}

.hot .list .item .hot-info{
   flex: 1;
}
.hot .list .item .hot-info .info-item {
    line-height: 24px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}



.video-wrapper {
    margin-top: 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.video {
    width: 100%;
    text-align: center;
}

video {
    width: 100%;
    min-height: 240px;
}


</style>
</html>
