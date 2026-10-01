<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>菜单管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/formComponent.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-header height="auto">
        <page-header page-name="菜单管理"></page-header>
    </el-header>
    <el-container>
        <page-aside>
            <template v-slot:menu>
                <page-menus></page-menus>
            </template>
        </page-aside>
            <el-main>
                <breadcrumb page-name="菜单管理"></breadcrumb>
                <div class="child-page">
                    <div class="center_view" v-if="btnAuth('menu','菜单管理')">
                        <div style="text-align: left;width: 100%;margin-bottom: 20px">
                            <el-button type="primary" style="width: 100px" @click="save">保存修改</el-button>
                        </div>
                        <el-tabs type="border-card" v-model="role_index" @tab-change="tabClick">
                            <template v-for="(role,r_index) in menus" :key="role.roleName">
                                <el-tab-pane :label="role.roleName" :name="r_index">
                                    <div v-if="r_index==role_index">
                                        <el-collapse v-model="collapse_default">
                                            <el-collapse-item v-for="(table,t_index) in role.backMenu" :name="table.menu">
                                                <template #title>
                                                    <div style="width: 100%;display: flex;justify-content: space-between;align-items: center">
                                                        <div style="font-weight: 700;font-size: 16px">{{table.menu}}</div>
                                                        <div style="padding-right: 30px">
                                                            <el-button size="small" @click.stop="moveUp(role.backMenu,t_index)">
                                                                上移
                                                            </el-button>
                                                            <el-button size="small" type="primary" @click.stop="changeName(table,role.backMenu)">
                                                                修改菜单名
                                                            </el-button>
                                                        </div>
                                                    </div>
                                                </template>
                                                <el-table
                                                    :data="table.child"
                                                    :show-header="false"
                                                    style="width: 100%;background: #edeef0;border: 1px solid #ddd">
                                                    <el-table-column
                                                        prop="menu"
                                                        label="菜单名"
                                                        width="180">
                                                    </el-table-column>
                                                    <el-table-column label="权限">
                                                        <template #default="scope">
                                                            <el-checkbox-group v-model="scope.row.buttons">
                                                                <el-checkbox v-for="item in scope.row.allButtons" :label="item" :value="item" />
                                                            </el-checkbox-group>
                                                        </template>
                                                    </el-table-column>
                                                    <el-table-column label="操作">
                                                        <template #default="scope">
                                                            <el-button size="small" @click="moveUp(table.child,scope.\$index)">
                                                                上移
                                                            </el-button>
                                                            <el-button size="small" type="primary" @click="changeName(scope.row,table.child)">
                                                                修改菜单名
                                                            </el-button>
                                                            <el-button size="small"
                                                                       type="warning"
                                                                       @click="toMove(t_index,scope.\$index)">
                                                                修改父级菜单
                                                            </el-button>
                                                        </template>
                                                    </el-table-column>
                                                </el-table>
                                            </el-collapse-item>
                                        </el-collapse>
                                    </div>
                                </el-tab-pane>
                            </template>
                        </el-tabs>
                    </div>
                    <el-dialog
                        title="修改父级菜单"
                        :visible.sync="dialogVisible"
                        width="30%">
                        <div style="display: flex;justify-content: center;align-items: center;margin-bottom: 20px">
                            <div>父级菜单：</div>
                            <el-select v-model="n_first_index" placeholder="请选择父级菜单" style="width: 200px">
                                <el-option
                                    v-for="(item,index) in menus[role_index].backMenu"
                                    :key="item.menu"
                                    :label="item.menu"
                                    :value="index">
                                </el-option>
                            </el-select>
                        </div>
                        <div style="width: 100%;text-align: center">
                            <el-button type="primary" @click="moveTo">确 定</el-button>
                        </div>
                    </el-dialog>
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
            return {
                menus:[],
                role_index:0,   //当前选中的角色index
                first_index:0, //当前选中的一级菜单index
                collapse_default:[],    //展开的collapse
                dialogVisible:false,
                n_first_index:null,     //选中的父级菜单
                o_index:0,      //需要移动的二级菜单的index
            }
        },
        created(){
            this.getMenus()
        },
        methods:{
            //权限验证
            btnAuth(e,a){
                return toolUtil.isAuth(e,a)
            },
            getMenus(){
                http.get('menu/lists').then(res=>{
                    this.menus = JSON.parse(res.data.data[0].menujson)
                    this.collapse_default = this.menus[this.role_index].backMenu.map(item=>item.menu)
                })
            },
            tabClick(){
                this.collapse_default = this.menus[this.role_index].backMenu.map(item=>item.menu)
            },
            save(){
                http.post('menu/update',{
                    id:1,
                    menujson:JSON.stringify(this.menus)
                }).then(res=>{
                    if(res.data.code==0){
                        this.\$message.success('保存成功，重新登录后生效')
                    }
                })
            },
            toMove(t_index,index){
                this.first_index = t_index
                this.n_first_index = t_index
                this.o_index = index
                this.dialogVisible = true
            },
            moveTo(){
                let items = this.menus[this.role_index].backMenu[this.first_index].child.splice(this.o_index,1)
                this.menus[this.role_index].backMenu[this.n_first_index].child.push(...items)
                this.dialogVisible = false
            },
            changeName(row,arr){
                this.\$prompt('请输入新菜单名','修改菜单名',{
                    inputValidator:(value)=>{
                        if(!value || !value.trim())return '请输入菜单名'
                        if(arr.find(item=>item.menu==value.trim())){
                            return '该菜单名已存在'
                        }
                    },
                }).then(({value})=>{
                    row.menu = value.trim()
                }).catch(()=>{})
            },
            moveUp(arr,index){
                if(index==0)return
                arr.splice(index-1,0, ...arr.splice(index,1))
                arr = JSON.parse(JSON.stringify(arr))
            },
        }
    })
</script>
<style>

</style>
</html>
