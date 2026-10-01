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
    <script src="${pageContext.request.contextPath}/static/client/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/swiper/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/iconfont/iconfont.js"></script>
    <script src="${pageContext.request.contextPath}/static/client/static/modules/moment.min.js"></script>
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
                    <div class="user-menu">
                        <el-menu ref="menu" default-active="0" mode="horizontal" >
                            <el-menu-item index="center" @click="tabClick({tableName:'center'})">个人中心</el-menu-item>
                            <el-menu-item index="password" @click="tabClick({tableName:'updatePassword'})">修改密码</el-menu-item>
                            <el-menu-item index="storeup_sc" @click="tabClick({tableName:'storeup',type:1})">我的收藏</el-menu-item>
                            <template v-for="(item,index) in menuList">
                                <el-submenu v-if="item.child.length>1" :key="index" :index="index+1+''">
                                    <template slot="title">{{item.menu}}</template>
                                    <el-menu-item :index="`\${index+1}-\${indexs}`" v-for="(items,indexs) in item.child" @click="tabClick(items)">{{items.menu}}</el-menu-item>
                                </el-submenu>
                                <el-menu-item v-else-if="hasBack(item.child[0])" :index="index+1+''" @click="tabClick(item.child[0])">{{item.child[0].menu}}</el-menu-item>
                            </template>
                        </el-menu>
                    </div>
                    <div class="user-form" style="flex: 1">
                        <el-form v-if="tabIndex=='center'" ref="userFormRef" :model="userForm" :rules="rules" label-width="120px" >
                            <el-form-item prop="yonghuming" label="用户名" class="input-item">
                                <el-input v-model="userForm.yonghuming" placeholder="用户名" readonly></el-input>
                            </el-form-item>
                            <el-form-item prop="xingming" label="姓名" class="input-item">
                                <el-input v-model="userForm.xingming" placeholder="姓名" ></el-input>
                            </el-form-item>
                            <el-form-item label="性别" prop="xingbie" class="select-item">
                                <el-select
                                        v-model="userForm.xingbie"
                                        placeholder="请选择性别">
                                    <el-option v-for="(item,index) in xingbieLists" :label="item" :value="item">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item prop="touxiang" label="头像" class="upload-item img-upload-item">
                                <file-upload
                                        action="file/upload"
                                        tip="请上传头像"
                                        :limit="1"
                                        :file-urls="userForm.touxiang?userForm.touxiang:''"
                                        @change="touxiangUploadSuccess">
                                </file-upload>
                            </el-form-item>
                            <el-form-item prop="nianling" label="年龄" class="input-item">
                                <el-input v-model="userForm.nianling" placeholder="年龄" ></el-input>
                            </el-form-item>
                            <el-form-item prop="youxiang" label="邮箱" class="input-item">
                                <el-input v-model="userForm.youxiang" placeholder="邮箱" ></el-input>
                            </el-form-item>
                            <el-form-item class="btn-item">
                                <el-button @click="updateSession">更新信息</el-button>
                            </el-form-item>
                        </el-form>
                        <el-form v-if="tabIndex=='updatePassword'" ref="passwordFormRef" class="password-form" :model="passwordForm" :rules="passwordRules" label-width="140px"
                                 style="display: flex;flex-direction: column;justify-content: center;align-items: center;">
                            <el-form-item label="原密码" class="input-item" prop="o_mima">
                                <el-input v-model="passwordForm.o_mima" placeholder="原密码" type="password" style="width: 400px"></el-input>
                            </el-form-item>
                            <el-form-item label="新密码" class="input-item" prop="mima">
                                <el-input v-model="passwordForm.mima" placeholder="新密码" type="password" style="width: 400px"></el-input>
                            </el-form-item>
                            <el-form-item label="确认密码" class="input-item" prop="mima2">
                                <el-input v-model="passwordForm.mima2" placeholder="确认密码" type="password" style="width: 400px"></el-input>
                            </el-form-item>
                            <div class="passwordSubmit" style="text-align: center">
                                <el-button type="primary" style="width: 140px" @click="updatePassword">确认修改</el-button>
                            </div>
                        </el-form>
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
<script src="${pageContext.request.contextPath}/static/client/components/FileUpload.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/swiper.js"></script>
<script src="${pageContext.request.contextPath}/static/client/components/page-swiper.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            let validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.passwordForm.mima) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            return{
                payTypeList:[{
                    name:"微信支付",
                    icon:'static/client/static/img/pay_icon/weixin.png'
                },{
                    name:"支付宝支付",
                    icon:'static/client/static/img/pay_icon/zhifubao.png'
                },{
                    name:"建设银行",
                    icon:'static/client/static/img/pay_icon/jianshe.png'
                },{
                    name:"农业银行",
                    icon:'static/client/static/img/pay_icon/nongye.png'
                },{
                    name:"中国银行",
                    icon:'static/client/static/img/pay_icon/zhongguo.png'
                },{
                    name:"交通银行",
                    icon:'static/client/static/img/pay_icon/jiaotong.png'
                }],
                tableName:'yonghu',
                userForm:{
                    yonghuming:null,
                    mima:null,
                    xingming:null,
                    xingbie:null,
                    touxiang:null,
                    nianling:null,
                    youxiang:null,
                    maxPasswordWrong:null,
                    isLocked:null,
                },
                rules:{
                    yonghuming: [
                        {required: true,message: '请输入',trigger: 'blur'},
                    ],
                    mima: [
                        {required: true,message: '请输入',trigger: 'blur'},
                    ],
                    xingming: [
                        {required: true,message: '请输入',trigger: 'blur'},
                    ],
                    xingbie: [
                    ],
                    touxiang: [
                    ],
                    nianling: [
                        { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                    ],
                    youxiang: [
                        { validator: toolUtil.fromValidate.email, trigger: 'blur' },
                    ],
                },
                menuList:[],
                role:'',
                //性别列表
                xingbieLists:[],
                tabIndex:'center',
                passwordForm:{
                    o_mima:'',
                    mima:'',
                    mima2:''
                },
                passwordRules:{
                    o_mima: [
                        { required: true, message: '请输入原密码', trigger: 'blur' },
                    ],
                    mima: [
                        { required: true, message: '请输入新密码', trigger: 'blur' },
                    ],
                    mima2: [
                        { required: true,validator:validatePass2, trigger: 'blur' },
                    ],
                },
            }
        },
        created(){
            this.init()
        },
        methods: {
            getSession(){
                this.getUserInfo().then(res=>{
                    toolUtil.storageSet('username', res.data.data.yonghuming)
                    toolUtil.storageSet("adminName", res.data.data.yonghuming)
                    toolUtil.storageSet('headportrait',res.data.data.touxiang)
                    this.userForm = res.data.data
                })
            },
            hasBack(menu){
                if(menu.tableName=='storeup'){
                    return false
                }
                return true
            },
            //菜单跳转
            tabClick(item){
                if (item.tableName == 'center') {
                    this.tabIndex = 'center'
                    this.getSession()
                    return
                }
                if(item.tableName == 'updatePassword'){
                    this.tabIndex = 'updatePassword'
                    this.getSession()
                    return
                }
                navigateTo(item)
            },
            //头像上传回调
            touxiangUploadSuccess(e){
                this.userForm.touxiang = e
            },
            //初始化
            init(){
                this.role = toolUtil.storageGet('role')
                this.menuList = window.menus.find(item=>{
                    return item.roleName == this.role
                })?.backMenu
                this.xingbieLists = "男,女".split(',')
                this.getSession()
            },
            updateSession(){
                this.\$refs.userFormRef.validate((valid)=>{
                    if(!valid)return
                    if(this.userForm.touxiang!=null){
                        this.userForm.touxiang = this.userForm.touxiang.replace(new RegExp(baseUrl,"g"),"");
                    }
                    http.post(this.tableName+`/update`,this.userForm).then(res=>{
                        this.\$message.success('更新成功')
                        this.getSession()
                    })
                })
            },
            updatePassword(){
                this.\$refs['passwordFormRef'].validate(async (valid)=>{
                    if (!valid)return
                    let password = this.userForm.mima;
                    if(this.passwordForm.o_mima != password){
                        return this.\$message.error("原密码不正确")
                    }
                    let data = {
                        ...this.userForm,
                        mima:this.passwordForm.mima
                    }
                    let res = await http.post(this.tableName+`/update`,data)
                    this.\$message.success("修改成功！")
                    this.getSession()
                    this.passwordForm = {
                        o_mima:'',
                        mima:'',
                        mima2:''
                    }
                    this.tabIndex = "center"
                    this.\$refs.menu.activeIndex = 'center'
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
    margin: 30px auto 0;
    background: #FFF7F1;
    box-shadow: inset 0px -20px 30px 0px #FFFFFF, inset 0px 10px 10px 0px rgba(102, 102, 102, 0.13);
    border-radius: 30px 30px 30px 30px;
    border: 5px solid #FFFFFF;
    padding: 0 20px 20px;
}


.user-menu{
}
.user-menu .el-menu {
    width: 100%;
    box-sizing: border-box;
    background: none;
    display: flex;
    flex-wrap:wrap;
    justify-content: center;
    padding: 20px 10% 50px;
    gap: 20px;
    background: url(http://clfile.zggen.cn/20260119/4435a219ee554c0eb2a86ccd4916e5a5.png) no-repeat;
    background-size: 100% 100%;
}
.el-menu.el-menu--horizontal {
    border-bottom:0;
}

.user-menu .el-menu .el-menu-item{
    padding: 0 20px;
    box-sizing: border-box;
    cursor: pointer;
    color: #000000;
    text-align: center;
    position: relative;
    height: 50px;
    line-height: 50px;
    background: #eee;
    border-radius: 6px;
    border-bottom:none;
    border:1px solid #eee;
}
.user-menu .el-menu .el-menu-item:focus,.user-menu .el-menu .el-menu-item:hover {
    color: #fff;
    background: var(--theme);
    border-bottom:none;
}
.user-menu .el-menu .el-menu-item.is-active {
    color: #fff !important;
    background: var(--theme) !important;
    font-weight:600;
    border-bottom:none;
}

.user-menu .el-menu .el-submenu{
    border-bottom:none;
}
.user-menu .el-menu .el-submenu .el-submenu__title {
    padding: 0 20px !important;
    box-sizing: border-box;
    cursor: pointer;
    color: #000000;
    text-align: center;
    position: relative;
    height: 50px;
    line-height: 50px;
    background: #eee;
    border-radius: 6px;
    border:1px solid #eee;
    border-bottom:none;
}
.user-menu .el-menu .el-submenu .el-submenu__title i {
    color: #909399;
}
.user-menu .el-menu .el-submenu .el-submenu__title:hover i {
    color: #fff;
}
.user-menu .el-menu .el-submenu .el-submenu__title:hover {
    color: #fff;
    background: var(--theme);
    border-bottom:none;
    width: auto;
    padding:0;
}
.user-menu .el-menu .el-submenu .el-submenu__title:focus {
    color: #fff;
    background: var(--theme);
    border-bottom:none;
}
.user-menu .el-menu .el-submenu.is-opened{
    width: auto;
    padding:0;
}


.user-form {
    background: none;
    padding: 30px 50px 30px 10px;
    border-radius: 0px;
    margin-left: 30px;
}

.user-form .el-form {
    display: flex;
    flex-wrap: wrap;
}
.user-form .el-form .el-form-item {
    min-width: 50%;
}
.user-form .el-form .el-form-item .el-form-item__label{
    width: auto !important;
    text-align:right;
    background: none;
    color: #333;
    padding: 0 12px 0 0;
    min-width:200px;
    height: 32px;
    line-height: 32px;
}
.user-form .el-form .el-form-item .el-form-item__content{
    display:flex;
    align-item:center;
    line-height: 32px;
}
.user-form .el-form .el-form-item .el-form-item__content .el-input__inner{
    height: 32px;
    line-height: 32px;
    border-radius:6px;
}
.user-form .el-form .el-form-item .el-form-item__content .el-input__inner:hover {
    border-color: --hover-border-color;
}
.user-form .el-form .el-form-item .el-form-item__content .el-input__inner:focus {
    border-color: var(--swiper-theme-color);
}


.user-form .el-form .el-form-item .el-button {
    background: #fff;
    border: 1px solid #dcdfe6;
    border-color: #dcdfe6;
    color: #606266;
    text-align: center;
    margin: 0;
    padding: 0px 20px;
    font-size: 14px;
    border-radius: 4px;
    margin-left: 10px;
    height: 32px;
    line-height: 32px;
}
.user-form .el-form .el-form-item .el-button.is-round {
    padding: 12px 20px;
}
.user-form .el-form .el-form-item .el-button:focus,.el-button:hover {
    color: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
    background: var(--hover-background10);
}
.user-form .el-form .el-form-item .el-button:active {
    color: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}


.user-form .el-form .el-form-item .el-radio-group{
    line-height: 40px;
}

.el-radio__input.is-checked+.el-radio__label {
    color: var(--swiper-theme-color);
}

.el-radio__input.is-checked .el-radio__inner {
    border-color: var(--swiper-theme-color);
    background: var(--swiper-theme-color);
}
.el-radio__input.is-focus .el-radio__inner {
    border-color: var(--swiper-theme-color);
}

.el-checkbox__inner:hover {
    border-color: var(--swiper-theme-color);
}
.el-checkbox__input.is-checked .el-checkbox__inner {
    background: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}
.el-checkbox__input.is-checked+.el-checkbox__label {
    color: var(--swiper-theme-color);
}
.el-checkbox__input.is-focus .el-checkbox__inner {
    border-color: var(--swiper-theme-color);
}
.el-checkbox__input.is-indeterminate .el-checkbox__inner {
    background: var(--swiper-theme-color);
    border-color: var(--swiper-theme-color);
}


.upload-item {
    width: 100%;
}
.el-upload--picture-card {
    background: var(--hover-background10);
    border: 1px dashed --hover-background30;
    border-radius: 6px;
    width: 148px;
    height: 80px;
    line-height: 80px;
    vertical-align: top
}
.el-upload--picture-card i {
    font-size: 28px;
    color: #999;
}
.el-upload--picture-card:hover,.el-upload:focus {
    border-color: var(--swiper-theme-color);
    color: var(--swiper-theme-color);
}
.el-upload--picture-card:hover i {
    color: var(--swiper-theme-color);
}
.el-upload:focus .el-upload-dragger {
    border-color: var(--swiper-theme-color);
}

.textarea-item {
    width: 100%;
}

.textarea-item  .el-textarea{
    width: 60%;
}
.el-textarea__inner:hover {
    border-color: --hover-border-color;
}
.el-textarea__inner:focus {
    border-color: var(--swiper-theme-color);
}

.rich-item {
    width: 100%;
}
.rich-item .ql-toolbar{
}
.rich-item .editor-container{
    height:auto;
    min-height:240px !important;
}
.rich-item .editor-container .ql-editor{
    height:auto;
}


.user-form .el-form .btn-item {
    width: 100%;
    margin-top:20px;
    padding:0px;
    clear:both;
    background: none;
}
.user-form .el-form .btn-item .el-form-item__content{
    margin-left:200px !important;
    display:flex;
    align-item:center;
    justify-content:center;
}

.user-form .el-form .btn-item .el-form-item__content .el-button {
    text-align: center;
    margin: 0;
    padding: 0px 20px;
    font-size: 14px;
    border-radius: 4px;
    margin-left: 0px;
    color: #fff;
    border-color: var(--swiper-theme-color);
    background: var(--swiper-theme-color);
    height: 36px;
    line-height: 36px;
}
.user-form .el-form .btn-item .el-form-item__content .el-button:hover {
    color: var(--swiper-theme-color);
    border-color: --hover-border-color;
    background: var(--hover-background10);
}

</style>
</html>
