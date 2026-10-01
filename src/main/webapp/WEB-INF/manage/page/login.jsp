<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ssm+jsp的图书管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
    <style>
    </style>
</head>
<body>
<div id="page" v-cloak>
    <div class="login-wrapper">
        <div class="from-name">ssm+jsp的图书管理系统</div>
        <el-form ref="form" :rules="rules" class="login-form" :model="form" >
            <el-form-item prop="username" class="username">
                <template v-slot:label>
                    <iconfont icon="el-icon-user"></iconfont>账号
                </template>
                <el-input v-model="form.username"></el-input>
            </el-form-item>
            <el-form-item prop="password" class="password">
                <template v-slot:label>
                    <iconfont icon="el-icon-lock"></iconfont>密码
                </template>
                <el-input v-model="form.password" type="password" show-password></el-input>
            </el-form-item>
            <el-form-item v-if="roleList && roleList.length>1" class="roles" prop="role" label="用户类型">
                <el-select v-model="form.role">
                    <el-option
                            v-for="item in roleList"
                            :key="item.roleName"
                            :label="item.roleName"
                            :value="item.roleName">
                    </el-option>
                </el-select>
            </el-form-item>
        </el-form>
        <div class="btns">
            <div class="loginBtn-wrapper">
                <el-button type="primary" class="login-btn" @click="login">登录</el-button>
            </div>
            <div class="faceBtn-wrapper">
            </div>
        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/static/manage/static/modules/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/toolUtil.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/global_mixin.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return {
                roles:[],
                form: {
                    username: '',
                    password: '',
                    role:'',
                },
                rules: {
                    username: [
                        { required: true, message: '请输入用户名', trigger: 'blur' },
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'blur' }
                    ],
                    role: [
                        { required: true, message: '请选择用户类型', trigger: 'change' }
                    ],
                },
                menus:[],
                roleList:[],

            }
        },
        watch:{
            showType(n){
                if(!n){
                    this.stopNavigator()
                }
            }
        },
        computed:{
            roleIndex(){
                return this.roleList.findIndex(item=>{
                    return item.roleName == this.form.role
                })
            }
        },
        created(){
            this.init()
        },
        methods: {
            init(){
                this.getMenu()
            },
            getMenu(){
                http.get('menu/list',{
                    params:{
                        page: 1,
                        limit: 1,
                        sort: 'id',
                    }
                }).then(res=>{
                    let menus = JSON.parse(res.data.data.list[0].menujson)
                    this.roleList = menus.filter(item=>{
                        return item.hasBackLogin=="是"
                    })
                    if(this.roleList.length==1){
                        this.form.role = this.roleList[0].roleName
                    }
                })
            },
            async login(){
                this.\$refs["form"].validate(async (valid) => {
                    if (!valid)return false
                    try{
                        let res = await http.post(`\${this.roleList[this.roleIndex].tableName}/login?username=\${this.form.username}&password=\${this.form.password}`)
                        this.onLoginSuccess(res.data.token)
                    }catch (e){
                    }

                })
            },
            onLoginSuccess(token){
                this.\$message.success("登录成功")
                toolUtil.storageSet('sessionTable',this.roleList[this.roleIndex].tableName);
                toolUtil.storageSet('username',this.form.username);
                toolUtil.storageSet('Token',token);
                toolUtil.storageSet('role',this.form.role);
                toolUtil.storageSet('menuList',JSON.stringify(this.roleList[this.roleIndex].backMenu))
                http.get(`\${this.roleList[this.roleIndex].tableName}/session`).then(res=>{
                    toolUtil.storageSet('userInfo',JSON.stringify(res.data.data));
                    toolUtil.storageSet('userid',res.data.data.id)
                    setTimeout(()=>{
                        location.replace('${pageContext.request.contextPath}/manage/index')
                    },1000)
                })
            },
        }
    })
</script>
<style>
#page{
    min-height: 100vh;
    background-image: url("http://clfile.zggen.cn/20251217/06d36746c40e4f3bacfc7b9919920d55.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
}


.login-wrapper{
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


.login-wrapper .from-name{
    padding: 0px 0px;
    margin: 0px;
    width: 100%;
    color: #0e3d8b;
    font-size: 32px;
    font-weight:600;
    line-height: 40px;
    text-align: center;
    letter-spacing:2px; 
    position:relative;
    top:-50px;
    background: linear-gradient(30deg, rgba(255,255,255,1) 0%, rgba(240,240,240,1) 50%, rgba(255,255,255,1) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-stroke:1px #000; 
    -webkit-text-stroke:1px #000; 
}


.login-form{
}


.login-form .el-form-item {
    display:flex;
    background:#fff;
    padding:0 0 0 10px;
    border-radius:4px;
}


.login-form label.el-form-item__label {
    min-width: auto;
    color:#333;
    white-space: nowrap;
}


.login-form .el-form-item__content {
    width: calc(100% - 0px);
}


.login-form .el-input__inner{
    border:2px solid #fff !important;
}
.login-form .el-input__inner:hover {
    border-color: var(--hover-border-color) !important;
    border: var(--hover-border) !important;
}
.login-form .el-input__inner:focus {
    border-color: var(--hover-border-color) !important;
}


#page .el-select .el-input__inner {
     border:2px solid #fff !important;
}
#page .el-select .el-input__inner:hover,#page .el-select .el-input__inner:focus {
    border:var(--hover-border) !important;
}
.el-select-dropdown .el-select-dropdown__item.selected {
    color: var(--swiper-theme-color) !important;
}
.el-select-dropdown .el-select-dropdown__item.hover,.el-select-dropdown .el-select-dropdown__item:hover {
    background: #f6f6f6 !important;
}


.code-row {
    display:flex;
    align-items:center;
}

.verif-code {
    width: 100px;
    text-align: center;
    margin-left: 10px;
    border-radius:var(--button-border-radius);
    height:var(--button-height);
    line-height:var(--button-line-height);
    background:#fff !important;
    border-radius:4px;
}



.btns {
    width:100%;
    padding:0 0 0 0px;
}


.loginBtn-wrapper{

}

.btns .login-btn {
    display:inline-block;
    width:100%;
    min-width:100px;
    height:40px;
    line-height:1;
    font-size:16px;
    text-align:center;
    border-radius:4px;
    background:var(--theme3) !important;
    border-color: var(--swiper-theme-color) !important;
    color: #fff !important;
margin:10px 0;
}
.btns .el-button--primary:focus,.btns .el-button--primary:hover {
}


.registerBtn-wrapper {
    width: calc(100% - 0px);
    background:none;
    margin-left:0px;
    margin-top:20px;
 }

.register-btn{
    background:#fff !important;
    border-color: var(--swiper-theme-color) !important;
}
.register-btn span{
    background:none;
    color:var(--theme);
    padding:4px 8px;
    border-radius:4px;
}


.faceBtn-wrapper{
    width:100%;
    margin-top:15px;
}

.btns .face-btn {
    display:inline-block;
    width:100%;
    min-width:100px;
    height:40px;
    line-height:1;
    font-size:14px;
    text-align:center;
    border-radius:4px;
    background:var(--theme3) !important;
    border-color: var(--swiper-theme-color) !important;
    color: #fff !important;

}
.btns .face-btn:focus,.btns .face-btn:hover {
}


.forgetBtn-wrapper {
    width: calc(100% - 0px);
    background:none;
    margin-top:15px;
    text-align:right;
margin-left:0px !important;
}

.forget-btn {
   width:100%;
    background:#fff;
    color:#59db9f;
    font-size:16px;
    text-align:center;
    height:40px;
    line-height:1;
margin-top:10px;
margin-left:0px !important;
}
.forget-btn:hover {
    background:#fff !important;
    color:#59db9f;
}

.btns .el-button{
    border: none;
}
.btns .el-button:focus,.btns .el-button:hover {
    background: none;
}
.btns .el-button:active {
    border: none;
    border-color: none;
}


#page {
    background-image: url(http://clfile.zggen.cn/20251217/96ebdd293f7e452f9b9bacc75eb4d331.webp);
}
</style>
</html>