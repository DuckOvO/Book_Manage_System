Vue.component('page-menus',{
    data(){
        return{
            menuList:[],
            sessionTable:toolUtil.storageGet('sessionTable'),
            isCollapse:window.isCollapse
        }
    },
    mounted() {
        let json_menuList = toolUtil.storageGet('menuList')
        if(json_menuList){
            this.menuList = JSON.parse(json_menuList)
        }
    },
    methods:{
        menuHandler(name,menuJump){
            let url = `${baseUrl}manage/`
            if(!name){
                url += 'index'
            }else{
                if(name=='updatePassword'){
                    url += 'center/updatePassword';
                }
                else if(name=='info'){
                    url += this.sessionTable+'/info';
                }
                else if(name=='exampaper' && menuJump=='12'){
                    url += "exampaperlist/list";
                }
                else if(name=='examrecord' && menuJump=='22'){
                    url += "examfailrecord/list";
                }
                else{
                    url +=`${name}/list`
                }
            }
            if(menuJump){
                url += `?menuJump=${menuJump}`
            }
            window.location.href = url
        },
    },
    template:`
<div id="pageMenus">
    <el-menu default-active="1" :collapse="isCollapse.value" :unique-opened="true" >
        <el-menu-item index="1" @click="menuHandler()">
            <i class="icon el-icon-s-home"></i>
            <span slot="title">首页</span>
        </el-menu-item>
        <template v-for="(item,index) in menuList">
            <el-submenu :index="String(index+2)" v-if="item.child?.length">
                <template slot="title">
                    <iconfont :icon="item.fontClass"></iconfont>
                    <span slot="title">{{ item.menu }}</span>
                </template>
                <el-menu-item v-for="(child,index1) in item.child" :key="index1" :index="(index+2)+'-'+(index1+1)"
                @click="menuHandler(child.classname||child.tableName,child.menuJump,child.menuJump)">
                    {{ child.menu }}
                </el-menu-item>
            </el-submenu>
        </template>
    </el-menu>
</div>
`
})