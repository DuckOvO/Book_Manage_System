Vue.component('syslog-form', {
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
                <el-form-item  label="用户名" prop="username" class="input-item">
                    <el-input v-model="form.username"
                       placeholder="用户名"
                       type="text"
                       :readonly="!isAdd||disabledForm.username?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="用户操作" prop="operation" class="input-item">
                    <el-input v-model="form.operation"
                       placeholder="用户操作"
                       type="text"
                       :readonly="!isAdd||disabledForm.operation?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="请求方法" prop="method" class="input-item">
                    <el-input v-model="form.method"
                       placeholder="请求方法"
                       type="text"
                       :readonly="!isAdd||disabledForm.method?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="请求时长(毫秒)" prop="time" class="input-item">
                    <el-input v-model="form.time"
                       placeholder="请求时长(毫秒)"
                       type="text"
                       :readonly="!isAdd||disabledForm.time?true:false" ></el-input>
                </el-form-item>
                <el-form-item  label="ip地址" prop="ip" class="input-item">
                    <el-input v-model="form.ip"
                       placeholder="ip地址"
                       type="text"
                       :readonly="!isAdd||disabledForm.ip?true:false" ></el-input>
                </el-form-item>
                <el-form-item label="请求参数" prop="params" class="textarea-item">
                    <el-input v-model="form.params" placeholder="请求参数"
                              type="textarea"
                              :readonly="!isAdd||disabledForm.params?true:false"
                    />
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
        formName:'操作日志',
        rules:{
            username: [
                {required: true,message: '请输入',trigger: 'blur'},

            ],
            operation: [
                {required: true,message: '请输入',trigger: 'blur'},

            ],
            method: [
            ],
            params: [
            ],
            time: [
            ],
            ip: [
            ],
        },
        isAdd:false,
        disabledForm:{
            username : false,
            operation : false,
            method : false,
            params : false,
            time : false,
            ip : false,
        },
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
                if(x=='username'){
                    this.form.username = row[x];
                    this.disabledForm.username = true;
                    continue;
                }
                if(x=='operation'){
                    this.form.operation = row[x];
                    this.disabledForm.operation = true;
                    continue;
                }
                if(x=='method'){
                    this.form.method = row[x];
                    this.disabledForm.method = true;
                    continue;
                }
                if(x=='params'){
                    this.form.params = row[x];
                    this.disabledForm.params = true;
                    continue;
                }
                if(x=='time'){
                    this.form.time = row[x];
                    this.disabledForm.time = true;
                    continue;
                }
                if(x=='ip'){
                    this.form.ip = row[x];
                    this.disabledForm.ip = true;
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
    },
    getInfo(){
        http.get(`syslog/info/${this.id}`).then(res=>{
            let reg=new RegExp('../../../upload','g')
            this.form = res.data.data
            this.formVisible = true
        })
    },
    //重置表单
    resetForm(){
        Object.assign(this.$data,this.$options.data())
        this.form = {
            username: '',
            operation: '',
            method: '',
            params: '',
            time: '',
            ip: '',
        }
    },






    //关闭
    closeClick(){
        this.formVisible = false
    },
    //提交
    async save(){
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
                http.get('syslog/page',{
                    params:params
                }).then(res=>{
                    if(res.data.data.total>=crossOptNum){
                        return this.$message.error(this.crossTips)
                    }else{
                        http.post(`syslog/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
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
                http.post(`syslog/${!this.form.id ? "save" : "update"}`,this.form).then(res=>{
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
