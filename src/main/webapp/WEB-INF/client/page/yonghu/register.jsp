<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>注册</title>
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
            <div class="register-wrapper">
                <div class="form-name">注册</div>
                <el-form ref="registerForm" class="register-form" :model="registerForm" size="medium" >
                    <el-form-item label="用户名" class="input-row">
                        <el-input v-model="registerForm.yonghuming"
                                  placeholder="请输入用户名"
                                  type="text"
                        ></el-input>
                    </el-form-item>
                    <el-form-item label="密码" class="input-row">
                        <el-input v-model="registerForm.mima" placeholder="密码" type="password" autocomplete="new-password"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码" class="input-row">
                        <el-input v-model="registerForm.mima2" placeholder="密码" type="password" autocomplete="new-password"></el-input>
                    </el-form-item>
                    <el-form-item label="姓名" class="input-row">
                        <el-input v-model="registerForm.xingming"
                                  placeholder="请输入姓名"
                                  type="text"
                        ></el-input>
                    </el-form-item>
                    <el-form-item label="性别" class="select-row">
                        <el-select
                                class="list_sel"
                                v-model="registerForm.xingbie"
                                placeholder="请选择性别"
                        >
                        <el-option v-for="item in yonghuxingbieLists" :label="item" :value="item"></el-option>
                    </el-select>
                    </el-form-item>
                    <el-form-item label="头像" class="upload-img-row">
                        <file-upload
                                tip="点击上传头像"
                                action="file/upload"
                                :limit="3"
                                :multiple="true"
                                :file-urls="registerForm.touxiang?registerForm.touxiang:''"
                                @change="touxiangUploadSuccess"
                        ></file-upload>
                    </el-form-item>
                    <el-form-item label="年龄" class="input-row">
                        <el-input v-model="registerForm.nianling"
                                  placeholder="请输入年龄"
                                  type="text"
                        ></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱" class="input-row">
                        <el-input v-model="registerForm.youxiang"
                                  placeholder="请输入邮箱"
                                  type="text"
                        ></el-input>
                    </el-form-item>
                </el-form>
                <div class="btn-row">
                    <el-button class="register-btn" type="primary" @click="handleRegister">注册</el-button>
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
<script src="${pageContext.request.contextPath}/static/client/components/FileUpload.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/page-header.js"></script>
<script>
var vm = new Vue({
    el: '#page',
    data(){
        return {
            registerForm:{
                xingbie: '',
            },
            yonghuxingbieLists:[],
        }
    },
    created(){
        this.init()
    },
    methods: {
        init(){
            this.yonghuxingbieLists = "男,女".split(',')
        },
            touxiangUploadSuccess(fileUrls){
            this.registerForm.touxiang = fileUrls;
        },
    // 多级联动参数
        //公共方法
        getUUID(){
            return new Date().getTime();
        },

        handleRegister(){
            let url = "yonghu/register";
            if(!this.registerForm.yonghuming){
                return this.\$message.error(`用户名不能为空`)
            }
            if(!this.registerForm.mima){
                return this.\$message.error(`密码不能为空`)
            }
            if(!this.registerForm.mima2){
                return this.\$message.error('请确认密码')
            }
            if(this.registerForm.mima!=this.registerForm.mima2){
                return this.\$message.error('两次输入的密码不一致')
            }
            if(!this.registerForm.xingming){
                return this.\$message.error(`姓名不能为空`)
            }
            if(this.registerForm.touxiang!=null){
                this.registerForm.touxiang = this.registerForm.touxiang.replace(new RegExp(baseUrl,"g"),"");
            }
            if(this.registerForm.nianling&&(!toolUtil.isIntNumer(this.registerForm.nianling))){
                return this.\$message.error(`年龄应输入整数`)
            }
            if(this.registerForm.youxiang&&(!toolUtil.isEmail(this.registerForm.youxiang))){
                return this.\$message.error(`邮箱应输入邮件格式`)
            }
            if(this.registerForm.maxPasswordWrong&&(!toolUtil.isIntNumer(this.registerForm.maxPasswordWrong))){
                return this.\$message.error(`最大密码输错次数应输入整数`)
            }
            if(this.registerForm.isLocked&&(!toolUtil.isIntNumer(this.registerForm.isLocked))){
                return this.\$message.error(`用户锁定状态应输入整数`)
            }
            http.post(url,this.registerForm).then(res=>{
                this.\$message.success('注册成功')
                setTimeout(()=>{
                    location.replace(baseUrl+`client/login`)
                },1000)
            })
        },
    },

})
</script>
<script>

</script>
<style>



#page {
}


#main{
    background:url(http://clfile.zggen.cn/20251106/f8a84815a5754521b69f9ca7413bd5f8.jpeg) no-repeat center top / 100% 100%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
}


.register-wrapper{
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


.register-wrapper .form-name{
    font-size: 24px;
    color: #333;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin: 20px auto 10px;
    text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3);
}


.register-form{
    width: 100%;
    background: rgba(255,255,255,0);
    padding: 0px;
    border: 0px solid #DDA0DD;
    position: relative;
    text-align: center;
}


.register-form .el-form-item {
    width: 100%;
    display: flex;
    align-items: center;
    margin-top: 20px;
    background: #fff !important;
    border: 1px solid #13090A !important;
    border-radius: 4px;
    padding: 0 0 0 10px;
}

.el-form-item--small .el-form-item__content, .el-form-item--small .el-form-item__label {
    line-height: 45px;
}


.register-form .el-form-item__label {
    width: auto;
    white-space: nowrap;
}


.register-form .el-form-item__content {
    width: 100%;
    text-align:left;
}


.register-form .el-date-editor{
    width: 100%!important;
}


.register-form .el-input__inner{
    background:none;
    height: var(--input-height);
    line-height: var(--input-height);
    padding: 0 10px 0 10px;
    border-radius: 6px;
    font-size: inherit;
    border: 0px solid #d1d5db;
}
.register-form .el-input__inner:hover,.register-form .el-input__inner:focus{
    border: 0px solid #a7b5ca;
}
.register-form .el-select .el-input__inner {
     border:1px solid #eee;
}
.register-form .el-select .el-input__inner:hover,.register-form .el-select .el-input__inner:focus {
    border:1px solid var(--hover-border-color);
}


.register-form .el-date-editor{
  width: 100%;    
}

.register-form .el-select{
width: 100%;  
}

.el-input__icon {
    width: 25px;
    line-height: 32px
}

.register-form .el-upload .el-button{
    background:var(--theme);
    border:0;
}

.register-form .el-upload-list__item.is-success {
    width: 120px;
    height: 80px;
    border-radius:0;
}
.el-upload__tip {
    font-size: 12px;
    color: #606266;
    margin-top: 0px;
    line-height: 30px;
}
.el-upload-list {
    line-height: 1;
}
.register-form .el-upload.el-upload--picture-card {
    width: 120px;
    height: 80px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border-radius:0;
}
.register-form .el-upload--picture-card:hover,.register-form .el-upload:focus {
    border-color: var(--swiper-theme-color);
    color: var(--swiper-theme-color);
}
.register-form .el-upload:focus .el-upload-dragger {
    border-color: var(--swiper-theme-color);
}


.el-checkbox__input.is-checked .el-checkbox__inner,.el-checkbox__input.is-indeterminate .el-checkbox__inner {
    background-color: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.el-checkbox__inner:hover {
    border-color: var(--swiper-theme-color);
}
.el-checkbox__input.is-checked+.el-checkbox__label {
    color: var(--swiper-theme-color)
}


.el-radio__input.is-checked .el-radio__inner {
    border-color: var(--swiper-theme-color);
    background: var(--swiper-theme-color)
}
.el-radio__inner:hover {
    border-color: var(--swiper-theme-color)
}
.el-radio__input.is-checked+.el-radio__label {
    color: var(--swiper-theme-color)
}


.code-row {

}

.code-row .code-row-value{
    width: 100%;
    display: flex;
}

.code-row .code-row-value .el-button{
    background: var(--theme2);
    font-size: inherit;
    color: #333;
    border-radius: 4px;
    border: 0px solid #d1d5db;
    height: var(--input-height);
    line-height: var(--input-height);
    padding:0 10px;
}
.code-row .code-row-value .el-button:hover{
}


.btn-row{
    width: 100%;
    display: flex;
    justify-content: center;
}

.register-btn{
    background: var(--theme);
    border: none;
    color: #fff;
    width: 100%;
    height: 44px;
    font-size: 18px;
    border-radius: 4px;
}
.register-btn:hover{
    border:0;
    background: var(--theme);
    color:#fff;
}

#main {
    background-image: url(http://clfile.zggen.cn/20260117/7f3e57ddf7dc48b2bbea86203e9416b9.webp);
}
</style>
</html>