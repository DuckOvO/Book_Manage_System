Vue.component('tushuxujie-form',{
    template: `
    <div>
        <el-dialog :fullscreen="false" width="80%" 
                   :visible.sync="formVisible"
                   :title="formTitle"
                   v-if="formVisible"
                   custom-class="formModel">
            <el-form ref="formRef" :model="form" class="formModel_form" :rules="rules" label-width="120px" >
                <el-form-item label="租借编号" prop="zujiebianhao" class="input-item">
                    <el-input v-model="form.zujiebianhao" placeholder="租借编号"
                              type="text"
                        :readonly="!isAdd||disabledForm.zujiebianhao?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="书籍名称" prop="shujimingcheng" class="input-item">
                    <el-input v-model="form.shujimingcheng" placeholder="书籍名称"
                              type="text"
                        :readonly="!isAdd||disabledForm.shujimingcheng?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="封面" prop="fengmian" class="upload-item img-upload-item">
                    <file-upload
                            :disabled="!isAdd||disabledForm.fengmian?true:false"
                            action="file/upload"
                            tip="请上传封面"
                            :limit="3"
                            :fileUrls="form.fengmian?form.fengmian:''"
                            @change="fengmianUploadSuccess">
                    </file-upload>
                </el-form-item>
                <el-form-item label="书籍分类" prop="shujifenlei" class="select-item">
                    <el-select
                            :disabled="!isAdd||disabledForm.shujifenlei?true:false"
                            v-model="form.shujifenlei"
                            placeholder="请选择书籍分类"
                    >
                    <el-option v-for="(item,index) in shujifenleiLists" :label="item"
                               :value="item"
                        >
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="ISBN" prop="bianma" class="input-item">
                    <el-input v-model="form.bianma" placeholder="ISBN"
                              type="text"
                        :readonly="!isAdd||disabledForm.bianma?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="借阅数量" prop="jieyueshuliang" class="input-item">
                    <el-input v-model="form.jieyueshuliang" placeholder="借阅数量"
                              type="text"
                        :readonly="!isAdd||disabledForm.jieyueshuliang?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="用户名" prop="yonghuming" class="input-item">
                    <el-input v-model="form.yonghuming" placeholder="用户名"
                              type="text"
                        :readonly="!isAdd||disabledForm.yonghuming?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="xingming" class="input-item">
                    <el-input v-model="form.xingming" placeholder="姓名"
                              type="text"
                        :readonly="!isAdd||disabledForm.xingming?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="借阅时间" prop="jieyueshijian" class="date-item">
                    <el-date-picker
                            v-model="form.jieyueshijian"
                            format="yyyy-MM-dd HH:mm:ss"
                            value-format="yyyy-MM-dd HH:mm:ss"
                            type="datetime"
                            :readonly="!isAdd||disabledForm.jieyueshijian?true:false"
                            placeholder="请选择借阅时间" ></el-date-picker>
                </el-form-item>
                <el-form-item label="归还时间" prop="guihaishijian" class="date-item">
                    <el-date-picker
                            v-model="form.guihaishijian"
                            format="yyyy 年 MM 月 dd 日"
                            value-format="yyyy-MM-dd"
                            type="datetime"
                            :readonly="!isAdd||disabledForm.guihaishijian?true:false"
                            placeholder="请选择归还时间"
                            ></el-date-picker>
                </el-form-item>
                <el-form-item label="续借时间" prop="xujieshijian" class="date-item">
                    <el-date-picker
                            v-model="form.xujieshijian"
                            format="yyyy 年 MM 月 dd 日"
                            value-format="yyyy-MM-dd"
                            type="datetime"
                            :readonly="!isAdd||disabledForm.xujieshijian?true:false"
                            placeholder="请选择续借时间"
                            ></el-date-picker>
                </el-form-item>
            </el-form>
            <div v-if="isAdd||type=='reply'" class="formModel-btns">
                <el-button class="formModel_cancel" @click="closeClick">取消</el-button>
                <el-button class="formModel_confirm" type="primary" @click="save">
                    提交
                </el-button>
            </div>
        </el-dialog>
    </div>
`,
    data(){
        return{
            sessionTable:localStorage.getItem('sessionTable'),
            tableName:'tushuxujie',
            formName:'图书续借',
            formVisible:false,
            formTitle:'',
            form:{
                zujiebianhao: '',
                shujimingcheng: '',
                fengmian: '',
                shujifenlei: '',
                bianma: '',
                jieyueshuliang: '1',
                yonghuming: '',
                xingming: '',
                shhf: '',
                jieyueshijian: '',
                guihaishijian: '',
                xujieshijian: '',
            },
            id:0,
            type:'',
            disabledForm:{
                zujiebianhao : false,
                shujimingcheng : false,
                fengmian : false,
                shujifenlei : false,
                bianma : false,
                jieyueshuliang : false,
                yonghuming : false,
                xingming : false,
                sfsh : false,
                shhf : false,
                jieyueshijian : false,
                guihaishijian : false,
                xujieshijian : false,
            },
            isAdd:false,
            rules:{
                zujiebianhao: [
                ],
                shujimingcheng: [
                ],
                fengmian: [
                ],
                shujifenlei: [
                ],
                bianma: [
                ],
                jieyueshuliang: [
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
                yonghuming: [
                ],
                xingming: [
                ],
                sfsh: [
                ],
                shhf: [
                ],
                jieyueshijian: [
                ],
                guihaishijian: [
                ],
                xujieshijian: [
                ],
            },
            //书籍分类列表
                shujifenleiLists:[],
            crossRow:'',
            crossTable:'',
            crossTips:'',
            crossColumnName:'',
            crossColumnValue:'',
        }
    },
    watch:{
    },
    methods:{
        //获取唯一标识
        getUUID(){
            return new Date().getTime();
        },
        //封面上传回调
        fengmianUploadSuccess(e){
            this.form.fengmian = e
        },
        getInfo(){
            http.get(this.tableName+`/info/`+this.id).then(res=>{
                this.form = res.data.data
                this.formVisible = true
            })
        },
        init(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null){
            this.form.jieyueshijian = toolUtil.getCurDateTime()
            if(formId){
                this.id = formId
                this.type = formType
            }
            if(formType == 'add'){
                this.isAdd = true
                this.formTitle = '新增' + this.formName
                this.formVisible = true
            } else if(formType == 'info'){
                this.isAdd = false
                this.formTitle = '查看' + this.formName
                this.getInfo()
            } else if(formType == 'edit'){
                this.isAdd = true
                this.formTitle = '修改' + this.formName
                this.getInfo()
            } else if(formType == 'reply'){
                this.type = formType
                this.isAdd = true
                this.disabledForm.cpicture = true
                this.disabledForm.content = true
                this.formTitle = '回复'
                this.getInfo()
            } else if(formType == 'cross'){
                this.isAdd = true
                this.formTitle = formNames
                for(let x in row){
                    if(x=='zujiebianhao'){
                        this.form.zujiebianhao = row[x];
                        this.disabledForm.zujiebianhao = true;
                        continue;
                    }
                    if(x=='shujimingcheng'){
                        this.form.shujimingcheng = row[x];
                        this.disabledForm.shujimingcheng = true;
                        continue;
                    }
                    if(x=='fengmian'){
                        this.form.fengmian = row[x];
                        this.disabledForm.fengmian = true;
                        continue;
                    }
                    if(x=='shujifenlei'){
                        this.form.shujifenlei = row[x];
                        this.disabledForm.shujifenlei = true;
                        continue;
                    }
                    if(x=='bianma'){
                        this.form.bianma = row[x];
                        this.disabledForm.bianma = true;
                        continue;
                    }
                    if(x=='jieyueshuliang'){
                        this.form.jieyueshuliang = row[x];
                        this.disabledForm.jieyueshuliang = true;
                        continue;
                    }
                    if(x=='yonghuming'){
                        this.form.yonghuming = row[x];
                        this.disabledForm.yonghuming = true;
                        continue;
                    }
                    if(x=='xingming'){
                        this.form.xingming = row[x];
                        this.disabledForm.xingming = true;
                        continue;
                    }
                    if(x=='jieyueshijian'){
                        this.form.jieyueshijian = row[x];
                        this.disabledForm.jieyueshijian = true;
                        continue;
                    }
                    if(x=='guihaishijian'){
                        this.form.guihaishijian = row[x];
                        this.disabledForm.guihaishijian = true;
                        continue;
                    }
                    if(x=='xujieshijian'){
                        this.form.xujieshijian = row[x];
                        this.disabledForm.xujieshijian = true;
                        continue;
                    }
                }
                if(row){
                    this.crossRow = row
                }
                if(table){
                    this.crossTable = table
                }
                if(tips){
                    this.crossTips = tips
                }
                if(statusColumnName){
                    this.crossColumnName = statusColumnName
                }
                if(statusColumnValue){
                    this.crossColumnValue = statusColumnValue
                }
                this.form.jieyueshuliang='1'
                this.formVisible = true
            }
            http.get(this.sessionTable+'/session').then(res=>{
                var json = res.data.data
                if(toolUtil.storageGet("role")!="管理员") {
                    this.disabledForm.jieyueshuliang = true;
                }
                if((json.yonghuming || json.yonghuming==0) && toolUtil.storageGet("role")!="管理员"){
                    this.form.yonghuming = json.yonghuming
                    this.disabledForm.yonghuming = true;
                }
                if((json.xingming || json.xingming==0) && toolUtil.storageGet("role")!="管理员"){
                    this.form.xingming = json.xingming
                    this.disabledForm.xingming = true;
                }
                if (localStorage.getItem('autoSave')) {
                    localStorage.removeItem('autoSave')
                    this.save()
                }
            })
            http.get(`option/shujifenlei/shujifenlei`).then(res=>{
                this.shujifenleiLists = res.data.data
            })
        },
        //关闭
        closeClick(){
            this.formVisible = false
        },
        //提交
        save(){
            if(this.form.fengmian!=null) {
                this.form.fengmian = this.form.fengmian.replace(new RegExp(baseUrl,"g"),"");
            }
            let objcross;
            let crossUserId = ''
            let crossRefId = ''
            let crossOptNum = ''
            if(this.type == 'cross'){
                objcross = JSON.parse(JSON.stringify(this.crossRow))
                if(this.crossColumnName!=''){
                    if(!this.crossColumnName.startsWith('[')){
                        for(let o in objcross){
                            if(o == this.crossColumnName){
                                objcross[o] = this.crossColumnValue
                            }
                        }
                    }else{
                        crossUserId = toolUtil.storageGet('userid')
                        crossRefId = objcross['id']
                        crossOptNum = this.crossColumnName.replace(/\[|\]/g,"")
                    }
                }
            }
            this.$refs.formRef.validate((valid)=>{
                if(!valid)return
                if(crossUserId&&crossRefId){
                    this.form.crossuserid = crossUserId
                    this.form.crossrefid = crossRefId
                    let params = {
                        page: 1,
                        limit: 1000,
                        crossuserid:this.form.crossuserid,
                        crossrefid:this.form.crossrefid,
                    }
                    http.get(`${this.tableName}/page`,{
                        params:params
                    }).then(res=>{
                        if(res.data.data.total>=crossOptNum){
                            return this.$message.error(this.crossTips)
                        }else{
                            http.post(`${this.tableName}/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
                                if(this.type == 'cross'){
                                    //修改跨表数据
                                    this.changeCrossData(objcross)
                                }
                                this.$message.success('操作成功')
                                this.formVisible = false
                                this.$emit('change')
                            })
                        }
                    })
                }else{
                    http.post(`${this.tableName}/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
                        if(this.type == 'cross'){
                            //修改跨表数据
                            this.changeCrossData(objcross)
                        }
                        this.$message.success('操作成功')
                        this.formVisible = false
                        this.$emit('change')
                    })
                }
            })
        },
        changeCrossData(data){
            http.post(this.crossTable+`/update`,data)
        }, 
    }
})
document.write(`<script src="http://${window.location.host}/cl806133279/static/client/components/FileUpload.js"></script>`)
document.write(`<script src="http://${window.location.host}/cl806133279/static/client/static/modules/wangeditor/index.min.js"></script>`)
document.write(`<script src="http://${window.location.host}/cl806133279/static/client/components/myEditor.js"></script>`)
document.write(`<link rel="stylesheet" href="http://${window.location.host}/cl806133279/static/client/static/modules/wangeditor/style.css"></link>`)
