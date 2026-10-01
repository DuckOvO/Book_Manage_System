Vue.component('my-editor',{
    data(){
        return{
            _editor:null,
            aiEditor:null,
            uuid:undefined,
             _updating: false, // +++ 新增标志，防止循环更新
        }
    },
    props:{
        type: {
            type: String,
            default: ''     //type="AI",使用AI富文本编辑器
        },
        value: {
            type:String,
            default:'',
        },
        placeholder: {
            type:String,
            default: '请输入'
        },
        readonly: { //是否只读
            type:Boolean,
            default: false
        },
        editorMode: { //富文本是否简洁模式
            type:String,
            default:'default'   //'simple'
        },
        toolbarMode:{
            type:String,
            default:'default'
        },
    },
    created(){
        this.uuid = new Date().getMilliseconds()*parseInt(Math.random()*1000000)
    },
    mounted(){
        this.initEditor()
    },
    watch:{
        value(e){
            if(this.type=='AI'){
               if (this.aiEditor && !this._updating) { // +++ 仅当不是由自身onChange触发时才更新
                 let currentContent = this.aiEditor.getHtml() || '';
                    if (e !== currentContent) {
                        this.aiEditor.setContent(e);
                    }
            }
            }else{
                if(this._editor && e!=this._editor.getHtml()){
                    this._editor.setHtml(e)
                }
            }
        }
    },
    methods:{
        initEditor(){
            if(this.type=='AI'){
                this.initAiEditor()
            }else{
                this.initNormalEditor()
            }
        },
        initNormalEditor(){
            const { createEditor, createToolbar } = window.wangEditor
            const toolbarConfig = {
                excludeKeys: ['fullScreen', 'group-video', 'insertLink', 'insertImage']
            }
            const editorConfig = {
                placeholder: this.placeholder,
                readOnly: this.readonly,
                fontSize: ['12px', '14px', '16px'],
                MENU_CONF: {
                    uploadImage: {
                        server: window.baseUrl + 'file/upload',
                        fieldName: 'file',
                        // 单个文件的最大体积限制，默认为 2M
                        maximgSize: 10 * 1024 * 1024, // 10M
                        // 最多可上传几个文件，默认为 100
                        maxNumberOfimgs: 10,
                        // 选择文件时的类型限制，默认为 ['image/*'] 。如不想限制，则设置为 []
                        allowedimgTypes: ['image/*'],
                        // 自定义上传参数，例如传递验证的 token 等。参数会被添加到 formData 中，一起上传到服务端。
                        meta: {
                            // token: 'xxx',
                            // otherKey: 'yyy'
                            // img:''
                        },
                        // 将 meta 拼接到 url 参数中，默认 false
                        metaWithUrl: false,

                        // 自定义增加 http  header
                        headers: {
                            'Token': window.toolUtil.storageGet('Token')
                        },

                        // 跨域是否传递 cookie ，默认为 false
                        withCredentials: true,

                        // 超时时间，默认为 10 秒
                        timeout: 10 * 1000, //10 秒

                        // 上传前
                        onBeforeUpload(imgs) {
                            window.ELEMENT.Message.warning('图片正在上传中,请耐心等待')
                            return imgs;
                        },
                        // 自定义插入图片
                        customInsert(res, insertFn) {
                            // 因为自定义插入导致onSuccess与onFailed回调函数不起作用,自己手动处理

                            if (res.code === 0) {
                                window.ELEMENT.Message.success('图片上传成功')
                            } else {
                                window.ELEMENT.Message.error('图片上传失败，请重新尝试')
                            }
                            // 从 res 中找到 url alt href ，然后插入图片
                            insertFn(window.baseUrl + 'file/' + res.file);
                            // console.log(res, "res.data")
                        },

                        // 单个文件上传成功之后
                        onSuccess(img, res) {},

                        // 单个文件上传失败
                        onFailed(img, res) {},

                        // 上传进度的回调函数
                        onProgress(progress) {
                            // console.log('progress', progress);
                            // progress 是 0-100 的数字
                        },

                        // 上传错误，或者触发 timeout 超时
                        onError(img, err, res) {
                            // console.log(`${img.name} 上传出错`, err, res);
                        }
                    }
                },
                onChange:(editor)=>{
                    this.$emit('change', editor.getHtml())
                },
            }
            this._editor = createEditor({
                selector: `#editor${this.uuid}`,
                html: this.value,
                config: editorConfig,
                mode: this.editorMode, // or 'simple'
            })

            const toolbar = createToolbar({
                editor:this._editor,
                selector: `#toolbar${this.uuid}`,
                config: toolbarConfig,
                mode: this.toolbarMode, // or 'simple'
            })
        },
        initAiEditor(){
            this.aiEditor = new window.AiEditor({
                element: document.getElementById(`aiEditor${this.uuid}`),
                placeholder: this.placeholder,
                content: this.value,
                editable:!this.readonly,
               
                //支持讯飞星火spark、chatGPT、文心一言等，参考https://aieditor.com.cn/docs/zh/ai/llm.html
                ai: {
                    models: {
                        spark: {
                            appId: "b2c5ec71",
                            apiKey: "50bf24e4cb1e1b9d8c1f325c937f0171",
                            apiSecret: "ZTdjNGY3ZmVjZDIzZDRkOGM0NTc2ZGEw",
                            version: "v1.1",    //https://www.xfyun.cn/doc/spark/Web.html#_1-接口说明
                        }
                    }
                },
                onChange:(aiEditor)=>{
                    let content = aiEditor.getHtml()
                    if(content=='<p></p>'){
                        content=''
                    }
                    this.$emit('change', content)
                    // 在下一个 tick 重置标志，避免影响后续外部修改
                    this.$nextTick(() => {
                        this._updating = false;
                    });
                }
            })
        },
    },
    beforeDestroy(){
        if(this._editor){
            this._editor.destroy()
        }
        if(this.aiEditor){
            // AI编辑器的销毁方法，根据实际API可能需要调整
            if(this.aiEditor.destroy){
                this.aiEditor.destroy()
            }
        }
    },
    template:`
<template>
    <div class="editor—wrapper">
        <div v-if="type!='AI'">
            <div :id="'toolbar'+uuid" class="toolbar-container"><!-- 工具栏 --></div>
            <div :id="'editor'+uuid" class="editor-container"><!-- 编辑器 --></div>
        </div>
        <div v-else>
            <div class="aie-container editor-box">
                <div class="aie-container-header editorToolbar"></div>
                <div :id="'aiEditor'+uuid" class="aie-container-main editorContent" style="height: 310px;overflow: auto;"></div>
                <div class="aie-container-footer" style="display: none;"></div>
            </div>
        </div>
    </div>
</template>
    `
})