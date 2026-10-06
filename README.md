# 基于 SSM 的图书管理系统

一个面向图书馆日常业务的 Web 管理系统，采用 SSM 架构实现图书资源管理、读者服务和借阅业务，并提供个性化推荐、AI 在线咨询和逾期罚款支付等功能。

> 本 README 根据项目源码和毕业论文整理。部署前请按下方说明配置数据库及第三方服务。

## 功能概览

### 读者端

- 浏览、查询图书及相关资源
- 提交借阅、续借和归还相关操作
- 收藏资源并查看个性化推荐
- 查询借阅记录及逾期罚款
- 使用 AI 客服进行在线咨询，或联系人工客服
- 通过支付宝沙箱完成逾期罚款支付

### 管理端

- 管理读者、图书分类及图书资源
- 处理借阅、续借和归还业务
- 管理逾期罚款记录
- 管理公告、菜单及系统相关信息

### 项目特色

- **协同过滤推荐**：基于读者收藏数据生成个性化图书推荐。
- **AI 在线咨询**：接入百度千帆平台的 ERNIE-3.5-8K 模型，支持读者咨询。
- **沙箱支付**：集成支付宝沙箱，用于逾期罚款支付流程的开发与测试。

## 技术栈

| 类别 | 技术 |
| --- | --- |
| 后端 | Java 8、Spring、Spring MVC、MyBatis-Plus |
| 前端 | JSP、HTML、CSS、JavaScript |
| 数据库 | MySQL |
| 构建 | Maven |
| 部署 | Tomcat 9（项目使用 `javax.servlet`） |
| AI 服务 | 百度千帆 Qianfan SDK、ERNIE-3.5-8K |
| 支付 | 支付宝开放平台沙箱 |

## 目录结构

```text
.
├── pom.xml
├── sql/
│   └── cl806133279.sql          # 数据库初始化脚本
└── src/main/
    ├── java/com/cl/
    │   ├── controller/          # Web 控制器
    │   ├── service/             # 业务逻辑
    │   ├── dao/                 # 数据访问
    │   ├── entity/               # 实体及视图对象
    │   ├── config/               # 配置类
    │   └── utils/                # 工具类及推荐算法
    ├── resources/
    │   ├── config.properties     # 数据库连接配置
    │   ├── spring/               # Spring 配置
    │   └── mapper/               # MyBatis 映射文件
    └── webapp/                   # JSP 页面及静态资源
```

## 运行环境

- JDK 8
- Maven 3.x
- MySQL 8.x
- Tomcat 9

## 本地运行

### 1. 初始化数据库

项目数据库名为 `cl806133279`。执行仓库中的初始化脚本：

```bash
mysql -u root -p < sql/cl806133279.sql
```

### 2. 配置数据库连接

修改 `src/main/resources/config.properties` 中的连接信息：

```properties
jdbc_url=jdbc:mysql://127.0.0.1:3306/cl806133279?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
jdbc_username=你的MySQL用户名
jdbc_password=你的MySQL密码
```

### 3. 构建 WAR 包

在项目根目录执行：

```bash
mvn clean package
```

构建成功后，WAR 包位于 `target/cl806133279.war`。

### 4. 部署到 Tomcat

将 WAR 包复制到 Tomcat 的 `webapps` 目录并启动 Tomcat，然后访问：

```text
http://localhost:8080/cl806133279/
```

## 第三方服务配置

- **百度千帆 AI**：聊天调用及百度相关服务凭证目前在源码中配置。使用前请在百度智能云申请并配置自己的凭证。
- **支付宝**：项目使用支付宝沙箱网关。请在支付宝开放平台配置自己的沙箱应用信息后再测试支付。

**公开到 GitHub 前，请先检查并移除源码中的数据库密码、百度 API 凭证和支付宝私钥等敏感信息。** 如果这些凭证曾经提交到 Git 历史，仅删除当前文件并不足以撤销泄露；请先在对应平台轮换或吊销凭证，再清理仓库历史。

## 说明

- 项目没有在本文档中声明通用的默认管理员账号；请以本地数据库中的账号数据为准。
- 支付功能连接的是沙箱环境，不应用于真实收款。
- 实际运行效果取决于本机数据库、第三方服务凭证及 Tomcat 配置。
