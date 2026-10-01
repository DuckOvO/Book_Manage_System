<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>找回密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/modules/animate.min.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/wow.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/client/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/client/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-main id="main">
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
            <el-form :model="forgetForm" class="forget-form" size="small" >
            </el-form>
            <div class="btns">
                <el-button v-if="pageType==1" class="getSecurity" type="primary" @click="getSecurity">获取密保</el-button>
                <el-button v-if="pageType==2" class="validateSecurity" type="primary" @click="validateSecurity">确认密保</el-button>
                <el-button v-if="pageType==3" class="updatePassword" type="primary" @click="updatePassword">重置密码</el-button>
            </div>
        </div>
    </el-main>
</el-container>
</body>
<script src='${pageContext.request.contextPath}/static/client/static/modules/axios.min.js'></script>
<script src="${pageContext.request.contextPath}/static/client/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/system.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/global_mixin.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/toolUtil.js"></script>

<script src="${pageContext.request.contextPath}/static/client/components/page-header.js"></script>
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



#page {
}


#main{
    background:url(http://clfile.zggen.cn/20251014/8f33441e9e56443abe8355fd656234b1.jpg) no-repeat center top / 100% 100%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
}


.forget-wrapper{
    width: 550px !important;
    height: auto !important;
    background: #FFF7F1!important;
    border: 2px solid #FFFFFF;
    overflow-y: auto;
    scrollbar-width: none;
    -ms-overflow-style: none;
    border-radius: 20px!important;
    box-shadow: inset 10px -20px 30px 0px #FFFFFF;
    margin-left: 10%;
    padding:0 60px 30px;
}


.forget-wrapper .from-name{
    font-size: 24px;
    color: #333;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin: 20px auto 30px;
    text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3);
}


.steps{
    padding: 0px 10%;
    margin-bottom: 40px;
    gap:10px;
}


.forget-form{
    width: 100%;
    background: rgba(255,255,255,0);
    padding: 0px;
    border: 0px solid #DDA0DD;
    position: relative;
    text-align: center;
}


.forget-form .el-form-item {
    width: 100%;
    display: flex;
    align-items: center;
    margin-top: 20px;
    background: #fff !important;
    border: 1px solid #13090A !important;
    border-radius: 4px;
    padding: 0 0 0 10px;
}


.forget-form label.el-form-item__label {
    width: auto;
    white-space: nowrap;
}


.forget-form .el-form-item__content {
    width: calc(100% - 250px);
    margin-left:0px !important;
}


.forget-form .el-input__inner{
    background:none;
    height: var(--input-height);
    line-height: var(--input-height);
    padding: 0 10px;
    border-radius: 6px;
    font-size: inherit;
    border: 0px solid #d1d5db;
}
.forget-form .el-input__inner:hover,.forget-form .el-input__inner:focus{
    border: 0px solid #a7b5ca;
}

.el-select{
  width:100%;
}
.el-step__head.is-success {
    color: var(--theme);
    border-color: var(--theme);
}
.el-step__title.is-success {
    color: var(--theme);
}


.btns{
  width:100%;
}


.btns .el-button--primary {
    width: 100%;
    height: 44px;
    background: var(--theme);
    border: none;
    color: #fff;
    font-size: 18px;
    border-radius: 4px;
    margin: 0px 20px 0 0;
    min-width: 100px;
}
.btns .el-button--primary:focus,.btns .el-button--primary:hover {

}

#main {
    background-image: url(http://clfile.zggen.cn/20260117/f672afe624bb40e4896d28f4a9648676.webp);
}
</style>
</html>