<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>ssm+jsp的图书管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/modules/elementui/theme/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/manage/static/css/home.css">
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/modules/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/manage/static/iconfont/iconfont.js"></script>
</head>
<body>
<el-container id="page" v-cloak>
    <el-header height="auto">
        <page-header></page-header>
    </el-header>
    <el-container>
    <page-aside>
        <template v-slot:menu>
            <page-menus></page-menus>
        </template>
    </page-aside>
        <el-main>
            <div id="child-page">
                <div class="chart_list">
                    <div class="chart_item" v-if="btnAuth('shujixinxi','首页统计')">
                        <div id="shujixinxiEchart1" class="Echart"></div>
                    </div>
                    <div class="chart_item" v-if="btnAuth('tushujieyue','首页统计')">
                        <div id="tushujieyueEchart1" class="Echart"></div>
                    </div>
                    <div class="chart_item" v-if="btnAuth('tushujieyue','首页统计')">
                        <div id="tushujieyueEchart2" class="Echart"></div>
                    </div>
                </div>

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
            }
        },
        mounted(){
            this.getChartList()
        },
        methods: {
            getCountList(){
            },
            //权限验证
            btnAuth(e,a){
                return toolUtil.isAuth(e,a)
            },
            getChartList(){
                if(this.btnAuth('shujixinxi','首页统计')){
                    this.getshujixinxiChart1()
                }
                if(this.btnAuth('tushujieyue','首页统计')){
                    this.gettushujieyueChart1()
                }
                if(this.btnAuth('tushujieyue','首页统计')){
                    this.gettushujieyueChart2()
                }
            },
            getshujixinxiChart1(){
                this.\$nextTick(()=>{
                    var shujixinxiEchart1 = echarts.init(document.getElementById("shujixinxiEchart1"), null);
                    http.get(
                        "shujixinxi/group/shujifenlei"
                    ).then(res=>{
                        let obj = res.data.data
                        let xAxis = [];
                        let yAxis = [];
                        let dataList = []
                        for(let i=0;i<obj.length;i++){
                            xAxis.push(obj[i].shujifenlei);
                            yAxis.push(parseFloat((obj[i].total)));
                            dataList.push({
                                value: parseFloat((obj[i].total)),
                                name: obj[i].shujifenlei
                            })
                        }
                        let option = {};
                        option = {
    title:{
        text: '书籍类型分布',
        left: 'center'
    },
    legend: {
        orient: 'horizontal',
        type: 'scroll', // 启用滚动条
        left: 'center',
        padding:[40,0,0,0]
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: '55%',
            center: ['50%', '60%'],
            data: dataList.slice(0,12), 
            emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
}
                        // 使用刚指定的配置项和数据显示图表。
                        shujixinxiEchart1.setOption(option);
                        //根据窗口的大小变动图表
                        window.onresize = function() {
                            shujixinxiEchart1.resize();
                        };
                    })
                })
            },
            gettushujieyueChart1(){
                this.\$nextTick(()=>{
                    var tushujieyueEchart1 = echarts.init(document.getElementById("tushujieyueEchart1"), null);
                    http.get(
                        `tushujieyue/value/shujimingcheng/jieyueshuliang?order=desc`
                    ).then(res=>{
                        let obj = res.data.data
                        let xAxis = [];
                        let yAxis = [];
                        let dataList = []
                        for(let i=0;i<obj.length;i++){
                            xAxis.push(obj[i].shujimingcheng);
                            yAxis.push(parseFloat((obj[i].total)));
                            dataList.push({
                                value: parseFloat((obj[i].total)),
                                name: obj[i].shujimingcheng
                            })
                        }
                        let option = {};
                        // 使用刚指定的配置项和数据显示图表。
                        tushujieyueEchart1.setOption(option);
                        //根据窗口的大小变动图表
                        window.onresize = function() {
                            tushujieyueEchart1.resize();
                        };
                    })
                })
            },
            gettushujieyueChart2(){
                this.\$nextTick(()=>{
                    var tushujieyueEchart2 = echarts.init(document.getElementById("tushujieyueEchart2"), null);
                    http.get(
                        `tushujieyue/value/xingming/jieyueshuliang?order=desc`
                    ).then(res=>{
                        let obj = res.data.data
                        let xAxis = [];
                        let yAxis = [];
                        let dataList = []
                        for(let i=0;i<obj.length;i++){
                            xAxis.push(obj[i].xingming);
                            yAxis.push(parseFloat((obj[i].total)));
                            dataList.push({
                                value: parseFloat((obj[i].total)),
                                name: obj[i].xingming
                            })
                        }
                        let option = {};
                        option = {
    title: {
        show:false,
        text: '用户借阅量统计',
        left: 'center'
    },
    grid:{
        containLabel:true
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    dataZoom: [{
        type: 'inside'  // 允许缩放
    }],
    xAxis: {
        data: xAxis.slice(0,12), 
        type: 'category',
        axisLabel: {
        "interval": 0, //强制显示X轴所有名称
        "rotate": 30
        }
    },
    yAxis: {
        type: 'value',
        "minInterval": 1
    },
    series:{
        data: yAxis,
        type: 'bar',
        colorBy:'data',
        barMaxWidth: 40 // 只限制最大宽度
    }
}
                        // 使用刚指定的配置项和数据显示图表。
                        tushujieyueEchart2.setOption(option);
                        //根据窗口的大小变动图表
                        window.onresize = function() {
                            tushujieyueEchart2.resize();
                        };
                    })
                })
            },
        }
    })
</script>
</html>
