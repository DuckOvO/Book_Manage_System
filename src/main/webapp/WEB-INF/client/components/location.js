Vue.component('location-form',{
    template:`
<el-dialog :visible.sync="locationVisible" :title="'选择地点'" width="70%" destroy-on-close>
    <!-- 搜索框区域 -->
    <div style="width: 100%; margin-bottom: 15px; padding: 10px; background: #f5f5f5; border-radius: 4px;">
        <div style="width: 100%; position: relative;">
            <input 
                type="text"
                v-model="searchKeyword" 
                placeholder="请输入地址搜索"
                style="width: 100%; padding: 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 14px; box-sizing: border-box;"
                @input="handleSearch"
                @keyup.enter="handleSearch"
            />
            <button 
                style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: #409EFF; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 12px;"
                @click="handleSearch"
            >
                搜索
            </button>
        </div>
        <!-- 搜索结果 -->
        <div v-if="searchResults.length > 0" style="position: absolute; top: 100%; left: 10px; right: 10px; background: white; border: 1px solid #d9d9d9; border-radius: 4px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15); z-index: 1100; max-height: 200px; overflow-y: auto; margin-top: 2px;">
            <div 
                v-for="(result, index) in searchResults" 
                :key="index"
                style="padding: 10px 15px; cursor: pointer; border-bottom: 1px solid #f0f0f0;"
                @click="selectSearchResult(result)"
            >
                <div style="font-weight: 500; margin-bottom: 4px;">{{ result.name }}</div>
                <div style="font-size: 12px; color: #999;">{{ result.address || '无详细地址' }}</div>
            </div>
        </div>
    </div>
    <div id="aMap" style="width: 100%;height:50vh"></div>
    <div class="aMapAddress">
        <p>
            <span>坐标：</span>
            <span>{{ markerPosition.lng }}</span>，
            <span>{{ markerPosition.lat }}</span>
        </p>
        <p>
            <span>地址：</span>
            <span>{{ markerPosition.address }}</span>
        </p>
    </div>
    <div class="flex-justify-center">
        <el-button type="primary" @click="choosePosition">确定位置</el-button>
    </div>
</el-dialog>
    `,
    data(){
        return{
            locationVisible:false,
            zoom:16,
            markerPosition: {
                lng:this.position.lng || 113.887902,
                lat:this.position.lat || 22.554732,
                address:''
            },
            searchKeyword: '',
            searchResults: [],
            placeSearch: undefined,
            toParentsMapInfo:{},
            map:undefined,  //地图对象
            marker:undefined,   //标记点对象
            geocoder:undefined, //地理编码对象
        }
    },
    props:{
        position:{  // 父组件传来的默认数据
            type: Object,
            default: {}
        },
        isShowAMap:{    // 控制是否展示搜索框
            type: Boolean,
            default: true
        },
        isDisplayAMap:{ // 控制是否展示地图试图
            type: Boolean,
            default: true
        }
    },
    mounted(){
        window._AMapSecurityConfig = {
            securityJsCode:'4d49f68235e05c86c862eeb230ddfc05'
        }
    },
    methods:{
        choosePosition(){
            console.log(this.markerPosition)
            this.$emit('choose',this.markerPosition)
            this.locationVisible = false;
        },
        initMap(){
            toolUtil.loadScript("https://webapi.amap.com/maps?v=1.4.4&key=c4ae6ed30bc3f01acf60971dd5d65e7b",()=>{
                this.$nextTick(()=>{
                    this.map = new AMap.Map('aMap', {
                        center:[this.markerPosition.lng,this.markerPosition.lat],
                        zoom:this.zoom
                    });
                    this.marker = new AMap.Marker({
                        position: [this.markerPosition.lng,this.markerPosition.lat],   // 经纬度对象，也可以是经纬度构成的一维数组[116.39, 39.9]
                    });
                    AMap.plugin(['AMap.Geocoder', 'AMap.PlaceSearch'],()=>{
                        this.geocoder = new AMap.Geocoder()
                        this.getAddress([this.markerPosition.lng,this.markerPosition.lat])
                        
                        // 初始化PlaceSearch
                        this.placeSearch = new AMap.PlaceSearch({
                            pageSize: 10,
                            pageIndex: 1,
                            extensions: 'base',
                            map: this.map
                        })
                    })
                    this.map.on('click',(e)=>{
                        this.marker.setPosition(e.lnglat)
                        this.getAddress([e.lnglat.lng,e.lnglat.lat])
                    })
                    this.map.add(this.marker);
                })
            })
        },
        getAddress(lnglat){
            this.geocoder.getAddress(lnglat, (status, result)=>{
                if (status === 'complete'&&result.regeocode) {
                    this.markerPosition = {
                        lng:lnglat[0],
                        lat:lnglat[1],
                        address:result.regeocode.formattedAddress
                    }
                }else{
                    log.error('根据经纬度查询地址失败')
                }
            });
        },
        mapShow(){
            this.locationVisible = true
            this.initMap()
        },
        handleSearch() {
            if (!this.searchKeyword || this.searchKeyword.trim() === '') {
                this.searchResults = [];
                return;
            }
            
            // 加载PlaceSearch插件
            if (!this.placeSearch) {
                AMap.plugin('AMap.PlaceSearch', () => {
                    this.placeSearch = new AMap.PlaceSearch({
                        pageSize: 10,
                        pageIndex: 1,
                        extensions: 'base',
                        map: this.map
                    });
                    this.doSearch();
                });
            } else {
                this.doSearch();
            }
        },
        doSearch() {
            this.placeSearch.search(this.searchKeyword, (status, result) => {
                if (status === 'complete' && result.info === 'OK') {
                    this.searchResults = result.pois.map(item => ({
                        name: item.name,
                        address: item.address,
                        location: item.location
                    }));
                } else {
                    this.searchResults = [];
                }
            });
        },
        selectSearchResult(result) {
            if (result && result.location) {
                const lng = result.location.getLng();
                const lat = result.location.getLat();
                
                // 更新标记位置
                this.marker.setPosition([lng, lat]);
                
                // 更新地图中心点
                this.map.setCenter([lng, lat]);
                
                // 获取详细地址
                this.getAddress([lng, lat]);
                
                // 清空搜索结果
                this.searchResults = [];
            }
        }
    },
})