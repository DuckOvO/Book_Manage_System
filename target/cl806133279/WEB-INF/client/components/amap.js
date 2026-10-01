// 全局初始化高德地图API
window.initAMapApiLoader = function(options) {
    // 注意：高德地图要求使用window._AMapSecurityConfig（带下划线）
    window._AMapSecurityConfig = {
        securityJsCode: options.securityJsCode
    };
    
    // 同时设置不带下划线的版本以兼容
    window.AMapSecurityConfig = {
        securityJsCode: options.securityJsCode
    };
    
    // 创建script标签加载API，明确指定需要加载的插件
    const script = document.createElement('script');
    script.type = 'text/javascript';
    // 添加plugin参数，加载所需的插件
    script.src = `https://webapi.amap.com/maps?v=${options.version || '1.4.28'}&key=${options.key}&securityJsCode=${options.securityJsCode}&plugin=AMap.Geocoder,AMap.Driving,AMap.Marker,AMap.PlaceSearch,AMap.Autocomplete&callback=${options.callback || 'onAMapLoaded'}`;
    document.body.appendChild(script);
};

// 初始化高德地图
window.initAMapApiLoader({
    key: 'c4ae6ed30bc3f01acf60971dd5d65e7b',
    securityJsCode: '4d49f68235e05c86c862eeb230ddfc05',
    version: '1.4.28',
    callback: 'onAMapLoaded'
});

// API加载完成后的回调函数
window.onAMapLoaded = function() {
    console.log('AMap API loaded successfully');
};

Vue.component('amap', {
    template: `
        <div class="mapComponents" style="width: 100%; height: 500px; display: flex;">
            <div id="mapContainer" style="flex: 1;"></div>
            <div id="panel" style="width: 300px; height: 100%; overflow-y: auto;"></div>
        </div>
    `,
    props: {
        mapRoute: {
            type: Object,
            default: null
        }
    },
    data() {
        return {
            map: null
        }
    },
    mounted() {
        // 等待DOM完全就绪后初始化
        setTimeout(() => {
            this.initAMap();
        }, 100);
    },
    updated() {
        // 当组件更新时，等待DOM更新完成后重新初始化地图
        setTimeout(() => {
            this.initAMap();
        }, 100);
    },
    methods: {
        initAMap() {
            console.log('AMap:', window.AMap);
            console.log('mapRoute:', this.mapRoute);
            
            if (!window.AMap) {
                console.log('AMap API is not loaded yet');
                // 等待API加载完成后重新初始化
                setTimeout(() => {
                    this.initAMap();
                }, 1000);
                return;
            }
            
            if (!this.mapRoute || !this.mapRoute.start || !this.mapRoute.end) {
                console.log('mapRoute data is not complete');
                return;
            }
            
            // 基本地图加载
            if (!this.map) {
                // 确保容器有正确的尺寸
                const container = document.getElementById('mapContainer');
                if (container && (container.offsetWidth === 0 || container.offsetHeight === 0)) {
                    console.log('Map container has no size, waiting...');
                    setTimeout(() => {
                        this.initAMap();
                    }, 200);
                    return;
                }
                
                this.map = new AMap.Map("mapContainer", {
                    resizeEnable: true,
                    zoom: 14, // 地图显示的缩放级别
                    center: this.mapRoute.start, // 地图中心点
                });
                
                // 添加窗口 resize 事件监听
                window.addEventListener('resize', () => {
                    if (this.map) {
                        this.map.resize();
                    }
                });
            } else {
                // 如果地图已经存在，更新中心点
                this.map.setCenter(this.mapRoute.start);
                // 清除地图上的所有覆盖物
                this.map.clearMap();
                // 确保地图尺寸正确
                this.map.resize();
            }
            
            // 使用AMap.plugin确保Driving插件加载完成
            AMap.plugin(['AMap.Driving'], () => {
                try {
                    const driving = new AMap.Driving({
                        map: this.map,
                        panel: 'panel',
                        extensions: 'all'
                    });
                    
                    // 处理途经点
                    let waypoints = [];
                    if (this.mapRoute.waypoints && Array.isArray(this.mapRoute.waypoints)) {
                        waypoints = this.mapRoute.waypoints.map(item => new AMap.LngLat(item[0], item[1]));
                        console.log('Waypoints:', waypoints);
                    }
                    
                    console.log('Searching route from:', new AMap.LngLat(this.mapRoute.start[0], this.mapRoute.start[1]), 'to:', new AMap.LngLat(this.mapRoute.end[0], this.mapRoute.end[1]), 'via:', waypoints);
                    
                    // 根据起终点经纬度规划驾车导航路线
                    driving.search(
                        new AMap.LngLat(this.mapRoute.start[0], this.mapRoute.start[1]), 
                        new AMap.LngLat(this.mapRoute.end[0], this.mapRoute.end[1]),
                        {
                            waypoints: waypoints
                        }, 
                        (status, result) => {
                            console.log('Driving search result:', status, result);
                            if (status === 'complete') {
                                console.log('绘制驾车路线完成');
                            } else {
                                console.log('获取驾车数据失败：' + result);
                                
                                // 如果Driving API失败，降级使用手动绘制
                                this.drawManualRoute();
                            }
                        }
                    );
                } catch (error) {
                    console.error('Driving API error:', error);
                    // 发生错误时降级使用手动绘制
                    this.drawManualRoute();
                }
            });
        },
        drawManualRoute() {
            console.log('降级使用手动绘制路线');
            
            // 创建所有点的数组：起点 -> 途经点 -> 终点
            const allPoints = [];
            
            // 添加起点
            allPoints.push(new AMap.LngLat(this.mapRoute.start[0], this.mapRoute.start[1]));
            
            // 添加途经点
            if (this.mapRoute.waypoints && Array.isArray(this.mapRoute.waypoints)) {
                this.mapRoute.waypoints.forEach(waypoint => {
                    allPoints.push(new AMap.LngLat(waypoint[0], waypoint[1]));
                });
            }
            
            // 添加终点
            allPoints.push(new AMap.LngLat(this.mapRoute.end[0], this.mapRoute.end[1]));
            
            // 使用折线绘制路线
            const polyline = new AMap.Polyline({
                path: allPoints,
                strokeColor: "#3366FF", // 线条颜色
                strokeWeight: 5, // 线条宽度
                strokeOpacity: 1 // 透明度
            });
            
            // 将折线添加到地图
            this.map.add(polyline);
            
            // 添加标记点
            // 起点标记
            this.map.add(new AMap.Marker({
                position: new AMap.LngLat(this.mapRoute.start[0], this.mapRoute.start[1]),
                title: '起点'
            }));
            
            // 途经点标记
            if (this.mapRoute.waypoints && Array.isArray(this.mapRoute.waypoints)) {
                this.mapRoute.waypoints.forEach((waypoint, index) => {
                    this.map.add(new AMap.Marker({
                        position: new AMap.LngLat(waypoint[0], waypoint[1]),
                        title: '途经点' + (index + 1)
                    }));
                });
            }
            
            // 终点标记
            this.map.add(new AMap.Marker({
                position: new AMap.LngLat(this.mapRoute.end[0], this.mapRoute.end[1]),
                title: '终点'
            }));
            
            // 调整地图视野，使所有点都在可视范围内
            this.map.setFitView();
        }
    }
});
