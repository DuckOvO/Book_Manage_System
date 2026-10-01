Vue.component('shujixinxi-form', {
template:`
<template>
    <div>
        <el-dialog
                :visible.sync="formVisible"
                :title="formTitle"
                v-if="formVisible"
                custom-class="formModel"
                >
            <el-form class="formModel_form" ref="formRef" :model="form" :rules="rules" >
                <el-form-item  label="书籍名称" prop="shujimingcheng" class="input-item">
                    <el-input v-model="form.shujimingcheng"
                       placeholder="书籍名称"
                       type="text"
                       :readonly="!isAdd||disabledForm.shujimingcheng?true:false" ></el-input>
                </el-form-item>
                <el-form-item prop="fengmian"
                              label="封面"
                              v-if="formVisible" class="imgUpload-item">
                    <file-upload
                            :disabled="!isAdd||disabledForm.fengmian?true:false"
                            tip="点击上传封面"
                            :limit="3"
                            action="file/upload"
                            :multiple="true"
                            :file-urls="form.fengmian?form.fengmian:''"
                            @change="fengmianUploadSuccess"
                    ></file-upload>
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
                <el-form-item  label="ISBN" prop="bianma" class="input-item">
                    <el-input v-model="form.bianma"
                       placeholder="ISBN"
                       type="text"
                       :readonly="!isAdd||disabledForm.bianma?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="可借数量" prop="kejieshuliang" class="input-item">
                    <el-input v-model="form.kejieshuliang"
                       placeholder="可借数量"
                       type="text"
                       :readonly="!isAdd||disabledForm.kejieshuliang?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="出版年份" prop="chubannianfen" class="input-item">
                    <el-input v-model="form.chubannianfen"
                       placeholder="出版年份"
                       type="text"
                       :readonly="!isAdd||disabledForm.chubannianfen?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="作者" prop="zuozhe" class="input-item">
                    <el-input v-model="form.zuozhe"
                       placeholder="作者"
                       type="text"
                       :readonly="!isAdd||disabledForm.zuozhe?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="页数" prop="yeshu" class="input-item">
                    <el-input v-model="form.yeshu"
                       placeholder="页数"
                       type="text"
                       :readonly="!isAdd||disabledForm.yeshu?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="出版社" prop="chubanshe" class="input-item">
                    <el-input v-model="form.chubanshe"
                       placeholder="出版社"
                       type="text"
                       :readonly="!isAdd||disabledForm.chubanshe?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="简介" prop="jianjie" class="input-item">
                    <el-input v-model="form.jianjie"
                       placeholder="简介"
                       type="text"
                       :readonly="!isAdd||disabledForm.jianjie?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="包装" prop="baozhuang" class="input-item">
                    <el-input v-model="form.baozhuang"
                       placeholder="包装"
                       type="text"
                       :readonly="!isAdd||disabledForm.baozhuang?true:false" ></el-input>
                </el-form-item>
            </el-form>
            <div class="formModel-btns" v-if="isAdd||type=='reply'">
                <el-button class="formModel_cancel" @click="closeClick">取消</el-button>
                <el-button class="formModel_confirm" type="primary" @click="save"
                    >
                    提交
                </el-button>
            </div>
        </el-dialog>
    </div>
</template>
`,
data() {
    return {
        formVisible:false,
        formTitle:'',
        id:0,
        form:{},
        type:'',
        formName:'书籍信息',
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
                { validator: toolUtil.fromValidate.number, trigger: 'blur' },
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
                { validator: toolUtil.fromValidate.number, trigger: 'blur' },
            ],
            clicktime: [
            ],
        },
        isAdd:false,
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
        //书籍分类列表
        shujifenleiLists:[],
        crossRow:'',
        crossTips:'',
        crossColumnName:'',
        crossColumnValue:'',
        userInfo:{},
        sessionTable:localStorage.getItem('admin_sessionTable'),
    }
},
watch:{
},
methods: {
    init(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null){
        this.resetForm()
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
        }
        else if(formType == 'cross'){
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
        })
        http.get(`option/shujifenlei/shujifenlei`).then(res=>{
            this.shujifenleiLists = res.data.data
        })
    },
    getInfo(){
        http.get(`shujixinxi/info/${this.id}`).then(res=>{
            let reg=new RegExp('../../../upload','g')
            this.form = res.data.data
            this.formVisible = true
        })
    },
    //重置表单
    resetForm(){
        Object.assign(this.$data,this.$options.data())
        this.form = {
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
        }
    },


        //封面上传回调
    fengmianUploadSuccess(e){
        this.form.fengmian = e
    },











    //关闭
    closeClick(){
        this.formVisible = false
    },
    //提交
    async save(){
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
                http.get('shujixinxi/page',{
                    params:params
                }).then(res=>{
                    if(res.data.data.total>=crossOptNum){
                        return this.$message.error(this.crossTips)
                    }else{
                        http.post(`shujixinxi/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
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
                http.post(`shujixinxi/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
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
         http.post(`${this.crossTable}/update`,data)
    },
},
})
document.write(`<script src="${baseUrl}static/manage/components/FileUpload.js"></script>`)
