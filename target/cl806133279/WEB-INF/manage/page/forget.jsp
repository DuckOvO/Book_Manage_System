<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>找回密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
</head>
<body>
<div id="page" v-cloak>
    <div class="forget-wrapper">
        <div class="from-name">找回密码</div>
        <el-steps ref="steps" :active="pageType-1" class="steps" :align-center="true" finish-status="success" >
            <el-step title="获取密保" >
            </el-step>
            <el-step title="验证密保" >
            </el-step>
            <el-step title="重置密码" >
            </el-step>
        </el-steps>
        <el-form :model="forgetForm" class="forget-form" size="small" label-width="80px" >
        </el-form>
        <div class="btns">
            <el-button v-if="pageType==1" class="getSecurity" type="primary" @click="getSecurity">获取密保</el-button>
            <el-button v-if="pageType==2" class="validateSecurity" type="primary" @click="validateSecurity">确认密保</el-button>
            <el-button v-if="pageType==3" class="updatePassword" type="primary" @click="updatePassword">重置密码</el-button>
        </div>
    </div>
</div>
</body>
<script src='${pageContext.request.contextPath}/static/manage/static/modules/axios.min.js'></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/toolUtil.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/global_mixin.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return {
                pageType:2,
                forgetForm:{},
                userForm:{},
            }
        },
        mounted(){
        },
        methods: {
        },

    })
</script>
<style>
#page{
    min-height: 100vh;
    background-image: url("http://clfile.zggen.cn/20251106/e1ed2bc77e6143b0aea447eee0ce6e5b.jpeg");
    background-size: cover;
    background-repeat: no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
}

/*登录表单总盒子*/
.forget-wrapper{
    width: 650px;
    min-height:400px;
    border: 1px solid rgba(255,255,255,0);
    z-index: 1;
    background: rgba(255,255,255,0) ;
    padding: 0px 100px 40px 100px;
    box-shadow:0px 0px 0px #999;
    margin: 100px auto 40px 5%;
    border-radius:20px;
}

/*标题盒子*/
.forget-wrapper .from-name{
    padding: 0px 0px;
    margin: 0px;
    width: 100%;
    color: #0e3d8b;
    font-size: 36px;
    font-weight:600;
    line-height: 40px;
    text-align: center;
    letter-spacing:5px; 
    position:relative;
    top:-50px;
    background: linear-gradient(30deg, rgba(255,255,255,1) 0%, rgba(240,240,240,1) 50%, rgba(255,255,255,1) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-stroke:1px #000; 
    -webkit-text-stroke:1px #000; 

}

/*密保盒子*/
.steps{
    padding: 0px 10%;
    background:#fff;
    padding:20px 10px 10px;
    margin-bottom: 20px;
    border-radius:4px;
}

.el-step__head.is-process {
    color: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.el-step__head.is-wait {
    color: #333;
    border-color: #333;
}
.el-step__head.is-success {
    color: #5ec298;
    border-color: #5ec298;
}
.el-step__head.is-error {
    color: #f93636;
    border-color: #f93636;
}
.el-step__head.is-finish {
    color: #2791fe;
    border-color: #2791fe;
}
.el-step__title.is-process {
    color: var(--swiper-theme-color);
}
.el-step__title.is-wait {
    color: #333;
}
.el-step__title.is-success {
    color: #5ec298;
}
.el-step__title.is-error {
    color: #f93636;
}
.el-step__title.is-finish {
    color: #2791fe;
}

/*表单盒子*/
.forget-form{
    padding: 0 0px;
}

/*item盒子*/
.forget-form .el-form-item {
    display:flex;
    background:#fff;
    padding:0 0 0 10px;
    border-radius:4px;
}

/*label标签*/
.forget-form label.el-form-item__label {
    min-width: 150px;
}

/*item内容盒子*/
.forget-form .el-form-item__content {
    width: calc(100% - 250px);
    margin-left:0px !important;
}

/*输入框*/
.forget-form .el-input__inner{
     border:2px solid #fff !important;
}
.forget-form .el-input__inner:hover {
    border-color: var(--hover-border-color) !important;
    border: var(--hover-border) !important;
}
.forget-form .el-input__inner:focus {
    border-color: var(--hover-border-color) !important;
}

/*下拉框*/
.forget-form .el-select .el-input__inner {
     border:2px solid #fff !important;
}
.forget-form .el-select .el-input__inner:hover,#page .el-select .el-input__inner:focus {
    border:var(--hover-border) !important;
}
.el-select-dropdown .el-select-dropdown__item.selected{
    color: var(--swiper-theme-color) !important;
}
.el-select-dropdown .el-select-dropdown__item.hover,.el-select-dropdown .el-select-dropdown__item:hover {
    background: #f6f6f6 !important;
}

/*按钮盒子*/
.btns{
  width:100%;
  text-align:center;
  margin:20px 0 0;
}

/*按钮*/
.forget-wrapper .btns .el-button--primary{
    width: 100%;
    border-radius:4px;
    background:var(--theme3) !important;
    border: none;
    color: #fff !important;
}
.forget-wrapper .btns .el-button--primary:hover{
    background:var(--theme3) !important;
    border: none;
    color: #fff !important;
}
.forget-wrapper .el-button--primary:focus,.forget-wrapper .el-button--primary:hover {
    background:var(--theme3) !important;
    border: none;
    color: #fff !important;
}

#page {
    background-image: url(http://clfile.zggen.cn/20251218/b5a943bb63d04ec5b484cd558d3fd5df.webp);
}
</style>
</html>