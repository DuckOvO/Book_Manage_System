<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>书籍分类</title>
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
        <page-header page-name="书籍分类"></page-header>
    </el-header>
    <el-container>
        <page-aside>
            <template v-slot:menu>
                <page-menus></page-menus>
            </template>
        </page-aside>
            <el-main>
                <breadcrumb page-name="书籍分类"></breadcrumb>
                <div class="child-page">
                    <el-form :model="searchQuery" class="list-query-row"  size="medium" :inline="true" label-width="120px" >
                        <el-form-item class="query-input" label="书籍分类">
                            <el-input v-model="searchQuery.shujifenlei"
                                      placeholder="书籍分类"
                                      size="small"
                                      clearable>
                            </el-input>
                        </el-form-item>
                        <el-form-item class="query-btn">
                            <el-button type="primary" @click="searchClick()" size="small">搜索</el-button>
                        </el-form-item>
                    </el-form>
                    <div class="btns-row">
                        <el-button type="success" @click="addClick" v-if="btnAuth('shujifenlei','新增')" class="add">新增</el-button>
                        <el-button class="info" v-if=" btnAuth('shujifenlei','查看')"
                                    :type="selRows.length==1?'info':''"
                                    :disabled="selRows.length==1?false:true"
                                    @click="infoClick(null)">详情</el-button>
                        <el-button class="edit"
                                   :type="selRows.length==1?'primary':''"
                                   :disabled="selRows.length==1?false:true"
                                   @click="editClick()"
                                   v-if=" btnAuth('shujifenlei','修改')">修改</el-button>
                        <el-button class="del"
                                   :type="selRows.length?'danger':''"
                                   :disabled="selRows.length?false:true"
                                   @click="delClick(null)"
                                   v-if="btnAuth('shujifenlei','删除')">删除</el-button>
                    </div>
                    <div class="table-wrapper">
                        <el-table
                                v-loading="listLoading"
                                @selection-change="handleSelectionChange"
                                ref="table"
                                :data="list"
                                @row-click="listChange"
                                :border="false" :stripe="true" >
                            <el-table-column type="selection" width="55" class-name="selection-column"></el-table-column>
                            <el-table-column label="序号" width="70" align="center" class-name="num-column">
                                <template slot-scope="scope">{{ scope.$index + 1}}</template>
                            </el-table-column>
                            <el-table-column
                                    label="书籍分类">
                                <template slot-scope="scope">
                                    {{scope.row.shujifenlei}}
                                </template>
                            </el-table-column>
                            <el-table-column label="操作" width="200" class-name="option-column">
                                <template slot-scope="scope">
                                    <el-button size="mini" type="primary" class="info" v-if=" btnAuth('shujifenlei','查看')" @click="infoClick(scope.row.id)">
                                        详情
                                    </el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                    <el-pagination class="pagination"
                                   :total="total"
                                   :page-size="listQuery.limit"
                                   @size-change="sizeChange"
                                   @current-change="currentChange"
                                   @prev-click="prevClick"
                                   @next-click="nextClick"
                                   layout="prev, pager, next" :background="true" :hide-on-single-page="true" ></el-pagination>
                </div>
                <shujifenlei-form ref="formRef" @change="formModelChange"></shujifenlei-form>
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
<script src="${pageContext.request.contextPath}/static/manage/page/shujifenlei/formComponent.js"></script>
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return {
                userInfo:{},
                tableName:'shujifenlei',
                listLoading:false,
                listQuery:{
                    page: 1,
                    limit: 20,
                    sort: 'id',
                    order: 'desc'
                },
                searchQuery:{},
                total:0,    //记录总条数
                list:null,  //列表数据
                selRows:[], //选中的记录
            }
        },
        created(){
            this.init()
        },
        methods: {
            init(){
                this.getList()
            },
            formModelChange(){
                this.searchClick()
            },
            listChange(row){
            this.\$nextTick(()=>{
                this.\$refs['table'].clearSelection()
                this.\$refs['table'].toggleRowSelection(row)
                })
            },
            getList(){
                this.listLoading = true
                let params = JSON.parse(JSON.stringify(this.listQuery))
                params['sort'] = 'id'
                params['order'] = 'desc'
                if(this.searchQuery.shujifenlei){
                    params['shujifenlei'] = '%' + this.searchQuery.shujifenlei + '%'
                }
                http.get(`\${this.tableName}/page`,{
                    params:params
                }).then(res=>{
                    this.listLoading = false
                    this.list = res.data.data.list
                    this.total = +res.data.data.total
                })
            },
            //删
            delClick(id){
                let ids = []
                if (id) {
                    ids = [id]
                } else {
                    if (this.selRows.length) {
                        for (let x in this.selRows) {
                            ids.push(this.selRows[x].id)
                        }
                    } else {
                        return false
                    }
                }
                this.\$confirm(`是否删除选中书籍分类`, '提示', {
                    confirmButtonText: '是',
                    cancelButtonText: '否',
                    type: 'warning'
                }).then(()=>{
                    http.post(`\${this.tableName}/delete`,ids).then((res)=>{
                    this.\$message.success('操作成功')
                        this.getList()
                    })
                })
            },

            //多选
            handleSelectionChange(e){
                this.selRows = e
            },
            //列表数据
            //分页
            sizeChange(size){
                this.listQuery.limit = size
                this.getList()
            },
            currentChange(page){
                this.listQuery.page = page
                this.getList()
            },
            prevClick(){
                this.listQuery.page = this.listQuery.page - 1
                this.getList()
            },
            nextClick(){
                this.listQuery.page = this.listQuery.page + 1
                this.getList()
            },
            searchClick(){
                this.listQuery.page = 1
                this.getList()
            },
            addClick(){
                this.\$refs['formRef'].init()
            },
            //权限验证
            btnAuth(e,a){
                return toolUtil.isAuth(e,a)
            },
            infoClick(id=null){
                if(id){
                    this.\$refs['formRef'].init(id,'info')
                }else if(this.selRows.length){
                    this.\$refs['formRef'].init(this.selRows[0].id,'info')
                }
            },
            editClick(id){
                if(id){
                    this.\$refs['formRef'].init(id,'edit')
                }else if(this.selRows.length){
                    this.\$refs['formRef'].init(this.selRows[0].id,'edit')
                }
            },
            spiderClick(){

            },
            download(file){
                if(!file){
                    return this.\$message.error('文件不存在')
                }
                const a = document.createElement('a');
                a.style.display = 'none';
                a.setAttribute('target', '_blank');
                file && a.setAttribute('download', file);
                a.href = baseUrl + file;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            },
        }
    })
</script>
<style>
/*返回按钮盒子*/
.back-row {
    margin-top: 20px;
    margin-bottom: 20px;
}
.back-row>button {
    padding: 10px 20px;
    font-size: 14px;
    border-radius:4px;
}
.back-row>button:focus,.back-row>button:hover {
    color: #56c68b;
    border-color: #56c68b50;
    background: #56c68b10;
}
.back-row>button:active {
    color: #56c68b;
    border-color: #56c68b50;
    outline: none;
}

/*订单状态总盒子*/
.state-tabs{
    background:none;
    margin-bottom:0px;
    border: 0px;
}
.state-tabs .el-tabs--card>.el-tabs__header {
    margin:0px;
    border-bottom: 0px solid #dfe4ed;
}
/*订单状态盒子*/
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__nav {
    border: 0px solid #dfe4ed;
}
.state-tabs .el-tabs__nav {
}
/*订单状态item*/
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__item {
    background:#fff;
    border: 1px solid #ddd;
    margin-right:20px;
    height: 32px;
    line-height: 32px;
    transition: all 0s;
}
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__item:hover {
    color: #fff;
    border-color: var(--swiper-theme-color);
    background: var(--swiper-theme-color);
}
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__item:first-child {
   border-left: 1px solid #ddd;
}
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__item:first-child:hover {
   border-left: 1px solid var(--swiper-theme-color);
}
.state-tabs .el-tabs--card>.el-tabs__header .el-tabs__item.is-active {
    color: #fff;
    border-color: var(--swiper-theme-color);
    background: var(--swiper-theme-color);
}
.state-tabs .el-tabs__active-bar {
    background: var(--swiper-theme-color);
}

/*表单盒子*/
form.list-query-row{
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    background: none;
}
form.list-query-row .el-form-item{
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    margin-right:10px;
    margin-bottom: 10px
}
form.list-query-row .query-date .el-form-item__content{
    height:var(--button-height);
    line-height:var(--button-line-height);
}

.el-input--medium .el-input__inner {
    height: 40px;
    line-height: 40px;
}

form.list-query-row .el-input__inner {
   border-radius: 0px;
   padding: 0 10px;
   background: linear-gradient(180deg, #D7EBF8 0%, #D2F6F3 100%);
   border-radius: 5px 5px 5px 5px;
   border: 1px solid;
   border-image: linear-gradient(180deg, rgba(13.000000175088644, 104.00000140070915, 187.00000405311584, 1), rgba(31.000000052154064, 206.0000029206276, 165.00000536441803, 1), rgba(255, 255, 255, 1)) 1 1;
}

.el-range-editor--medium .el-range-input {
    background: none;
}

form.list-query-row .el-input--prefix .el-input__inner {
    padding-left: 10px
    border-radius:0px;

}
form.list-query-row .el-input--suffix .el-input__inner {
    padding-right: 10px;
    max-width: 150px;
}
form.list-query-row .el-input .el-input--suffix {
    margin: 0 5px;
}
form.list-query-row label.el-form-item__label {
    width: auto !important;
    background: none;
    padding: 0 10px;
    border: 0px solid #eee;
    border-width: 0px 0 0px 0px;
    height:var(--button-height);
    line-height:var(--button-line-height);
}
form.list-query-row .el-input__icon{
    line-height:var(--button-line-height);
}
/*箭头*/
form.list-query-row .el-input__suffix {
    right: 10px;
    color: #c0c4cc;
}
/*搜索按钮*/
form.list-query-row  .el-button--primary {
    background: linear-gradient( 134deg, var(--theme) 0%, var(--theme3) 100%);
    border-radius: 5px 5px 5px 5px;
    border: 1px solid;
    height:40px;
    line-height:40px;    
    padding:0;
    min-width:80px;
}
form.list-query-row  .el-button--primary:focus,.el-button--primary:hover {
}

/*按钮盒子*/
.btns-row {
   width:100%;
    margin-top: 10px;
    color: #333;
    text-align:right;
}
/*按钮*/
.btns-row button{
     height:32px;
     line-height:32px;
     border-radius:2px;
     font-size:12px;
     min-width:60px;
     padding:0 !important;
     border:none;
}
.btns-row button span{
     display:block;
     border-radius:2px;
}

/*新增按钮*/
.btns-row  .add{
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgba(29, 41, 57, 1);
    background: var(--theme);
    cursor: pointer;

}
.btns-row  .add:hover {
    opacity: 0.8;
}
/*详情按钮*/
.btns-row  .info{
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgba(33, 104, 197, 1);
    background: #59db9f;
    cursor: pointer;
}
.btns-row  .info:hover {
    opacity: 0.8;
}
.btns-row .info.is-disabled {
    filter: grayscale(1);
}

/*按钮修改*/
.btns-row  .edit{
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid var(--theme);
    background: #42afea;
    cursor: pointer;
}
.btns-row  .edit:hover {
    opacity: 0.8;
}
.btns-row .edit.is-disabled {
    filter: grayscale(1);
}

/*按钮删除*/
.btns-row  .del{
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 1px solid rgb(182, 43, 43);
    background: rgb(182, 43, 43);
    cursor: pointer;
}
.btns-row .del:hover {
    opacity: 0.8;
}
.btns-row .del.is-disabled {
    filter: grayscale(1);
}

/*统计图按钮*/
.btns-row  .chart {
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(168, 182, 43);
    background: rgb(168, 182, 43);
    cursor: pointer;
}
.btns-row .chart :hover {
    opacity: 0.8;
}
.btns-row .chart.is-disabled {
    filter: grayscale(1);
}

/*其他按钮*/
.btns-row  .other {
    margin: 0px 5px 5px 0px;
    padding: 0px 10px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(173, 93, 47);
    background: rgb(173, 93, 47);
    cursor: pointer;
}
.btns-row .other:hover {
    opacity: 0.8;
}
.btns-row .other.is-disabled {
    filter: grayscale(1);
}

/*表格总盒子*/
.table-wrapper {
    margin-top: 20px;
    border:20px solid transparent;
    background: linear-gradient(white, white) padding-box, linear-gradient(180deg, var(--theme3), var(--theme)) border-box;
    border-radius: 30px;
}
/*表格盒子*/
.el-table {
   background: rgba(255,255,255,0);
   border: 0px solid #eee;
}
.el-table:before {
    content: "";
    position: absolute;
    background:none;
    z-index: 1
}
/*表格头*/
.el-table .el-table__header .has-gutter tr{
    background:var(--theme3);
}
.el-table .el-table__header tr:hover{
    background:var(--theme3);
}
.el-table__header .has-gutter tr th{
    background: none;
    color:#fff;
}
.el-table tr{
    background: none;
}
/*tr悬浮颜色*/
.el-table tr:hover{
    background: #F1FAFF;
}
/*斑马纹*/
.el-table--striped .el-table__body tr.el-table__row--striped td.el-table__cell {
    background: #fff;
}
/*删除默认的背景色*/
.el-table--enable-row-hover .el-table__body tr:hover>td.el-table__cell {
    background: none;
}
/*th下横线*/
.el-table th.el-table__cell.is-leaf {
    border-bottom:0px solid #eee;
}
/*td下横线*/
.el-table td.el-table__cell {
    background: #fff;
    border-bottom: 1px solid #677f8c50;
    border-right: 1px solid #677f8c50;
}
.el-button--text{
    color:var(--swiper-theme-color);
}

/*表格按钮*/
.el-table .cell {
    display:flex;
    align-items: center;
    padding-left: 10px;
    padding-right: 10px
}

.el-table td .el-button{
    margin: 0px 6px 6px 0px;
    padding: 8px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: #fff;
    border-radius: 4px;
    border: 0px solid var(--theme);
    background: #42afea;
    cursor: pointer;
}

/*详情*/
.el-table td  .info{
    background: #59db9f;
    color: #fff;
}
.el-table td  .info:hover {
}
/*删除*/
.el-table td .delete{
    background: #db596b;
    color: #fff;
}
.el-table td .delete:hover {
}
/*跨表*/
.el-table td .cross{
    background: var(--theme);
    color: #fff;
}
.el-table td .cross:hover {
}
/*其他*/
.el-table td .some{
    background: #42afea;
    color: #fff;
}
.el-table td .some:hover {
}

/*复选框*/
.el-checkbox__inner:hover {
    border-color: #56c68b;
}
.el-checkbox__input.is-checked .el-checkbox__inner {
    background-color: #56c68b;
    border-color: #56c68b;
}
.el-checkbox__input.is-checked+.el-checkbox__label {
    color: #56c68b;
}
.el-checkbox__input.is-focus .el-checkbox__inner {
    border-color: #56c68b;
}
.el-checkbox__input.is-indeterminate .el-checkbox__inner {
    background-color: #56c68b;
    border-color: #56c68b;
}

/*分页总盒子*/
.pagination {
    text-align: center;
    margin-top: 10px;
    background: none;
}
/*分页按钮*/
.el-pagination button{
    padding: 0 6px;
}
.el-pagination button:hover {
    color:var(--swiper-theme-color);
}
.el-pagination button:disabled {
    color: #999;
    background: none;
    margin:0 2px;
    border-radius:2px;
}
.el-pagination button,.el-pagination span:not([class*=suffix]) {
    font-size: 14px;
    height: 28px;
    line-height: 28px;
}
.el-pagination .btn-next,.el-pagination .btn-prev {
    color: #666;
    font-weight:500;
    background: none;
    margin:0 2px;
    border-radius:2px;
}
.el-pager li {
    min-width:inherit;
    color: #666;
    font-size: 14px;
    font-weight:500;
    padding:0 4px;
    height: 28px;
    line-height: 28px;
    background: none;
    margin:0 5px;
    border-radius:2px;
}
.el-pager li:hover {
    color:var(--swiper-theme-color);
}
.el-pager li.active {
    color:var(--swiper-theme-color);
}
.el-pagination .el-pager li.disabled {
    color: #999;
}


/**图片列表**/
.dataList{
    width:calc(100% + 20px) ;
    margin: 20px 0 0 -10px;
    display: flex;
    flex-wrap:wrap;
}
.dataList .item{
    width:calc(25% - 20px);
    margin: 0px 10px 20px;
    background: #fff;
    padding:10px;
    cursor:pointer;
    border:1px solid var(--theme30);
}
.dataList .item .el-image{
    width:100%;
    height: 280px;
    margin-bottom:5px;
}
.dataList .item .el-image .el-image__inner{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.dataList .item .title{
    width:100%;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
    font-size: 16px;
    color: #666;
    line-height:1.5;
}
.dataList .item .price{
    width:100%;
    font-size: 18px;
    color: #f00;
    line-height:1.5;
    text-align:right;
}
.dataList .item .btns{
    width:100%;
    margin-top:10px;
}
.dataList .item .btns .view_btn{
    margin: 0px 6px 6px 0px;
    padding: 5px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(186, 226, 187);
    background: #339933;
    cursor: pointer;
}
.dataList .item .btns .edit_btn{
    margin: 0px 5px 5px 0px;
    padding: 5px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(59, 182, 43);
    background: #38d3e7;
    cursor: pointer;
}
.dataList .item .btns .del_btn{
    margin: 0px 5px 5px 0px;
    padding: 5px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: #fff;
    border-radius: 4px;
    border: 0px solid rgb(182, 43, 43);
    background: rgb(182, 43, 43);
    cursor: pointer;
}
.dataList .item .btns .operate_btn{
    margin: 0px 5px 5px 0px;
    padding: 5px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(168, 182, 43);
    background: #cd9aed;
    cursor: pointer;
}
.dataList .item .btns .cross_btn{
    margin: 0px 5px 5px 0px;
    padding: 5px;
    width: auto;
    height: auto;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(173, 93, 47);
    background: #89b2f5;
    cursor: pointer;
}
/**end**/

</style>
</html>
