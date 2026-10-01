# 📚 基于 SSM 的图书管理系统

## 📖 项目简介

本项目是一个基于 **SSM（Spring + Spring MVC + MyBatis）** 架构开发的图书管理系统，实现了图书信息管理、用户管理、借阅管理等基本功能，适用于中小型图书管理场景。

---

## 🛠 技术栈

* 后端：Spring / Spring MVC / MyBatis
* 数据库：MySQL
* 前端：JSP / HTML / CSS / JavaScript（或 Vue，如你有用可改）
* 服务器：Tomcat
* 构建工具：Maven

---

## 📂 项目结构（简要）

```
Book_Manage_System
├── src
│   ├── main
│   │   ├── java        # 后端代码
│   │   ├── resources   # 配置文件（Spring、MyBatis等）
│   │   └── webapp      # 前端页面
├── pom.xml             # Maven依赖管理
```

---

## ⚙️ 运行环境要求

* JDK 8 或以上
* Maven 3.x
* MySQL 5.7 / 8.0
* Tomcat 9 / 10（推荐 9）

---

## 🚀 项目启动步骤（重点）

### 1️⃣ 克隆项目

```bash
git clone https://github.com/DuckOvO/Book_Manage_System.git
```

---

### 2️⃣ 配置数据库

1. 创建数据库（例如）：

```sql
CREATE DATABASE book_manage;
```

2. 导入项目中的 SQL 文件（如有）

3. 修改数据库连接配置（一般在）：

```
src/main/resources/jdbc.properties
```

修改为你的本地信息：

```properties
jdbc.url=jdbc:mysql://localhost:3306/book_manage?useUnicode=true&characterEncoding=utf8
jdbc.username=root
jdbc.password=你的密码
```

---

### 3️⃣ 使用 Maven 构建项目

在项目根目录执行：

```bash
mvn clean package
```

👉 成功后会生成 `.war` 文件

---

### 4️⃣ 部署到 Tomcat

#### 方法一（推荐）：

1. 将生成的 `.war` 文件复制到：

```
Tomcat/webapps/
```

2. 启动 Tomcat：

```bash
startup.bat   （Windows）
```

---

#### 方法二（IDEA 运行）：

1. 打开 IntelliJ IDEA
2. 配置 Tomcat Server
3. 添加 Artifact（war exploded）
4. 直接运行

---

### 5️⃣ 访问项目

浏览器打开：

```
http://localhost:8080/项目名
```

例如：

```
http://localhost:8080/Book_Manage_System
```

---

## 🔐 默认账号（如有）

> 可根据你的项目实际修改

* 管理员：admin / 123456

---

## 📌 常见问题

### ❓ 端口被占用

修改 Tomcat `conf/server.xml`：

```xml
<Connector port="8080" ... />
```

---

### ❓ 数据库连接失败

检查：

* MySQL 是否启动
* 用户名/密码是否正确
* 驱动版本是否匹配

---

### ❓ 页面404

可能原因：

* 项目未成功部署
* 访问路径错误
* Tomcat 未启动

---

## ✨ 项目亮点（可写进简历）

* 基于 SSM 三层架构设计，结构清晰
* 使用 MyBatis 实现数据持久化
* 支持图书的增删改查及借阅管理
* 具备完整的 Web 项目部署流程

---

## 📬 联系方式

如有问题欢迎交流学习 👍
