<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>客服聊天</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/index.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-header height="auto">
        <page-header page-name="客服聊天"></page-header>
    </el-header>
    <el-container>
        <page-aside>
            <template v-slot:menu>
                <page-menus></page-menus>
            </template>
        </page-aside>
        <el-main id="main">
            <div class="child-page">
                <el-table v-loading="listLoading" :data="list" border :border="true" :stripe="true" >
                    <el-table-column label="提问">
                        <template slot-scope="scope">
                            {{scope.row.ask}}
                        </template>
                    </el-table-column>
                    <el-table-column label="状态">
                        <template slot-scope="scope">
                            <el-tag v-if="scope.row.isreply==1" >未回复</el-tag>
                            <el-tag v-if="scope.row.isreply==0" >已回复</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" size="small" @click="replyClick(scope.row)">回复</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination
                        class="pagination"
                        :total="total"
                        :page-size="listQuery.limit"
                        :current-page.sync="listQuery.page"
                        @current-change="currentChange"
                        layout="prev, pager, next" :background="true" :hide-on-single-page="true" ></el-pagination>
                <el-dialog class="chat-dialog" :visible.sync="formVisible" title="回复" destroy-on-close @close="delTimer" :fullscreen="false" width="46%" :close-on-click-modal="false" >
                    <div class="chat-content">
                        <div v-for="item in chatList" :key="item.id" class="chat-round">
                            <div class="chat-tiem" v-if="item.showTime">{{item.addtime}}</div>
                            <div v-if="item.ask" class="left-content" >
                                <div v-if="!item.img" class="text-content">{{item.ask}}</div>
                                <video v-else-if="item.ask.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                                    <source  :src="baseUrl + item.ask">
                                </video>
                                <el-image v-if="item.img" :src="baseUrl + item.img" class="chat_img"
                                           :preview-src-list="[baseUrl+item.img]"></el-image>
                            </div>
                            <div v-if="item.reply" class="right-content">
                                <div v-if="!item.img" class="text-content">{{item.reply}}</div>
                                <video v-else-if="item.reply.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                                    <source  :src="baseUrl + item.reply">
                                </video>
                                <el-image v-if="item.img" :src="baseUrl + item.img" class="chat_img"
                                           :preview-src-list="[baseUrl+item.img]"></el-image>
                            </div>
                        </div>
                    </div>
                    <div class="option-row">
                        <el-upload class="imgUpload" :action="baseUrl+'/file/upload'" :on-success="uploadSuccess"
                                   :show-file-list="false">
                            <i class="el-icon-picture-outline img-icon"></i>
                        </el-upload>
                    </div>
                    <div class="input-box">
                        <el-input v-model="replyInput" placeholder="请回复" type="textarea" />
                    </div>
                    <div class="submit-box">
                        <el-button type="primary" @click="replySave">发送</el-button>
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
<script>
    var vm = new Vue({
        el: '#page',
        data(){
            return {
                list:[],
                listQuery:{
                    page: 1,
                    limit: 20,
                    sort: 'id',
                    order: 'desc',
                    isreply: 1
                },
                listLoading:false,
                formVisible:false,
                total:0,
                nowId:0,
                chatList:[],
                replyInput:'',
            }
        },
        mounted(){
            this.getList()
        },
        methods: {
            uploadSuccess(e){
                http.post('chat/save',{
                    reply:'file/' + e.file,
                    userid:this.nowId
                }).then(res=>{
                    this.replyInput = ''
                    this.\$message.success('发送成功')
                    this.getChatList()
                })
            },
            replySave(){
                if(this.replyInput){
                    http.post('chat/save',{
                        userid:this.nowId,
                        reply:this.replyInput
                    }).then(res=>{
                        this.replyInput = ''
                        this.\$message.success('发送成功')
                        this.getChatList()
                    })
                }
            },
            getList(){
                this.listLoading = true
                http.get('chat/page',{
                    params:this.listQuery
                }).then(res=>{
                    this.listLoading = false
                    this.list =  res.data.data.list
                    this.total = +res.data.data.total
                })
            },
            currentChange(page){
                getList()
            },
            replyClick(row){
                this.nowId = row.userid
                this.getChatList()
                this.formVisible = true
                this.timer = setInterval(()=>{
                    this.getChatList()
                },3000)
            },
            getChatList(){
                http.get('chat/page',{
                    params:{
                        limit: 1000,
                        sort: 'addtime',
                        order: 'asc',
                        userid: this.nowId
                    }
                }).then(res=>{
                    let list = res.data.data.list.map((item,index)=>{
                        if(item.ask){
                            if(/^file\//.test(item.ask)){
                                item.img = item.ask
                            }
                        }
                        if(item.reply){
                            if(/^file\//.test(item.reply)){
                                item.img = item.reply
                            }
                        }
                        if(index==0){
                            item.showTime = true
                        }else{
                            let jian = new Date(item.addtime).getTime() - new Date(res.data.data.list[index-1].addtime).getTime()
                            if(jian>18000){
                                item.showTime = true
                            }else{
                                item.showTime = false
                            }
                        }
                        return item
                    })
                    this.chatList = list
                    this.\$nextTick(()=>{
                        let dom = document.getElementsByClassName('chat-content')[0]
                        setTimeout(() => {
                            if (dom && dom.scrollTop==0)dom.scrollTop = dom.scrollHeight
                        }, 100)
                    })
                })
            },
            delTimer(){
                clearInterval(this.timer)
            },
        },
        ondestroy(){
            this.delTimer()
        }
    })
</script>
<style>
.el-table{
  margin:10px 0 0;
}

.pagination {
    text-align: center;
    padding: 30px 0;
}
.chat-content{
  padding: 30px;
  height: 34vh;
  overflow-y: auto;

  background: #fff;
  border-radius: 5px;
  border: 1px solid;
  border-image: linear-gradient(132deg, rgba(1.0000000591389835, 122.00000032782555, 188.0000039935112, 1), rgba(75.2375815808773, 203.8300609588623, 163.53535115718842, 1), rgba(89.00000229477882, 219.0000021457672, 159.0000057220459, 1)) 1 1;
}
.chat-tiem {
  text-align: center;
}
.text-content{
  width: auto;
  text-align: left;
}
.left-content{
  margin-top: 10px;
  display: flex;
}
.left-content .text-content {
  background-color: #f0f9eb;
  color: #67c23a;
  padding: 8px 16px;
  border-radius: 4px;
  max-width: 80%;
}
.right-content{
  margin-top: 10px;
  display: flex;
  flex-direction: row-reverse;
}
.right-content .text-content {
  background-color: #fdf6ec;
  color: #e6a23c;
  padding: 8px 16px;
  border-radius: 4px;
  max-width: 80%;
}
.chat-content .chat_img{
  background-color: #fff;
  padding: 10px;
  border-radius: 8px;
  max-width: 40%;
}
.chat-dialog .option-row {
  padding: 10px 0;
}

.chat-dialog .img-icon {
  cursor: pointer;
  font-size: 34px;
}

.chat-dialog textarea {
  min-height: 100px!important;
  background: #fff;
  border-radius: 5px;
  border: 1px solid;
  border-image: linear-gradient(132deg, rgba(1.0000000591389835, 122.00000032782555, 188.0000039935112, 1), rgba(75.2375815808773, 203.8300609588623, 163.53535115718842, 1), rgba(89.00000229477882, 219.0000021457672, 159.0000057220459, 1)) 1 1;
}

.submit-box {
  margin-top: 20px;
  text-align: right;
}
</style>
</html>
