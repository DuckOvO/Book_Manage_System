<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>管理员</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-header height="auto">
        <page-header></page-header>
    </el-header>
    <el-container>
        <page-aside>
            <template v-slot:menu>
                <page-menus></page-menus>
            </template>
        </page-aside>
        <el-main>
            <breadcrumb page-name="管理员"></breadcrumb>
            <div class="child-page">
                <el-form ref="form" :model="user" class="form" label-width="120px" style="margin: 20px 0;">
                    <el-row>
                            <el-col :span="24">
                                <el-form-item label="用户名" prop="username">
                                    <el-input class="list_inp" v-model="user.username"  placeholder="用户名" clearable />
                                </el-form-item>
                            </el-col>
                        <div class="btn-row" style="text-align: center">
                            <el-button class='userinfo_confirm' type="primary" @click="onSubmit">保存</el-button>
                        </div>
                    </el-row>
                </el-form>
            </div>
        </el-main>
    </el-container>
</el-container>
</body>
<script src="${pageContext.request.contextPath}/static/manage/static/modules/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/toolUtil.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/utils/global_mixin.js"></script>
<!--引入组件-->
<script src="${pageContext.request.contextPath}/static/manage/components/pageHeader.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/components/pageMenus.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/components/pageAside.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/components/breadcrumb.js"></script>
<script src="${pageContext.request.contextPath}/static/manage/components/FileUpload.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return {
                user:{
                    username:null,
                    role:null,
                },
            }
        },
        mounted(){
            this.getInfo()
        },
        methods: {
            init(){
            },
            onSubmit(){
                if(!this.user.username){
                    return this.\$message.error('用户名不能为空')
                }
                if(!this.user.password){
                    return this.\$message.error('密码不能为空')
                }
                http.post('users/update',this.user).then(res=>{
                    this.\$message.success('修改成功')
                    this.getInfo()
                })
            },
            getInfo(){
                http.get('users/session').then(res=>{
                    for(let key in res.data.data){
                        this.user[key] = res.data.data[key]
                    }
                    toolUtil.storageSet('userInfo',res.data.data)
                    window.userInfo.value = res.data.data
                    this.init()
                })
            },
        }
    })
</script>
</html>
