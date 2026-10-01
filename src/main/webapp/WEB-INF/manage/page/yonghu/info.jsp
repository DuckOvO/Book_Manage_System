<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>用户</title>
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
            <breadcrumb page-name="用户"></breadcrumb>
            <div class="child-page">
                <el-form ref="form" :model="user" class="form" label-width="120px" style="margin: 20px 0;">
                    <el-row>
                            <el-col :span="24">
                                <el-form-item label="用户名" prop="yonghuming">
                                    <el-input class="list_inp" v-model="user.yonghuming" disabled placeholder="用户名" clearable />
                                </el-form-item>
                            </el-col>
                            <el-col :span="24">
                                <el-form-item label="姓名" prop="xingming">
                                    <el-input class="list_inp" v-model="user.xingming"  placeholder="姓名" clearable />
                                </el-form-item>
                            </el-col>
                            <el-col :span="24">
                                <el-form-item label="性别" prop="xingbie">
                                        <el-select
                                                class="list_sel"
                                                v-model="user.xingbie"
                                                placeholder="请选择性别"
                                        >

                                        <el-option v-for="item in yonghuxingbieLists" :label="item" :value="item"></el-option>
                                    </el-select>
                                </el-form-item>
                            </el-col>
                            <el-col :span="24">
                                <el-form-item label="头像" prop="touxiang">
                                    <file-upload
                                            tip="点击上传头像"
                                            action="file/upload"
                                            :limit="3"
                                            :file-urls="user.touxiang?user.touxiang:''"
                                            @change="yonghutouxiangUploadSuccess">
                                    ></file-upload>
                                </el-form-item>
                            </el-col>
                            <el-col :span="24">
                                <el-form-item label="年龄" prop="nianling">
                                    <el-input class="list_inp" v-model="user.nianling"  placeholder="年龄" clearable />
                                </el-form-item>
                            </el-col>
                            <el-col :span="24">
                                <el-form-item label="邮箱" prop="youxiang">
                                    <el-input class="list_inp" v-model="user.youxiang"  placeholder="邮箱" clearable />
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
                    yonghuming:null,
                    xingming:null,
                    xingbie:null,
                    touxiang:null,
                    nianling:null,
                    youxiang:null,
                },
                    yonghuxingbieLists:[],
            }
        },
        mounted(){
            this.getInfo()
        },
        methods: {
            init(){
                this.yonghuxingbieLists = "男,女".split(',')
            },
            yonghutouxiangUploadSuccess(fileUrls){
                this.user.touxiang = fileUrls;
            },
            onSubmit(){
                if(!this.user.yonghuming){
                    return this.\$message.error('用户名不能为空')
                }
                if(!this.user.mima){
                    return this.\$message.error('密码不能为空')
                }
                if(!this.user.xingming){
                    return this.\$message.error('姓名不能为空')
                }
                if(this.user.touxiang!=null){
                    this.user.touxiang = this.user.touxiang.replace(new RegExp(baseUrl,"g"),"");
                }
                if((this.user.nianling)&& !toolUtil.isIntNumer(this.user.nianling) ){
                    return this.\$essage.error('年龄应输入整数')
                }
                if((this.user.youxiang)&& !toolUtil.isEmail(this.user.youxiang) ){
                    return this.\$message.error('邮箱应输入邮箱格式')
                }
                if((this.user.maxPasswordWrong)&& !toolUtil.isIntNumer(this.user.maxPasswordWrong) ){
                    return this.\$essage.error('最大密码输错次数应输入整数')
                }
                if((this.user.isLocked)&& !toolUtil.isIntNumer(this.user.isLocked) ){
                    return this.\$essage.error('用户锁定状态应输入整数')
                }
                http.post('yonghu/update',this.user).then(res=>{
                    this.\$message.success('修改成功')
                    this.getInfo()
                })
            },
            getInfo(){
                http.get('yonghu/session').then(res=>{
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
