<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>修改密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
    <style>
        .form{
            width: 400px;
            margin: 0 auto;
            padding-top: 30px;
        }
    </style>
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
            <breadcrumb page-name="修改密码"></breadcrumb>
            <div class="child-page">
                <el-form ref="form" :model="form" :rules="rules" class="form" label-width="80px">
                    <el-form-item label="原密码" prop="o_mima">
                        <el-input v-model="form.o_mima" type="password" placeholder="请输入原始密码"></el-input>
                    </el-form-item>
                    <el-form-item label="新密码" prop="mima">
                        <el-input v-model="form.mima" type="password" placeholder="请输入新密码"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码" prop="mima2">
                        <el-input v-model="form.mima2" type="password" placeholder="确认密码"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit" style="width: 300px;margin-top: 30px">确认修改</el-button>
                    </el-form-item>
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
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            let validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.form.mima) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            return {
                userInfo:{},
                tableName:'',
                form:{
                    o_mima:'',
                    mima:'',
                    mima2:''
                },
                rules:{
                    o_mima: [
                        { required: true, message: '请输入原密码', trigger: 'blur' },
                    ],
                    mima: [
                        { required: true, message: '请输入新密码', trigger: 'blur' },
                    ],
                    mima2: [
                        { required: true,validator:validatePass2, trigger: 'blur' },
                    ],
                }
            }
        },
        mounted(){
            this.userInfo = JSON.parse(toolUtil.storageGet("userInfo"))
            this.tableName = toolUtil.storageGet('sessionTable')
        },
        methods: {
            onSubmit(){
            this.\$refs['form'].validate(async (valid) =>{
                    if (!valid)return
                    const sessionTable = toolUtil.storageGet('sessionTable')
                    let password;
                    let minLength = 0;
                    let maxLength = 0;
                    let data = {
                        ...this.userInfo,
                    }
                    if(sessionTable=="users"){
                        password = this.userInfo.password
                        if(this.form.o_mima != password){
                            return this.\$message.error("原密码不正确")
                        }
                        data.password=this.form.mima
                    }else{
                        switch (sessionTable){
                            case "users":
                            case "yonghu":
                                password = this.userInfo.mima;
                                data.mima=this.form.mima
                                break;
                        }
                        if(this.form.o_mima != password){
                            return this.\$message.error("原密码不正确")
                        }
                        if(minLength && this.form.mima.length<minLength){
                            return this.\$message.error(`密码长度须大于等于\${minLength}位`)
                        }
                        if(maxLength && this.form.mima.length>maxLength){
                            return this.\$message.error(`密码长度须小于等于\${minLength}位`)
                        }
                    }
                    let res = await http.post(`\${this.tableName}/update`,data)
                    this.\$message.success("修改成功！")
                    let res1 = await http.get(`\${this.tableName}/session`)
                    this.userInfo = res1.data.data
                    toolUtil.storageSet('userInfo',JSON.stringify(res1.data.data));
                    toolUtil.storageSet('userid',res1.data.data.id)
                    this.form = {
                        o_mima:'',
                        mima:'',
                        mima2:''
                    }
                })
            },
        }
    })
</script>
</html>
