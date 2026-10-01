<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>客服聊天</title>
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
<div id="page" v-cloak>
    <div class="container">
        <div class="header">客服聊天</div>
        <div class="chat-content">
            <div class="chat-round" v-for="item in chatList" :key="item.id">
                <div class="chat-time" v-if="item.showTime">{{item.addtime}}</div>
                <div v-if="item.ask" class="left-content" >
                    <el-image class="avatar user-avatar" :src="userInfo.value && userInfo.value.touxiang ? baseUrl + userInfo.value.touxiang : '../../static/img/avatar.png'" style="width: 40px; height: 40px; border-radius: 100%; margin:0px 10px 0 0; flex-shrink: 0;"></el-image>
                    <el-alert v-if="!item.img" class="text-content" :title="item.ask" :closable="false" type="success"></el-alert>
                    <video v-else-if="item.ask.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                        <source  :src="baseUrl + item.ask">
                    </video>
                    <el-image v-if="item.img" :src="baseUrl + item.img" :preview-src-list="[baseUrl+item.img]"></el-image>
                </div>
                <div v-if="item.reply" class="right-content">
                    <el-image class="avatar user-avatar" src="../../static/img/avatar.png" style="width: 40px; height: 40px; border-radius: 100%; margin:0px 0px 0 10px; flex-shrink: 0;"></el-image>
                    <el-alert v-if="!item.img" class="text-content" :title="item.reply" :closable="false" type="warning"></el-alert>
                    <video v-else-if="item.reply.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                        <source  :src="baseUrl + item.reply">
                    </video>
                    <el-image v-if="item.img" :src="baseUrl + item.img" :preview-src-list="[baseUrl+item.img]"></el-image>
                </div>
            </div>
            <!-- AI思考状态 -->
            <div v-if="aiThinking" class="chat-round">
                <div class="right-content">
                    <el-image class="avatar user-avatar" src="../../static/img/avatar.png" style="width: 40px; height: 40px; border-radius: 100%; margin:0px 0px 0 10px; flex-shrink: 0;"></el-image>
                    <el-alert class="text-content" title="AI正在思考..." :closable="false" type="warning">
                        <i class="el-icon-loading el-icon--loading"></i>
                    </el-alert>
                </div>
            </div>
        </div>
        <div class="option-row">
            <el-upload :action="baseUrl+'/file/upload'" :on-success="uploadSuccess"
                       :show-file-list="false">
                    <iconfont icon="el-icon-picture-outline"></iconfont>
            </el-upload>
            <div class="service-box">
                <el-button class="service person" size="small" v-if="intelligent" @click="changeIntelligent(false)">转人工</el-button>
                <el-button class="service ai" size="small" v-else @click="changeIntelligent(true)">智能回复</el-button>
            </div>
        </div>
        <div class="input-box">
            <el-input v-model="chatForm.ask" placeholder="请输入内容" type="textarea" :rows="5" ></el-input>
        </div>
        <div class="submit-box">
            <el-button type="primary" @click="askSave" size="small">发送</el-button>
        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/static/client/static/modules/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/http.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/global_mixin.js"></script>
<script src="${pageContext.request.contextPath}/static/client/utils/toolUtil.js"></script>

<script>
var vm = new Vue({
    el: '#page',
    data(){
        return{
            chatForm:{
                ask:'',
            },
            userid:toolUtil.storageGet('userid'),
            chatList:[],
            intelligent:true,  //true智能回复  false人工
            aiThinking:false, //AI思考状态
            userInfo: window.userInfo || {value: JSON.parse(localStorage.getItem('userInfo'))},
            baseUrl: window.baseUrl || ''
        }
    },
    created(){
        this.getChatList()
        setInterval(()=>{
            this.getChatList()
        },3000)
    },
    methods: {
        changeIntelligent(b){
            this.intelligent = b
            if(b){
                this.saveChathelper("请输入您的问题")
            }else{
                this.saveChathelper("正在呼叫客服，请先描述您的问题")
            }
        },
        uploadSuccess(e){
            http.post('chat/add',{
                ask: 'file/' + e.file,
                userid: this.userid
            }).then(res=>{
                this.\$message.success('发送成功')
                this.getChatList()
                this.chatForm.ask = ''
            })
        },
        askSave(){
            if(!this.chatForm.ask || !this.chatForm.ask.trim())return this.\$message.error("请输入内容")
            http.post('chat/add',this.chatForm).then(res=>{
                this.\$message.success('发送成功')
                if (this.intelligent) {
                    let ask = this.chatForm.ask
                    setTimeout(()=>{
                        this.getChathelper(ask)
                    },1000)
                }
                this.chatForm.ask = ""
                this.getChatList()
            })
        },
         // Unicode转义序列解码函数
        decodeUnicode(str) {
            if (typeof str !== 'string') return str;
            // 解码Unicode转义序列
            return str.replace(/\\u([0-9a-fA-F]{4})/g, function (match, p1) {
                return String.fromCharCode(parseInt(p1, 16));
            });
        },
        getChathelper(ask){
             this.aiThinking = true;
            http.get('chathelper/page',{
                params: {
                    ask: ask,
                    limit: 1
                }
            }).then(res=>{
                 if (res.data.data.list.length) {
                    this.saveChathelper(res.data.data.list[0].reply)
                    this.aiThinking = false;
                } else {
                  http.get('baidu/askai', {
                        params: {
                            ask: ask
                        }
                    }).then(res=>{
                        console.log('baidu/askai response:', res);
                        if(res.data.code==0){
                            // 解码Unicode转义序列
                            let reply = this.decodeUnicode(res.data.data);
                            this.saveChathelper(reply)
                        }else {
                            this.saveChathelper('主人，我还不够聪明，无法理解您的意思！')
                        }
                        this.aiThinking = false;
                    }).catch(()=>{
                        this.aiThinking = false;
                    })
                }
            })                .catch(()=>{
                this.aiThinking = false;
                })
                    },
            //保存自动回复
        saveChathelper(reply){
            http.post('chat/save',{
                reply: reply,
                userid: this.userid
            }).then(res=>{
                this.chatForm.ask = ''
                this.getChatList()
            })
        },
        getChatList(){
            http.get('chat/page',{
                params: {
                    limit: 1000,
                    sort: 'addtime',
                    order: 'asc',
                    userid: this.userid
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
    }
})
</script>
<style>
#page {
    min-height: 100vh;
    background-color: #ededed;
    display: flex;
    align-items: center;
}
.container {
    width: 800px;
    background-color: #ffffff;
    margin: 0 auto;
    padding: 0 30px;
    border-radius: 16px;
}
.header {
    text-align: center;
    padding: 20px;
    font-weight: 700;
}
.chat-content {
    background-color: #f2f2f2;
    padding: 50px 30px;
    height: 46vh;
    overflow-y: auto;
}
.left-content {
    display: flex;
    margin-top: 10px;
}
.right-content {
    margin-top: 10px;
    display: flex;
    flex-direction: row-reverse;
}
.chat-time {
    text-align: center;
    color: #999;
    font-size: 12px;
}
.text-content {
    width: auto;
    text-align: left;
}
.option-row {
    display: flex;
    justify-content: space-between;
    padding: 10px;
}
.el-upload .iconfont {
    font-size: 34px;
    cursor: pointer;
}
.submit-box {
    padding: 20px 0;
    text-align: right;
}
.chat-round .el-image {
    width: 180px;
    background: #fff;
    padding: 10px;
    border-radius: 8px;
}
.chat-round .el-image {
    max-height: 140px;
}
.chat-round img {
    object-fit: fill;
}

</style>
</html>
