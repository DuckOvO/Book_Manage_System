<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ssm+jsp的图书管理系统</title>
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
        <div class="login-wrapper">
            <div class="form-name">ssm+jsp的图书管理系统</div>
            <el-form ref="form" :rules="rules" class="login-form" :model="form" size="small" >
                <el-form-item label="账号" prop="username" class="username">
                    <el-input v-model="form.username"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password" class="password">
                    <el-input v-model="form.password" type="password" show-password></el-input>
                </el-form-item>
                <el-form-item v-if="roleList && roleList.length>1" class="roles" prop="role" label-width="0">
                    <el-radio-group v-model="form.role">
                        <el-radio v-for="item in roleList" :key="item.roleName" :label="item.roleName"></el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <div class="btns">
                <div class="loginBtn-wrapper">
                    <el-button type="primary" class="login-btn" @click="login">登录</el-button>
                </div>
                <div class="faceBtn-wrapper">
                </div>
                <div class="registerBtn-wrapper">
                    <el-button type="text" class="register-btn"
                               @click="location.href='yonghu/register'">
                        用户注册
                    </el-button>
                </div>
                <div class="forgetBtn-wrapper">
                </div>
            </div>
        </div>
    </el-main>
</el-container>
</body>
<script src="${pageContext.request.contextPath}/static/client/static/modules/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/system.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/global_mixin.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/toolUtil.js"></script>

<script src="${pageContext.request.contextPath}/static/client/components/page-header.js"></script>
<script>
var vm = new Vue({
    el: '#page',
    data() {
        return {
            roles: [],
            form: {
                username: '',
                password: '',
                role: '',
            },
            rules: {
                username: [
                    {required: true, message: '请输入用户名', trigger: 'blur'},
                ],
                password: [
                    {required: true, message: '请输入密码', trigger: 'blur'}
                ],
                role: [
                    { required: true, message: '请选择用户类型', trigger: 'change' }
                ],
            },
            menus: [],
            roleList: [],
        }
    },
    watch: {
        showType(n){
            if(!n){
                this.stopNavigator()
            }
        }
    },
    computed: {
        roleIndex() {
            return this.roleList.findIndex(item => {
                return item.roleName == this.form.role
            })
        }
    },
    created() {
        this.init()
    },
    methods: {
        init(){
            this.getMenu()
        },
        getMenu() {
            http.get('menu/list', {
                params: {
                    page: 1,
                    limit: 1,
                    sort: 'id',
                }
            }).then(res => {
                let menus = JSON.parse(res.data.data.list[0].menujson)
                localStorage.setItem("menus", res.data.data.list[0].menujson)
                this.roleList = menus.filter(item => {
                    return item.hasFrontLogin == "是"
                })
                if(this.roleList.length==1){
                    this.form.role = this.roleList[0].roleName
                }
            })
        },
        async login() {
            this.$refs["form"].validate(async (valid) => {
                if (!valid) return false
                try {
                    let res = await http.post(this.roleList[this.roleIndex].tableName+`/login?username=\${this.form.username}&password=\${this.form.password}`)
                    this.onLoginSuccess(res.data.token)
                } catch (e) {
                }

            })
        },
        onLoginSuccess(token) {
            this.$message.success("登录成功")
            toolUtil.storageSet('sessionTable', this.roleList[this.roleIndex].tableName);
            toolUtil.storageSet('username', this.form.username);
            toolUtil.storageSet('Token', token);
            toolUtil.storageSet('role', this.form.role);
            toolUtil.storageSet('menuList', JSON.stringify(this.roleList[this.roleIndex].backMenu))
            http.get(this.roleList[this.roleIndex].tableName+`/session`).then(res => {
                toolUtil.storageSet('userInfo', JSON.stringify(res.data.data));
                toolUtil.storageSet('userid', res.data.data.id)
                if(this.roleList[this.roleIndex].tableName == 'yonghu'){
                    toolUtil.storageSet('headportrait',res.data.data.touxiang)
                }
                setTimeout(() => {
                    let redirect = toolUtil.getUrlParamsByKey("redirect")
                    let func = toolUtil.getUrlParamsByKey("func")
                    if(func){
                        return eval(encodeURIComponent(func))
                    }
                    if(redirect){
                        location.replace(decodeURIComponent(redirect))
                    }else{
                        location.replace('index')
                    }
                }, 1000)
            })
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


.login-wrapper{
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


.login-wrapper .form-name{
    font-size: 24px;
    color: #333;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin: 20px auto 10px;
    text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3);
    padding: 0 0 20px;
}


.login-form{
    width: 100%;
    background: rgba(255,255,255,0);
    padding: 0px;
    border: 0px solid #DDA0DD;
    position: relative;
}


.login-form .el-form-item {
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
    line-height: 40px;
}


.login-form label.el-form-item__label {
    width: auto;
    white-space: nowrap;
}


.login-form .el-form-item__content {
    width: 100%;
}


.login-form .el-input__inner{
    background:none;
    height: var(--input-height);
    line-height: var(--input-height);
    padding: 0 10px;
    border-radius: 6px;
    font-size: inherit;
    border: 0px solid #d1d5db;
}

.login-form .el-input__inner:hover,.login-form .el-input__inner:focus{
    border: 0px solid #a7b5ca;
}


.el-select{
   width:100%;
}
.el-select-dropdown {
    min-width: auto !important;
}
.el-select-dropdown__item.hover,.el-select-dropdown__item:hover {
    background: #f5f7fa;
}
.el-select-dropdown__item.selected {
    color: var(--swiper-theme-color);
    font-weight: 600;
}
.el-select .el-input.is-focus .el-input__inner {
    border-color: var(--swiper-theme-color);
}

.el-radio__input.is-checked+.el-radio__label{
    color: var(--theme);
}
.el-radio__input.is-checked .el-radio__inner {
    border-color: var(--theme);
    background: var(--theme);
}


.code-row {
    display:flex;
}


.code-row .verif-code {
    width: 100px;
    text-align: center;
    margin-left: 10px;
    white-space: nowrap;
    user-select: none;
}



.login-wrapper .btns {
  width:100%;
  text-align:center;
}
.login-wrapper .btns .login-btn {
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
.login-wrapper .btns .login-btn:focus,.btns .login-btn:hover {
}

.login-wrapper .faceBtn-wrapper {
    width: 100%;
    display: inline-flex;
    flex-wrap: wrap;
    justify-content: center;
}


.login-wrapper .btns .face-btn {
    width: 100%;
    height: 44px;
    line-height: 44px;
    background: var(--theme);
    border: none;
    color: #fff;
    font-size: 18px;
    text-align: center;
    margin-left: 0;
    border-radius: 4px;
    margin: 20px 0px 0 0;
    padding:0 10px;
}
.login-wrapper .btns .face-btn:focus,.btns .face-btn:hover {
}


.registerBtn-wrapper {
    width: auto;
    display: inline-flex;
    flex-wrap: wrap;
    justify-content: center;
 }

.registerBtn-wrapper .el-button{
    background: #fff;
    border: none;
    font-size: 16px;
    border:1px solid #333;
    display: inlien-block;
    height: 44px;
    line-height: 44px;
    padding: 0 10px;
    border-radius: 8px;
    color:#333;
    min-width: 100px;
    margin: 20px 20px 0 0;
}
.registerBtn-wrapper .el-button:hover{

}


.forgetBtn-wrapper {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
.forgetBtn-wrapper .el-button{
    padding: 0px;
}

.forgetBtn-wrapper .el-button--text{
    width: 100%;
    background: #fff;
    border: 0;
    font-size: 16px;
    color: #999;
    height: 40px;
    line-height: 40px;
    padding: 0px;
    border:1px solid #eee;
    border-radius: 4px;
}

#main {
    background-image: url(http://clfile.zggen.cn/20260117/73b5d9f4f9ab45d0b907fd02e9abc70e.webp);
}

</style>
</html>