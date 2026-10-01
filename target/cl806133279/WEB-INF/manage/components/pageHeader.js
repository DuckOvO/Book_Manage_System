window.isCollapse = {value: toolUtil.storageGet('isCollapse')?toolUtil.storageGet('isCollapse')=='true':false};
window.userInfo = {value:null}
Vue.component('page-header',{
    data(){
        return{
            sessionTable:toolUtil.storageGet('sessionTable'),
            userInfo:window.userInfo,
            isCollapse:window.isCollapse,
            moduleName:'',
        }
    },
    props:["pageName"],
    created(){
        this.getUserInfo()
        let menuList = JSON.parse(toolUtil.storageGet('menuList'))
        let p = location.href.split('/manage/')[1].split('/')
        switch (p[0]){
            case "index":return;
            case "center":this.moduleName = "个人中心";break;
            default:
                for(let i in menuList){
                    for(let j in menuList[i].child){
                        if(menuList[i].child[j].tableName==p[0]){
                            this.moduleName = menuList[i].menu
                            break;
                        }
                    }
                }
        }
    },
    methods:{
        getUserInfo(){
            const userInfo = toolUtil.storageGet('userInfo')
            if(userInfo){
                window.userInfo.value = JSON.parse(userInfo)
            }
        },
        logout(){
            Object.keys(localStorage).forEach(key=>{
                if(key.startsWith('admin_')){
                    localStorage.removeItem(key);
                }
            })
            location.href=`${baseUrl}manage/login`
        },
        navigateTo(name){
            let url = `${baseUrl}manage/`
            if(name=="index"){
                url += 'index'
            }else if(name=="info"){
                url += this.sessionTable+'/info'
            }else if(name=="updatePassword"){
                url += 'center/updatePassword'
            }
            window.location.href = url
        },
        changeCollapse(b){
            window.isCollapse.value = b
            toolUtil.storageSet('isCollapse',b)
        },
    },
    template:`
<div id="pageHeader">
    <div class="menu-switch">
        <iconfont icon="el-icon-s-fold" v-if="!isCollapse.value" @click.native="changeCollapse(true)"></iconfont>
        <iconfont icon="el-icon-s-unfold" v-else @click.native="changeCollapse(false)"></iconfont>
    </div>
    <div class="project-name">{{projectName}}</div>
    <el-dropdown >
        <div class="user-avatar">
            <img v-if="userInfo.value && userInfo.value.touxiang" :src="baseUrl+userInfo.value.touxiang"/>
            <img v-else src="http://clfile.zggen.cn/20250304/bc3321840c964618984d7c0f4523474c.webp"/>
            <iconfont icon="el-icon-caret-bottom"></iconfont>
            <span>欢迎，{{toolUtil.storageGet("username")}}</span>
        </div>
        <el-dropdown-menu class="dropdown-menu" slot="dropdown">
            <el-dropdown-item  @click.native="navigateTo('info')" >个人中心</el-dropdown-item>
            <el-dropdown-item  @click.native="navigateTo('updatePassword')">修改密码</el-dropdown-item>
            <el-dropdown-item  @click.native="logout()">退出登录</el-dropdown-item>
        </el-dropdown-menu>
    </el-dropdown>
</div>
`
})