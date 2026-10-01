Vue.component('shujixinxi-form',{
    template: `
    <div>
        <el-dialog :fullscreen="false" width="80%" 
                   :visible.sync="formVisible"
                   :title="formTitle"
                   v-if="formVisible"
                   custom-class="formModel">
            <el-form ref="formRef" :model="form" class="formModel_form" :rules="rules" label-width="120px" >
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
                <el-form-item label="可借数量" prop="kejieshuliang" class="input-item">
                    <el-input v-model="form.kejieshuliang" placeholder="可借数量"
                              type="text"
                        :readonly="!isAdd||disabledForm.kejieshuliang?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="出版年份" prop="chubannianfen" class="input-item">
                    <el-input v-model="form.chubannianfen" placeholder="出版年份"
                              type="text"
                        :readonly="!isAdd||disabledForm.chubannianfen?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="作者" prop="zuozhe" class="input-item">
                    <el-input v-model="form.zuozhe" placeholder="作者"
                              type="text"
                        :readonly="!isAdd||disabledForm.zuozhe?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="页数" prop="yeshu" class="input-item">
                    <el-input v-model="form.yeshu" placeholder="页数"
                              type="text"
                        :readonly="!isAdd||disabledForm.yeshu?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="出版社" prop="chubanshe" class="input-item">
                    <el-input v-model="form.chubanshe" placeholder="出版社"
                              type="text"
                        :readonly="!isAdd||disabledForm.chubanshe?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="简介" prop="jianjie" class="input-item">
                    <el-input v-model="form.jianjie" placeholder="简介"
                              type="text"
                        :readonly="!isAdd||disabledForm.jianjie?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="包装" prop="baozhuang" class="input-item">
                    <el-input v-model="form.baozhuang" placeholder="包装"
                              type="text"
                        :readonly="!isAdd||disabledForm.baozhuang?true:false" ></el-input>
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
            tableName:'shujixinxi',
            formName:'书籍信息',
            formVisible:false,
            formTitle:'',
            form:{
                shujimingcheng: '',
                fengmian: '',
                shujifenlei: '',
                bianma: '',
                kejieshuliang: '',
                chubannianfen: '',
                zuozhe: '',
                yeshu: '',
                chubanshe: '',
                jianjie: '',
                baozhuang: '',
                clicktime: '',
            },
            id:0,
            type:'',
            disabledForm:{
                shujimingcheng : false,
                fengmian : false,
                shujifenlei : false,
                bianma : false,
                kejieshuliang : false,
                chubannianfen : false,
                zuozhe : false,
                yeshu : false,
                chubanshe : false,
                jianjie : false,
                baozhuang : false,
                storeupNumber : false,
                clicktime : false,
            },
            isAdd:false,
            rules:{
                shujimingcheng: [
                ],
                fengmian: [
                ],
                shujifenlei: [
                ],
                bianma: [
                ],
                kejieshuliang: [
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
                chubannianfen: [
                ],
                zuozhe: [
                ],
                yeshu: [
                ],
                chubanshe: [
                ],
                jianjie: [
                ],
                baozhuang: [
                ],
                storeupNumber: [
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
                clicktime: [
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
                    if(x=='kejieshuliang'){
                        this.form.kejieshuliang = row[x];
                        this.disabledForm.kejieshuliang = true;
                        continue;
                    }
                    if(x=='chubannianfen'){
                        this.form.chubannianfen = row[x];
                        this.disabledForm.chubannianfen = true;
                        continue;
                    }
                    if(x=='zuozhe'){
                        this.form.zuozhe = row[x];
                        this.disabledForm.zuozhe = true;
                        continue;
                    }
                    if(x=='yeshu'){
                        this.form.yeshu = row[x];
                        this.disabledForm.yeshu = true;
                        continue;
                    }
                    if(x=='chubanshe'){
                        this.form.chubanshe = row[x];
                        this.disabledForm.chubanshe = true;
                        continue;
                    }
                    if(x=='jianjie'){
                        this.form.jianjie = row[x];
                        this.disabledForm.jianjie = true;
                        continue;
                    }
                    if(x=='baozhuang'){
                        this.form.baozhuang = row[x];
                        this.disabledForm.baozhuang = true;
                        continue;
                    }
                    if(x=='storeupNumber'){
                        this.form.storeupNumber = row[x];
                        this.disabledForm.storeupNumber = true;
                        continue;
                    }
                    if(x=='clicktime'){
                        this.form.clicktime = row[x];
                        this.disabledForm.clicktime = true;
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
                this.formVisible = true
            }
            http.get(this.sessionTable+'/session').then(res=>{
                var json = res.data.data
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
