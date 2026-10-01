Vue.component('yonghu-form',{
    template: `
    <div>
        <el-dialog :fullscreen="false" width="80%" 
                   :visible.sync="formVisible"
                   :title="formTitle"
                   v-if="formVisible"
                   custom-class="formModel">
            <el-form ref="formRef" :model="form" class="formModel_form" :rules="rules" label-width="120px" >
                <el-form-item label="用户名" prop="yonghuming" class="input-item">
                    <el-input v-model="form.yonghuming" placeholder="用户名"
                              type="text" :readonly="!isAdd||disabledForm.yonghuming?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="mima" class="input-item">
                    <el-input v-model="form.mima" placeholder="密码"
                              type="password" :readonly="!isAdd||disabledForm.mima?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="xingming" class="input-item">
                    <el-input v-model="form.xingming" placeholder="姓名"
                              type="text"
                        :readonly="!isAdd||disabledForm.xingming?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="xingbie" class="select-item">
                    <el-select
                            :disabled="!isAdd||disabledForm.xingbie?true:false"
                            v-model="form.xingbie"
                            placeholder="请选择性别"
                    >
                    <el-option v-for="(item,index) in xingbieLists" :label="item"
                               :value="item"
                        >
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="头像" prop="touxiang" class="upload-item img-upload-item">
                    <file-upload
                            :disabled="!isAdd||disabledForm.touxiang?true:false"
                            action="file/upload"
                            tip="请上传头像"
                            :limit="3"
                            :fileUrls="form.touxiang?form.touxiang:''"
                            @change="touxiangUploadSuccess">
                    </file-upload>
                </el-form-item>
                <el-form-item label="年龄" prop="nianling" class="input-item">
                    <el-input v-model="form.nianling" placeholder="年龄"
                              type="text"
                        :readonly="!isAdd||disabledForm.nianling?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="邮箱" prop="youxiang" class="input-item">
                    <el-input v-model="form.youxiang" placeholder="邮箱"
                              type="text"
                        :readonly="!isAdd||disabledForm.youxiang?true:false" ></el-input>
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
            tableName:'yonghu',
            formName:'用户',
            formVisible:false,
            formTitle:'',
            form:{
                yonghuming: '',
                mima: '',
                xingming: '',
                xingbie: '',
                touxiang: '',
                nianling: '',
                youxiang: '',
            },
            id:0,
            type:'',
            disabledForm:{
                yonghuming : false,
                mima : false,
                xingming : false,
                xingbie : false,
                touxiang : false,
                nianling : false,
                youxiang : false,
                maxPasswordWrong : false,
                isLocked : false,
            },
            isAdd:false,
            rules:{
                yonghuming: [
                    {required: true,message: '请输入',trigger: 'blur'},
                ],
                mima: [
                    {required: true,message: '请输入',trigger: 'blur'},
                ],
                xingming: [
                    {required: true,message: '请输入',trigger: 'blur'},
                ],
                xingbie: [
                ],
                touxiang: [
                ],
                nianling: [
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
                youxiang: [
                    { validator: toolUtil.fromValidate.email, trigger: 'blur' },
                ],
                maxPasswordWrong: [
                    {required: true,message: '请输入',trigger: 'blur'},
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
                isLocked: [
                    {required: true,message: '请输入',trigger: 'blur'},
                    { validator: toolUtil.fromValidate.intNumber, trigger: 'blur' },
                ],
            },
            //性别列表
                xingbieLists:[],
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
        //头像上传回调
        touxiangUploadSuccess(e){
            this.form.touxiang = e
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
                    if(x=='yonghuming'){
                        this.form.yonghuming = row[x];
                        this.disabledForm.yonghuming = true;
                        continue;
                    }
                    if(x=='mima'){
                        this.form.mima = row[x];
                        this.disabledForm.mima = true;
                        continue;
                    }
                    if(x=='xingming'){
                        this.form.xingming = row[x];
                        this.disabledForm.xingming = true;
                        continue;
                    }
                    if(x=='xingbie'){
                        this.form.xingbie = row[x];
                        this.disabledForm.xingbie = true;
                        continue;
                    }
                    if(x=='touxiang'){
                        this.form.touxiang = row[x];
                        this.disabledForm.touxiang = true;
                        continue;
                    }
                    if(x=='nianling'){
                        this.form.nianling = row[x];
                        this.disabledForm.nianling = true;
                        continue;
                    }
                    if(x=='youxiang'){
                        this.form.youxiang = row[x];
                        this.disabledForm.youxiang = true;
                        continue;
                    }
                    if(x=='maxPasswordWrong'){
                        this.form.maxPasswordWrong = row[x];
                        this.disabledForm.maxPasswordWrong = true;
                        continue;
                    }
                    if(x=='isLocked'){
                        this.form.isLocked = row[x];
                        this.disabledForm.isLocked = true;
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
            this.xingbieLists = "男,女".split(',')
        },
        //关闭
        closeClick(){
            this.formVisible = false
        },
        //提交
        save(){
            if(this.form.touxiang!=null) {
                this.form.touxiang = this.form.touxiang.replace(new RegExp(baseUrl,"g"),"");
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
