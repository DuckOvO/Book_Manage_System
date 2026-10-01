var projectName = `ssm+jsp的图书管理系统`

if(!window.menus){
    let menusJSON = localStorage.getItem("menus")
    if(!menusJSON){
        http.get("menu/list",{
            params:{
                page: 1,
                limit: 1,
                sort: 'id',
            }
        }).then(res=>{
            menusJSON = res.data.data.list[0].menujson
            localStorage.setItem("menus", res.data.data.list[0].menujson)
            window.menus = JSON.parse(menusJSON)
        })
    }else{
        window.menus = JSON.parse(menusJSON)
    }
}
var indexMenuList = [
    {
        name: '书籍信息管理',
        icon: '',
        child:[
            {
                name:'书籍信息',
                url:'client/shujixinxi/list'
            },

        ]
    },
    {
        name: '公告信息',
        icon: 'icon-common15',
        child:[
            {
                name:'公告通知',
                url:'client/news/list'
            },

        ]
    },
]

function navigateTo(menuItem){
    let url = ''
    if (menuItem.tableName == 'center'){
        return
    }
    else if(menuItem.tableName=='examrecord'&&menuItem.menuJump=='22'){
        url = `examfailrecord/list?centerType=1`
    }
    else if(menuItem.tableName=='exampaper'&&menuItem.menuJump=='12'){
        url =`exampaper/list?centerType=1`
    }
    else if(menuItem.tableName=='forum'&&menuItem.menuJump=='14'){
        url = `forum/list?centerType=1&&myType=1`
    }
    else if(menuItem.tableName=='storeup'){
        url = `/storeup/list?centerType=1&&myType=1&&type=${menuItem.type}`
    }
    else{
        switch (menuItem.menu){
            case '我的收藏':
                url = `storeup/list?centerType=1&&type=1`
                break;
            default:
                url = `${menuItem.classname||menuItem.tableName}/list?centerType=1`
        }
    }
    location.href =baseUrl +"client/" + url;
}
