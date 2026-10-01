-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: cl806133279
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cl806133279`
--

/*!40000 DROP DATABASE IF EXISTS `cl806133279`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cl806133279` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `cl806133279`;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `adminid` bigint(20) DEFAULT NULL COMMENT '管理员id',
  `ask` longtext COLLATE utf8mb4_unicode_ci COMMENT '提问内容',
  `reply` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `isreply` int(11) DEFAULT NULL COMMENT '是否回复',
  `admin_table_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '管理表',
  `user_table_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户表',
  `is_read` int(11) DEFAULT '0' COMMENT '已读1/未读0',
  `user_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `user_image` longtext COLLATE utf8mb4_unicode_ci COMMENT '用户头像',
  `type` int(11) DEFAULT '1' COMMENT '内容(1:文本,2:图片,3:视频,4:文件,5:表情)',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客服聊天';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (1,'2026-04-08 08:29:32',1,'提问内容1','回复内容1',1,'管理表1','用户表1',1,'用户名1','file/chatUser_image1.jpg,file/chatUser_image2.jpg,file/chatUser_image3.jpg',1,1),(2,'2026-04-08 08:29:32',2,'提问内容2','回复内容2',2,'管理表2','用户表2',2,'用户名2','file/chatUser_image2.jpg,file/chatUser_image3.jpg,file/chatUser_image4.jpg',2,2),(3,'2026-04-08 08:29:32',3,'提问内容3','回复内容3',3,'管理表3','用户表3',3,'用户名3','file/chatUser_image3.jpg,file/chatUser_image4.jpg,file/chatUser_image5.jpg',3,3),(4,'2026-04-08 08:29:32',4,'提问内容4','回复内容4',4,'管理表4','用户表4',4,'用户名4','file/chatUser_image4.jpg,file/chatUser_image5.jpg,file/chatUser_image6.jpg',4,4),(5,'2026-04-08 08:29:32',5,'提问内容5','回复内容5',5,'管理表5','用户表5',5,'用户名5','file/chatUser_image5.jpg,file/chatUser_image6.jpg,file/chatUser_image7.jpg',5,5),(6,'2026-04-08 08:29:32',6,'提问内容6','回复内容6',6,'管理表6','用户表6',6,'用户名6','file/chatUser_image6.jpg,file/chatUser_image7.jpg,file/chatUser_image8.jpg',6,6),(7,'2026-04-08 08:29:32',7,'提问内容7','回复内容7',7,'管理表7','用户表7',7,'用户名7','file/chatUser_image7.jpg,file/chatUser_image8.jpg,file/chatUser_image9.jpg',7,7),(8,'2026-04-08 08:29:32',8,'提问内容8','回复内容8',8,'管理表8','用户表8',8,'用户名8','file/chatUser_image8.jpg,file/chatUser_image9.jpg,file/chatUser_image10.jpg',8,8),(9,'2026-04-08 08:29:32',9,'提问内容9','回复内容9',9,'管理表9','用户表9',9,'用户名9','file/chatUser_image9.jpg,file/chatUser_image10.jpg,file/chatUser_image11.jpg',9,9),(10,'2026-04-08 08:29:32',10,'提问内容10','回复内容10',10,'管理表10','用户表10',10,'用户名10','file/chatUser_image10.jpg,file/chatUser_image11.jpg,file/chatUser_image12.jpg',10,10),(11,'2026-04-08 09:08:23',NULL,'你好，你是',NULL,0,NULL,NULL,1,NULL,NULL,1,60),(12,'2026-04-08 09:08:27',60,NULL,'你好，我是文心一言，英文名是ERNIE Bot。我是百度研发的知识增强大语言模型，能够提供知识问答、文本创作、知识推理等服务。请问有什么可以帮您的吗？',0,NULL,NULL,0,NULL,NULL,1,60),(13,'2026-04-08 09:08:35',60,NULL,'正在呼叫客服，请先描述您的问题',0,NULL,NULL,0,NULL,NULL,1,60),(14,'2026-04-08 09:08:37',NULL,'123123',NULL,0,NULL,NULL,1,NULL,NULL,1,60),(15,'2026-04-08 09:08:47',1,NULL,'111',NULL,NULL,NULL,0,NULL,NULL,1,60);
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chathelper`
--

DROP TABLE IF EXISTS `chathelper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chathelper` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ask` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提问内容',
  `reply` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='聊天助手';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chathelper`
--

LOCK TABLES `chathelper` WRITE;
/*!40000 ALTER TABLE `chathelper` DISABLE KEYS */;
INSERT INTO `chathelper` VALUES (1,'2026-04-08 08:29:32','提问内容1','回复内容1'),(2,'2026-04-08 08:29:32','提问内容2','回复内容2'),(3,'2026-04-08 08:29:32','提问内容3','回复内容3'),(4,'2026-04-08 08:29:32','提问内容4','回复内容4'),(5,'2026-04-08 08:29:32','提问内容5','回复内容5'),(6,'2026-04-08 08:29:32','提问内容6','回复内容6'),(7,'2026-04-08 08:29:32','提问内容7','回复内容7'),(8,'2026-04-08 08:29:32','提问内容8','回复内容8'),(9,'2026-04-08 08:29:32','提问内容9','回复内容9'),(10,'2026-04-08 08:29:32','提问内容10','回复内容10');
/*!40000 ALTER TABLE `chathelper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `url` longtext COLLATE utf8mb4_unicode_ci COMMENT '链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'2026-04-08 08:29:32','swiper1','file/swiperPicture1.jpg',NULL),(2,'2026-04-08 08:29:32','swiper2','file/swiperPicture2.jpg',NULL),(3,'2026-04-08 08:29:32','swiper3','file/swiperPicture3.jpg',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `menujson` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'2026-04-08 08:29:32','[{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\"],\"classname\":\"storeup\",\"menu\":\"我的收藏\",\"menuJump\":\"1\",\"tableName\":\"storeup\"}],\"fontClass\":\"icon-common45\",\"menu\":\"我的收藏管理\",\"unicode\":\"&#xef3b;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"热门图书统计\",\"用户借阅量统计\",\"首页统计\",\"归还\",\"续借\"],\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"查看\",\"归还\",\"续借\"],\"classname\":\"tushujieyue\",\"menu\":\"图书借阅\",\"menuJump\":\"列表\",\"tableName\":\"tushujieyue\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"逾期罚款\"],\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"查看\"],\"classname\":\"tushuguihai\",\"menu\":\"图书归还\",\"menuJump\":\"列表\",\"tableName\":\"tushuguihai\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"支付\"],\"appFrontIcon\":\"cuIcon-explore\",\"buttons\":[\"查看\",\"支付\"],\"classname\":\"yuqifakuan\",\"menu\":\"逾期罚款\",\"menuJump\":\"列表\",\"tableName\":\"yuqifakuan\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"查看\"],\"classname\":\"tushuxujie\",\"menu\":\"图书续借\",\"menuJump\":\"列表\",\"tableName\":\"tushuxujie\"}],\"fontClass\":\"icon-common23\",\"menu\":\"图书借阅管理\",\"unicode\":\"&#xee05;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-pic\",\"buttons\":[\"查看\",\"图书借阅\"],\"classname\":\"shujixinxi\",\"menu\":\"书籍信息\",\"menuJump\":\"列表\",\"tableName\":\"shujixinxi\"}],\"menu\":\"书籍信息管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-full\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"公告通知\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"公告信息\",\"unicode\":\"&#xedfc;\"}],\"hasBackLogin\":\"否\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"是\",\"hasFrontRegister\":\"是\",\"pathName\":\"yonghu\",\"roleName\":\"用户\",\"tableName\":\"yonghu\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-vipcard\",\"buttons\":[\"查看\"],\"classname\":\"chat\",\"menu\":\"客服聊天\",\"menuJump\":\"列表\",\"tableName\":\"chat\"}],\"fontClass\":\"icon-common36\",\"menu\":\"客服聊天管理\",\"unicode\":\"&#xee9f;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-taxi\",\"buttons\":[\"查看\",\"删除\"],\"classname\":\"syslog\",\"menu\":\"操作日志\",\"menuJump\":\"列表\",\"tableName\":\"syslog\"}],\"fontClass\":\"icon-common30\",\"menu\":\"操作日志管理\",\"unicode\":\"&#xee30;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\",\"修改\"],\"classname\":\"config\",\"menu\":\"轮播图\",\"menuJump\":\"列表\",\"tableName\":\"config\"}],\"fontClass\":\"icon-common13\",\"menu\":\"轮播图管理\",\"unicode\":\"&#xedf7;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"yonghu\",\"menu\":\"用户\",\"menuJump\":\"列表\",\"tableName\":\"yonghu\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"users\",\"menu\":\"管理员\",\"menuJump\":\"列表\",\"tableName\":\"users\"}],\"fontClass\":\"icon-user1\",\"menu\":\"用户管理\",\"unicode\":\"&#xef97;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"热门图书统计\",\"用户借阅量统计\",\"首页统计\",\"归还\",\"续借\"],\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"热门图书统计\",\"用户借阅量统计\",\"首页统计\"],\"classname\":\"tushujieyue\",\"menu\":\"图书借阅\",\"menuJump\":\"列表\",\"tableName\":\"tushujieyue\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"逾期罚款\"],\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"逾期罚款\"],\"classname\":\"tushuguihai\",\"menu\":\"图书归还\",\"menuJump\":\"列表\",\"tableName\":\"tushuguihai\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"支付\"],\"appFrontIcon\":\"cuIcon-explore\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"yuqifakuan\",\"menu\":\"逾期罚款\",\"menuJump\":\"列表\",\"tableName\":\"yuqifakuan\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"首页统计\"],\"classname\":\"tushuxujie\",\"menu\":\"图书续借\",\"menuJump\":\"列表\",\"tableName\":\"tushuxujie\"}],\"fontClass\":\"icon-common23\",\"menu\":\"图书借阅管理\",\"unicode\":\"&#xee05;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"书籍类型分布\",\"首页统计\",\"图书借阅\"],\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"首页统计\",\"书籍类型分布\"],\"classname\":\"shujixinxi\",\"menu\":\"书籍信息\",\"menuJump\":\"列表\",\"tableName\":\"shujixinxi\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"shujifenlei\",\"menu\":\"书籍分类\",\"menuJump\":\"列表\",\"tableName\":\"shujifenlei\"}],\"fontClass\":\"icon-common2\",\"menu\":\"书籍信息管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-clothes\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"news\",\"menu\":\"公告通知\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"fontClass\":\"icon-common20\",\"menu\":\"网页功能管理\",\"unicode\":\"&#xee02;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-pic\",\"buttons\":[\"查看\",\"图书借阅\"],\"classname\":\"shujixinxi\",\"menu\":\"书籍信息\",\"menuJump\":\"列表\",\"tableName\":\"shujixinxi\"}],\"menu\":\"书籍信息管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-full\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"公告通知\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"公告信息\",\"unicode\":\"&#xedfc;\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"users\",\"roleName\":\"管理员\",\"tableName\":\"users\"}]');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `introduction` longtext COLLATE utf8mb4_unicode_ci COMMENT '简介',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告通知';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'2026-04-08 08:29:31','小草与大树','小草羡慕大树高大，后知自身价值','file/newsPicture1.jpg','田埂边的小草总仰头望身旁的老槐树，看它枝繁叶茂能触碰飘过的云朵，听着路过的人夸赞大树的挺拔，整日唉声叹气自己矮小丑陋。某天午后，暴雨裹挟着狂风突然席卷而来，豆大的雨点砸得叶片生疼，大树被吹断了两根粗壮的枝桠，歪歪斜斜地站着。而小草顺着风势轻轻弯腰，把根紧紧扎在泥土里，雨后依旧精神地挺立着。它终于明白，每种生命都有独特的生存力量，不必羡慕他人。'),(2,'2026-04-08 08:29:31','迷路的蝴蝶','蝴蝶迷路慌乱，借星光找到方向','file/newsPicture2.jpg','彩色的凤蝶追着野蔷薇的花香，不知不觉飞出了熟悉的山谷，等夕阳落下夜幕降临时，四周只剩下陌生的草丛和虫鸣，它彻底迷了路。它在花丛中慌乱地撞来撞去，翅膀沾了不少露水，连扇动都变得沉重。就在它快要绝望时，抬头看见夜空中闪烁的星光，像撒在黑布上的碎钻。它深吸一口气稳住心神，顺着最亮的那几颗星慢慢飞行，飞过湿漉漉的草地，越过矮矮的土坡，终于在黎明前飞回了自己温暖的巢穴。'),(3,'2026-04-08 08:29:31','破茧的蚕','蚕怕破茧痛苦，却因坚持获新生','file/newsPicture3.jpg','雪白的蚕宝宝吐丝结茧，把自己裹在厚厚的茧中后，才发现想要出来远比想象中艰难。每一次用力挣动，茧壳都像细密的网勒着身体，伴着撕裂般的疼，它好几次瘫在茧里想放弃，觉得就这样待着也挺好。可它想起妈妈曾说过，不挣脱茧就会困死在里面，永远见不到外面的世界。于是它咬着牙，用脑袋一点点顶开茧壳的缝隙，累了就歇片刻补充力气，再继续向外钻。当它终于钻出茧时，身体已经长出了轻盈的翅膀，变成了飞蛾，扑扇着翅膀飞向了洒满阳光的天空。'),(4,'2026-04-08 08:29:31','口渴的乌鸦','乌鸦遇瓶中水少，用石子喝到水','file/newsPicture4.jpg','夏日的烈日像个大火球，炙烤得大地发烫，路边的野草都蔫头耷脑。乌鸦扇动着疲惫的翅膀，飞了大半天也没找到水源，喉咙干得像要冒烟，连叫出声都觉得费力。就在它快要放弃，准备找片树荫歇脚时，忽然瞥见路边的石头旁，放着一只透明的玻璃瓶，瓶底沉着浅浅一层水。它急忙扑扇翅膀飞过去，爪子刚落在瓶沿，就迫不及待地伸脖子啄水，可水位太低，尖喙每次都只能碰到光滑的瓶壁。它围着瓶子转了一圈又一圈，黑亮的眼睛盯着瓶底的水不停打转，爪子还时不时扒拉一下瓶身。这时，它注意到不远处的小土坡上，散落着许多圆润的小石子，灵光突然一闪。它立刻飞向土坡，用嘴小心地衔起一颗小石子，翅膀微微抖动着飞回瓶子旁，轻轻把石子放进瓶中，生怕用力过猛碰倒瓶子。一颗、两颗、三颗…… 石子在瓶底慢慢堆积，水位也随着石子的增多，一点点向上爬升。乌鸦耐心地往返于土坡和瓶子之间，累了就停在瓶沿歇几秒，看着水位慢慢靠近瓶口，眼里满是期待。终于，当又一颗石子落下时，水位刚好漫到瓶口，乌鸦赶紧低下头，清凉甘甜的水流进喉咙，瞬间驱散了所有的干渴与疲惫。'),(5,'2026-04-08 08:29:31','慢爬的蜗牛','蜗牛虽慢，坚持爬完了山顶路','file/newsPicture5.jpg','清晨的露珠还挂在草叶上，小蜗牛背着重重的壳，趴在山脚下的青石板上，努力昂起小小的脑袋，望着远处高高的山顶。山顶的松树在风里轻轻摇晃，松针泛着翠绿的光，像在向它招手。“我一定要爬上去，看看山顶的风景！” 它在心里暗暗下定决心。这时，一群麻雀扑棱着翅膀飞过来，落在它旁边的树枝上，叽叽喳喳地围着它笑：“小蜗牛，你爬得比乌龟还慢呢！等你爬到山顶，树上的叶子都该落光啦！” 说完，还故意扑扇翅膀，带起的风把蜗牛吹得晃了晃。小蜗牛没有生气，也没有辩解，只是慢慢把头缩进壳里歇了会儿，又重新探出头，继续向上爬。它的腹足贴着粗糙的树皮，一步一步稳稳地挪动，每爬一段路，就会留下一道浅浅的黏液痕迹。遇到陡峭的地方，它就紧紧贴着树皮，慢慢调整姿势，生怕一不小心摔下去；下雨天，它就立刻躲进壳里，等雨停了再继续出发；饿了，就啃几口路边鲜嫩的青苔，补充完力气又接着爬。日子一天天过去，它爬过了开满野花的山坡，躲过了觅食的小松鼠，甚至还在中途遇到过之前嘲笑它的麻雀 —— 那时麻雀们早已忘了当初的事，只是惊讶地看着它向上爬。终于，在一个清晨，当第一缕阳光洒在山顶时，小蜗牛的腹足终于触碰到了山顶的岩石。它慢慢爬上最高的石头，张开小小的触角，望向远方：弯弯的河流像一条银色的带子，金黄的田野里满是丰收的景象，风里还带着山下野花的清香。所有的辛苦和等待，在这一刻都变得无比值得。'),(6,'2026-04-08 08:29:31','受伤的小鸟','小鸟受伤难飞，被善待后重归蓝天','file/newsPicture6.jpg','刚学会飞没多久的小麻雀，对天空充满了好奇。这天，它想试着飞得更高，看看云层下面的世界，于是用力扇动翅膀，一点点向上攀升。可就在它快要靠近树枝时，不小心没控制好方向，“嘭” 的一声撞在了粗壮的树枝上。翅膀立刻传来一阵钻心的疼，几根羽毛也掉了下来，还渗出了细细的血丝。它疼得叽叽直叫，努力想再次扇动翅膀，可受伤的翅膀根本用不上力，只能扑腾着落在绿油油的草地上。看着同伴们在天上自由地飞翔、嬉戏，小麻雀急得眼泪都快出来了，却只能无助地在草地上蹦跶。放学铃声响起，穿着蓝色校服的小男孩背着书包路过，发现了角落里的小麻雀。他轻轻蹲下来，眼睛里满是心疼，慢慢伸出手心，小心翼翼地靠近小麻雀，生怕吓到它。小麻雀起初有些害怕，往后缩了缩，但看到男孩温柔的眼神，便慢慢放松下来，跳进了他的手心。男孩把小麻雀带回家，找了个干净的纸盒，铺上柔软的纸巾当窝，还特意找来一个小碟子，倒上泡软的小米和清水。每天放学回家，他都会先去看看小麻雀，用棉签蘸着温和的药水，轻轻涂抹在它的伤口上，动作轻柔得像在呵护一件珍宝。小麻雀在男孩的照顾下，伤口渐渐愈合，也慢慢信任了这个温柔的人类，有时还会轻轻啄他的手指。过了一周，当男孩再次给小麻雀检查伤口时，发现它的翅膀已经完全好了。于是，男孩捧着小麻雀来到户外的草地上，这里开满了五颜六色的小花，蓝天格外清澈。他慢慢松开手，小麻雀在他手心停留了片刻，像是在表达感谢，然后欢快地扑扇翅膀，一圈又一圈地在男孩头顶盘旋，最后朝着蔚蓝的蓝天飞去，很快变成了一个小小的黑点。'),(7,'2026-04-08 08:29:31','空的麦穗','空麦穗昂首，饱满麦穗低头','file/newsPicture7.jpg','秋日的阳光温柔地洒在田野上，整片稻田都变成了金黄色，沉甸甸的麦穗压弯了麦秆，风一吹，就发出 “沙沙” 的声响，像在演奏丰收的乐曲。田埂边的稻草人戴着草帽，静静地站在那里，守护着这片稻田。仔细看去，稻田里的麦穗有着明显的不同：那些颗粒空瘪的麦穗，麦秆长得又细又高，却没什么重量，直直地昂着头，在风里摇来摇去，仿佛在向路过的蝴蝶、蜜蜂炫耀自己的 “高大”，还时不时碰一碰旁边的麦穗，一副得意洋洋的样子。而那些颗粒饱满的麦穗，每一粒麦子都长得圆润饱满，沉甸甸的重量把麦秆压得弯弯的，麦穗都沉沉地低着头，像是在思考，又像是在向孕育它们的土地致敬，把饱满的果实悄悄藏在绿色的叶鞘间，不声不响地等待着农民伯伯来收割。路过的老农看到这一幕，笑着对身边的孩子说：“你看，空瘪的麦穗才会仰头张扬，真正饱满的麦穗，都懂得低头谦虚啊。” 孩子似懂非懂地点点头，看着那些低头的麦穗，好像明白了什么 —— 就像人一样，越有实力、越有内涵的人，越不会轻易炫耀，反而会保持谦虚的姿态，默默沉淀自己。'),(8,'2026-04-08 08:29:31','找阳光的花儿','花儿在阴影里，努力生长见阳光','file/newsPicture8.jpg','春天播种时，一颗小小的牵牛花种子，不小心被风吹到了墙角的缝隙里。这里常年被高大的墙壁挡住，只有傍晚太阳快落山时，才能透过墙缝照进零星的光亮，大部分时间都处在阴冷的阴影里，泥土也只有薄薄一层。几天后，种子发了芽，长出了嫩绿的小叶子。它慢慢抬起叶子，好奇地打量着周围，当看到墙头上那些沐浴在阳光下的牵牛花时，眼睛一下子亮了 —— 那些同伴开着紫色、粉色的花朵，在阳光下舒展着花瓣，美得耀眼，还吸引着蝴蝶和蜜蜂前来采蜜。小牵牛花心里满是羡慕，它暗暗告诉自己：“我也要爬到墙头上去，看看阳光的样子，开出漂亮的花。” 从那以后，它每天都使劲把根往泥土深处扎，哪怕泥土坚硬，也要努力寻找水分和养分；嫩绿的茎秆像一根小小的藤蔓，努力向上伸展，还长出细细的卷须，一旦碰到墙壁，就紧紧地缠绕住，一点点向上爬。墙壁粗糙的表面，把它的叶子磨得发皱，有时甚至会蹭破茎秆的表皮，渗出小小的汁液，但它从没想过放弃。累了，就趁着傍晚的微光歇一会儿；渴了，就等着偶尔的雨水滋润。就这样，它日复一日地向上爬，茎秆越来越长，叶子也越来越多。终于，在一个清晨，当第一缕阳光越过墙头时，小牵牛花的花苞刚好顺着墙壁伸出了墙头。阳光洒在花苞上，暖洋洋的，花苞慢慢舒展，粉色的花瓣一层一层打开，像一个小小的喇叭，在阳光下绽放出属于自己的美丽。路过的人看到这朵从墙角爬上来的牵牛花，都忍不住停下脚步，称赞它的顽强。'),(9,'2026-04-08 08:29:31','断弦的琴','琴断弦后被弃，修复后仍奏妙音','file/newsPicture9.jpg','在一间雅致的书房里，放着一把有着深棕色木纹理的古琴，琴身上雕刻着精致的云纹，摸起来光滑温润。从前，主人每天都会坐在琴前，手指在琴弦上轻轻拨动，悠扬的琴声便会在房间里回荡，有时像流水潺潺，有时像鸟鸣山涧，陪伴主人度过了许多宁静的时光。可就在某天，主人弹奏一首激昂的曲子时，琴弦突然 “嘣” 的一声断了，清脆的琴声戛然而止，只剩下断裂的琴弦垂在琴身上，再也发不出完整的声音。主人看着断弦的琴，摇了摇头，觉得它再也不能弹奏乐曲，便随手把它搬到了仓库的角落。仓库里堆满了杂物，灰尘一点点落在琴身上，把精致的云纹盖得严严实实，琴身也渐渐失去了往日的光泽，变得灰蒙蒙的，像一件被遗忘的旧物。半年后，一位头发花白的老工匠来仓库找工具，偶然发现了角落里的古琴。他轻轻拂去琴身上的灰尘，露出了下面温润的木纹理和精致的云纹。老工匠仔细检查了琴身，发现木质依然完好，没有丝毫开裂，只是琴弦断了而已。“多好的琴啊，扔了太可惜了。” 老工匠惋惜地说。他把琴小心地抱回家，放在通风的地方晾干，然后用细砂纸轻轻打磨琴身，去除上面的污渍和细小的划痕，让琴身重新恢复了温润的光泽。接着，他从抽屉里拿出珍藏的蚕丝，仔细挑选出最纤细、最有韧性的丝线，按照古琴的标准，一点点捻成新的琴弦，再小心翼翼地把琴弦固定在琴上，调整好松紧。当一切准备就绪，老工匠坐在琴前，手指轻轻拨动新的琴弦。瞬间，清亮又悠扬的琴声在屋里响起，和从前一样动听，甚至多了几分岁月沉淀的温润。这把曾经被遗弃的琴，在老工匠的手里，又重新找回了自己的价值，再次奏响了美妙的旋律。'),(10,'2026-04-08 08:29:31','小蚂蚁搬粮','小蚂蚁搬大粮，团结协作成功','file/newsPicture10.jpg','雨后的草丛格外清新，露珠挂在叶片上，像一颗颗透明的珍珠。一只小小的蚂蚁从蚁穴里钻出来，晃了晃触角，开始四处觅食。它沿着草根慢慢爬行，忽然，在一片三叶草的叶子下面，发现了一粒金黄的玉米粒 —— 这粒玉米粒比它的身体大好几倍，表面光滑，看起来饱满又有分量。小蚂蚁兴奋地爬过去，用头顶了顶玉米粒，玉米粒纹丝不动；它又绕到玉米粒后面，用后腿使劲推，可玉米粒还是稳稳地躺在那里，丝毫没有移动的迹象。小蚂蚁累得直喘气，触角也耷拉了下来，但它没有放弃 —— 这粒玉米粒足够蚁穴里的同伴们吃好几天，绝不能就这样放弃。它飞快地掉转方向，沿着来时的路跑回蚁穴，一路上还时不时用触角碰一碰路边的同伴，传递着发现粮食的消息。回到蚁穴后，小蚂蚁找到了蚁群的首领，用触角不停地蹭首领的身体，兴奋地 “汇报” 着情况。首领立刻明白了它的意思，挥动着触角，发出了召集的信号。不一会儿，一群蚂蚁跟着小蚂蚁，浩浩荡荡地向玉米粒的方向爬去。来到玉米粒旁，蚂蚁们立刻忙碌起来：体型大一些的蚂蚁趴在玉米粒前面，用嘴咬住玉米粒，使劲向后拉；还有一些蚂蚁在后面，用头顶、用脚推，齐心协力向前挪动；剩下的几只蚂蚁则在旁边来回跑动，时不时调整一下玉米粒的方向，避免它卡在草根之间。它们还时不时发出细微的 “吱吱” 声，像是在喊着整齐的口号，给自己加油打气。');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shujifenlei`
--

DROP TABLE IF EXISTS `shujifenlei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shujifenlei` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='书籍分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shujifenlei`
--

LOCK TABLES `shujifenlei` WRITE;
/*!40000 ALTER TABLE `shujifenlei` DISABLE KEYS */;
INSERT INTO `shujifenlei` VALUES (1,'2026-04-08 08:29:32','自我提升'),(2,'2026-04-08 08:29:32','心理学'),(3,'2026-04-08 08:29:32','外国文学'),(4,'2026-04-08 08:29:32','计算机'),(5,'2026-04-08 08:29:32','通俗小说'),(6,'2026-04-08 08:29:32','计算机'),(7,'2026-04-08 08:29:32','自我提升'),(8,'2026-04-08 08:29:32','计算机'),(9,'2026-04-08 08:29:32','计算机'),(10,'2026-04-08 08:29:32','传统文化');
/*!40000 ALTER TABLE `shujifenlei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shujixinxi`
--

DROP TABLE IF EXISTS `shujixinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shujixinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shujimingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍名称',
  `fengmian` longtext COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  `bianma` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN',
  `kejieshuliang` int(11) DEFAULT NULL COMMENT '可借数量',
  `chubannianfen` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版年份',
  `zuozhe` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
  `yeshu` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页数',
  `chubanshe` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版社',
  `jianjie` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简介',
  `baozhuang` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '包装',
  `storeup_number` int(11) DEFAULT '0' COMMENT '收藏数',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='书籍信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shujixinxi`
--

LOCK TABLES `shujixinxi` WRITE;
/*!40000 ALTER TABLE `shujixinxi` DISABLE KEYS */;
INSERT INTO `shujixinxi` VALUES (1,'2026-04-08 08:29:31','刻意练习','file/shujixinxi_刻意练习1.jpg,file/shujixinxi_刻意练习2.jpg,file/shujixinxi_刻意练习3.jpg','自我提升','9787111640018',148,'2016','安德斯・艾利克森','272','机械工业出版社','作者通过研究各领域杰出人物的成长经历提出“刻意练习”理论阐述了如何通过有目的有方法的练习提升技能实现个人能力的突破','平装珍藏版',1,'2026-04-08 16:29:31'),(2,'2026-04-08 08:29:31','思考快与慢','file/shujixinxi_思考快与慢1.jpg,file/shujixinxi_思考快与慢2.jpg,file/shujixinxi_思考快与慢3.jpg','心理学','9787508675515',178,'2012','卡尼曼','420','中信出版社','作者提出人类思维存在快与慢两种模式通过大量实验和案例分析了两种思维模式的特点局限以及对判断和决策的影响是行为经济学的重要著作','平装便携版',3,'2026-04-08 16:29:31'),(3,'2026-04-08 08:29:31','追风筝的人','file/shujixinxi_追风筝的人1.jpg,file/shujixinxi_追风筝的人2.jpg,file/shujixinxi_追风筝的人3.jpg','外国文学','9787530209430',39,'2006','卡勒德・胡赛尼','330','上海人民出版社','讲述了阿富汗少年阿米尔与仆人哈桑之间的友情阿米尔因懦弱背叛哈桑多年后为了赎罪重返故乡在动荡的局势中寻找救赎的故事情感真挚动人','精装版',3,'2026-04-08 16:29:31'),(4,'2026-04-08 08:29:31','深度学习','file/shujixinxi_深度学习1.jpg,file/shujixinxi_深度学习2.jpg,file/shujixinxi_深度学习3.jpg','计算机','9787115528028',23,'2018','伊恩・古德费洛','585','人民邮电出版社','全面介绍了深度学习的理论基础核心算法和实际应用涵盖神经网络卷积神经网络循环神经网络等关键内容是深度学习领域的经典教材','平装',4,'2026-04-08 16:29:31'),(5,'2026-04-08 08:29:31','活着','file/shujixinxi_活着1.jpg,file/shujixinxi_活着2.jpg,file/shujixinxi_活着3.jpg','通俗小说','9787506365437',62,'2017','余华','191','作家出版社','讲述了农民福贵一生的坎坷经历从富贵到贫穷亲人相继离世但他依然坚强地活着展现了生命的韧性与力量','精装版',5,'2026-04-08 16:29:31'),(6,'2026-04-08 08:29:31','数据库系统概念','file/shujixinxi_数据库系统概念1.jpg,file/shujixinxi_数据库系统概念2.jpg,file/shujixinxi_数据库系统概念3.jpg','计算机','9787111523686',135,'2018','西尔伯沙茨','802','机械工业出版社','全面介绍了数据库系统的基本概念设计原理和实现技术包括关系模型SQL语言数据库安全与并发控制等内容是数据库领域的经典教材','硬壳精装',6,'2026-04-08 16:29:31'),(7,'2026-04-08 08:29:31','高效能人士的七个习惯','file/shujixinxi_高效能人士的七个习惯1.jpg,file/shujixinxi_高效能人士的七个习惯2.jpg,file/shujixinxi_高效能人士的七个习惯3.jpg','自我提升','9787508698765',112,'2018','柯维','371','中国青年出版社','提出了积极主动以终为始要事第一双赢思维知彼解己统合综效不断更新七个习惯通过案例和方法指导读者提升个人效能实现个人与人际关系的成功','硬壳精装',7,'2026-04-08 16:29:31'),(8,'2026-04-08 08:29:31','Python编程：从入门到实践','file/shujixinxi_Python编程：从入门到实践1.jpg,file/shujixinxi_Python编程：从入门到实践2.jpg,file/shujixinxi_Python编程：从入门到实践3.jpg','计算机','9787115528028	',167,'2016','埃里克森','445','人民邮电出版社','书中分为基础篇和项目篇基础篇讲解Python语法和核心概念项目篇通过制作游戏Web应用等实际项目帮助读者将所学知识应用到实践中适合编程初学者','胶装',8,'2026-04-08 16:29:31'),(9,'2026-04-08 08:29:31','机器学习实战','file/shujixinxi_机器学习实战1.jpg,file/shujixinxi_机器学习实战2.jpg,file/shujixinxi_机器学习实战3.jpg','计算机','9787115428028',200,'2013','彼得・哈灵顿','325','人民邮电出版社','以Python语言为工具通过具体案例讲解了机器学习的常用算法包括分类回归聚类等读者可跟随书中步骤实现算法掌握机器学习的实战技能','平装',9,'2026-04-08 16:29:31'),(10,'2026-04-08 08:29:31','道德经译注','file/shujixinxi_道德经译注1.jpg,file/shujixinxi_道德经译注2.jpg,file/shujixinxi_道德经译注3.jpg','传统文化','9787532598763',89,'2009','陈鼓应','312','中华书局','对《道德经》原文进行了注释和解读深入分析了老子的哲学思想包括“道”“德”“无为而治”等核心概念帮助读者理解中国传统哲学的精髓','精装双封',10,'2026-04-08 16:29:31');
/*!40000 ALTER TABLE `shujixinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeup`
--

DROP TABLE IF EXISTS `storeup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) DEFAULT NULL COMMENT 'refid',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='我的收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeup`
--

LOCK TABLES `storeup` WRITE;
/*!40000 ALTER TABLE `storeup` DISABLE KEYS */;
INSERT INTO `storeup` VALUES (1,'2026-04-08 09:09:02',2,'shujixinxi','思考快与慢','file/shujixinxi_思考快与慢1.jpg','1',NULL,NULL,60);
/*!40000 ALTER TABLE `storeup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syslog`
--

DROP TABLE IF EXISTS `syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `syslog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `operation` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户操作',
  `method` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方法',
  `params` longtext COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `time` bigint(20) DEFAULT NULL COMMENT '请求时长(毫秒)',
  `ip` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syslog`
--

LOCK TABLES `syslog` WRITE;
/*!40000 ALTER TABLE `syslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(500) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,1,'admin','users','管理员','7nt3u8uykl4b4h4o2oms3lbz2ub3s7lh','2026-04-08 08:48:56','2026-04-08 09:48:57'),(2,60,'791','yonghu','用户','90ovqnlhpul1jp417xl4qfqlr3imy6yi','2026-04-08 09:05:58','2026-04-08 10:05:59');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tushuguihai`
--

DROP TABLE IF EXISTS `tushuguihai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tushuguihai` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zujiebianhao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '租借编号',
  `shujimingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍名称',
  `fengmian` longtext COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  `bianma` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN',
  `jieyueshuliang` int(11) DEFAULT NULL COMMENT '归还数量',
  `yonghuming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `xingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `guihaishijian` date DEFAULT NULL COMMENT '归还时间',
  `shifouyuqi` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否逾期',
  `crossuserid` bigint(20) DEFAULT NULL COMMENT '跨表用户id',
  `crossrefid` bigint(20) DEFAULT NULL COMMENT '跨表主键id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图书归还';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tushuguihai`
--

LOCK TABLES `tushuguihai` WRITE;
/*!40000 ALTER TABLE `tushuguihai` DISABLE KEYS */;
INSERT INTO `tushuguihai` VALUES (1,'2026-04-08 08:29:32','租借编号1','刻意练习','file/tushuguihai_刻意练习1.jpg,file/tushuguihai_刻意练习2.jpg,file/tushuguihai_刻意练习3.jpg','自我提升','9787111640018',148,'345','钱景明','2026-04-08','是.否',1,1),(2,'2026-04-08 08:29:32','租借编号2','思考快与慢','file/tushuguihai_思考快与慢1.jpg,file/tushuguihai_思考快与慢2.jpg,file/tushuguihai_思考快与慢3.jpg','心理学','9787508675515',178,'291','郑舒然','2026-04-08','是.否',2,2),(3,'2026-04-08 08:29:32','租借编号3','追风筝的人','file/tushuguihai_追风筝的人1.jpg,file/tushuguihai_追风筝的人2.jpg,file/tushuguihai_追风筝的人3.jpg','外国文学','9787530209430',39,'389','陈思远','2026-04-08','是.否',3,3),(4,'2026-04-08 08:29:32','租借编号4','深度学习','file/tushuguihai_深度学习1.jpg,file/tushuguihai_深度学习2.jpg,file/tushuguihai_深度学习3.jpg','计算机','9787115528028',23,'657','何雨欣','2026-04-08','是.否',4,4),(5,'2026-04-08 08:29:32','租借编号5','活着','file/tushuguihai_活着1.jpg,file/tushuguihai_活着2.jpg,file/tushuguihai_活着3.jpg','通俗小说','9787506365437',62,'278','吴彦辰','2026-04-08','是.否',5,5),(6,'2026-04-08 08:29:32','租借编号6','数据库系统概念','file/tushuguihai_数据库系统概念1.jpg,file/tushuguihai_数据库系统概念2.jpg,file/tushuguihai_数据库系统概念3.jpg','计算机','9787111523686',135,'567','沈泽宇','2026-04-08','是.否',6,6),(7,'2026-04-08 08:29:32','租借编号7','高效能人士的七个习惯','file/tushuguihai_高效能人士的七个习惯1.jpg,file/tushuguihai_高效能人士的七个习惯2.jpg,file/tushuguihai_高效能人士的七个习惯3.jpg','自我提升','9787508698765',112,'145','李若曦','2026-04-08','是.否',7,7),(8,'2026-04-08 08:29:32','租借编号8','Python编程：从入门到实践','file/tushuguihai_Python编程：从入门到实践1.jpg,file/tushuguihai_Python编程：从入门到实践2.jpg,file/tushuguihai_Python编程：从入门到实践3.jpg','计算机','9787115528028	',167,'491','蒋欣怡','2026-04-08','是.否',8,8),(9,'2026-04-08 08:29:32','租借编号9','机器学习实战','file/tushuguihai_机器学习实战1.jpg,file/tushuguihai_机器学习实战2.jpg,file/tushuguihai_机器学习实战3.jpg','计算机','9787115428028',200,'713','高思涵','2026-04-08','是.否',9,9),(10,'2026-04-08 08:29:32','租借编号10','道德经译注','file/tushuguihai_道德经译注1.jpg,file/tushuguihai_道德经译注2.jpg,file/tushuguihai_道德经译注3.jpg','传统文化','9787532598763',89,'791','顾清颜','2026-04-08','是.否',10,10),(11,'2026-04-08 09:06:28','11111111110','道德经译注','file/tushujieyue_道德经译注1.jpg,file/tushujieyue_道德经译注2.jpg,file/tushujieyue_道德经译注3.jpg','传统文化','9787532598763',1,'791','顾清颜','2026-04-08','否',60,10);
/*!40000 ALTER TABLE `tushuguihai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tushujieyue`
--

DROP TABLE IF EXISTS `tushujieyue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tushujieyue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zujiebianhao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '租借编号',
  `shujimingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍名称',
  `fengmian` longtext COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  `bianma` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN',
  `jieyueshuliang` int(11) DEFAULT NULL COMMENT '借阅数量',
  `yonghuming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `xingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `jieyueshijian` datetime DEFAULT NULL COMMENT '借阅时间',
  `guihaishijian` date DEFAULT NULL COMMENT '归还时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zujiebianhao` (`zujiebianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图书借阅';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tushujieyue`
--

LOCK TABLES `tushujieyue` WRITE;
/*!40000 ALTER TABLE `tushujieyue` DISABLE KEYS */;
INSERT INTO `tushujieyue` VALUES (1,'2026-04-08 08:29:31','1111111111','刻意练习','file/tushujieyue_刻意练习1.jpg,file/tushujieyue_刻意练习2.jpg,file/tushujieyue_刻意练习3.jpg','自我提升','9787111640018',148,'345','钱景明','是','','2026-04-08 16:29:31','2026-04-08'),(2,'2026-04-08 08:29:31','2222222222','思考快与慢','file/tushujieyue_思考快与慢1.jpg,file/tushujieyue_思考快与慢2.jpg,file/tushujieyue_思考快与慢3.jpg','心理学','9787508675515',178,'291','郑舒然','是','','2026-04-08 16:29:31','2026-04-08'),(3,'2026-04-08 08:29:31','3333333333','追风筝的人','file/tushujieyue_追风筝的人1.jpg,file/tushujieyue_追风筝的人2.jpg,file/tushujieyue_追风筝的人3.jpg','外国文学','9787530209430',39,'389','陈思远','是','','2026-04-08 16:29:31','2026-04-08'),(4,'2026-04-08 08:29:31','4444444444','深度学习','file/tushujieyue_深度学习1.jpg,file/tushujieyue_深度学习2.jpg,file/tushujieyue_深度学习3.jpg','计算机','9787115528028',23,'657','何雨欣','是','','2026-04-08 16:29:31','2026-04-08'),(5,'2026-04-08 08:29:31','5555555555','活着','file/tushujieyue_活着1.jpg,file/tushujieyue_活着2.jpg,file/tushujieyue_活着3.jpg','通俗小说','9787506365437',62,'278','吴彦辰','是','','2026-04-08 16:29:31','2026-04-08'),(6,'2026-04-08 08:29:31','6666666666','数据库系统概念','file/tushujieyue_数据库系统概念1.jpg,file/tushujieyue_数据库系统概念2.jpg,file/tushujieyue_数据库系统概念3.jpg','计算机','9787111523686',135,'567','沈泽宇','是','','2026-04-08 16:29:31','2026-04-08'),(7,'2026-04-08 08:29:31','7777777777','高效能人士的七个习惯','file/tushujieyue_高效能人士的七个习惯1.jpg,file/tushujieyue_高效能人士的七个习惯2.jpg,file/tushujieyue_高效能人士的七个习惯3.jpg','自我提升','9787508698765',112,'145','李若曦','是','','2026-04-08 16:29:31','2026-04-08'),(8,'2026-04-08 08:29:31','8888888888','Python编程：从入门到实践','file/tushujieyue_Python编程：从入门到实践1.jpg,file/tushujieyue_Python编程：从入门到实践2.jpg,file/tushujieyue_Python编程：从入门到实践3.jpg','计算机','9787115528028	',167,'491','蒋欣怡','是','','2026-04-08 16:29:31','2026-04-08'),(9,'2026-04-08 08:29:31','9999999999','机器学习实战','file/tushujieyue_机器学习实战1.jpg,file/tushujieyue_机器学习实战2.jpg,file/tushujieyue_机器学习实战3.jpg','计算机','9787115428028',200,'713','高思涵','是','','2026-04-08 16:29:31','2026-04-08'),(10,'2026-04-08 08:29:31','11111111110','道德经译注','file/tushujieyue_道德经译注1.jpg,file/tushujieyue_道德经译注2.jpg,file/tushujieyue_道德经译注3.jpg','传统文化','9787532598763',89,'791','顾清颜','是','','2026-04-08 16:29:31','2026-04-08'),(11,'2026-04-08 09:06:10','1775639164649','机器学习实战','file/shujixinxi_机器学习实战1.jpg,file/shujixinxi_机器学习实战2.jpg,file/shujixinxi_机器学习实战3.jpg','计算机','9787115428028',1,'791','顾清颜','是','是','2026-04-08 17:06:05',NULL);
/*!40000 ALTER TABLE `tushujieyue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tushuxujie`
--

DROP TABLE IF EXISTS `tushuxujie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tushuxujie` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zujiebianhao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '租借编号',
  `shujimingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍名称',
  `fengmian` longtext COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  `bianma` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN',
  `jieyueshuliang` int(11) DEFAULT NULL COMMENT '借阅数量',
  `yonghuming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `xingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `jieyueshijian` datetime DEFAULT NULL COMMENT '借阅时间',
  `guihaishijian` date DEFAULT NULL COMMENT '归还时间',
  `xujieshijian` date DEFAULT NULL COMMENT '续借时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图书续借';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tushuxujie`
--

LOCK TABLES `tushuxujie` WRITE;
/*!40000 ALTER TABLE `tushuxujie` DISABLE KEYS */;
INSERT INTO `tushuxujie` VALUES (1,'2026-04-08 08:29:32','租借编号1','刻意练习','file/tushuxujie_刻意练习1.jpg,file/tushuxujie_刻意练习2.jpg,file/tushuxujie_刻意练习3.jpg','自我提升','9787111640018',148,'345','钱景明','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(2,'2026-04-08 08:29:32','租借编号2','思考快与慢','file/tushuxujie_思考快与慢1.jpg,file/tushuxujie_思考快与慢2.jpg,file/tushuxujie_思考快与慢3.jpg','心理学','9787508675515',178,'291','郑舒然','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(3,'2026-04-08 08:29:32','租借编号3','追风筝的人','file/tushuxujie_追风筝的人1.jpg,file/tushuxujie_追风筝的人2.jpg,file/tushuxujie_追风筝的人3.jpg','外国文学','9787530209430',39,'389','陈思远','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(4,'2026-04-08 08:29:32','租借编号4','深度学习','file/tushuxujie_深度学习1.jpg,file/tushuxujie_深度学习2.jpg,file/tushuxujie_深度学习3.jpg','计算机','9787115528028',23,'657','何雨欣','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(5,'2026-04-08 08:29:32','租借编号5','活着','file/tushuxujie_活着1.jpg,file/tushuxujie_活着2.jpg,file/tushuxujie_活着3.jpg','通俗小说','9787506365437',62,'278','吴彦辰','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(6,'2026-04-08 08:29:32','租借编号6','数据库系统概念','file/tushuxujie_数据库系统概念1.jpg,file/tushuxujie_数据库系统概念2.jpg,file/tushuxujie_数据库系统概念3.jpg','计算机','9787111523686',135,'567','沈泽宇','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(7,'2026-04-08 08:29:32','租借编号7','高效能人士的七个习惯','file/tushuxujie_高效能人士的七个习惯1.jpg,file/tushuxujie_高效能人士的七个习惯2.jpg,file/tushuxujie_高效能人士的七个习惯3.jpg','自我提升','9787508698765',112,'145','李若曦','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(8,'2026-04-08 08:29:32','租借编号8','Python编程：从入门到实践','file/tushuxujie_Python编程：从入门到实践1.jpg,file/tushuxujie_Python编程：从入门到实践2.jpg,file/tushuxujie_Python编程：从入门到实践3.jpg','计算机','9787115528028	',167,'491','蒋欣怡','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(9,'2026-04-08 08:29:32','租借编号9','机器学习实战','file/tushuxujie_机器学习实战1.jpg,file/tushuxujie_机器学习实战2.jpg,file/tushuxujie_机器学习实战3.jpg','计算机','9787115428028',200,'713','高思涵','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(10,'2026-04-08 08:29:32','租借编号10','道德经译注','file/tushuxujie_道德经译注1.jpg,file/tushuxujie_道德经译注2.jpg,file/tushuxujie_道德经译注3.jpg','传统文化','9787532598763',89,'791','顾清颜','是','','2026-04-08 16:29:32','2026-04-08','2026-04-08'),(11,'2026-04-08 09:06:32','11111111110','道德经译注','file/tushujieyue_道德经译注1.jpg,file/tushujieyue_道德经译注2.jpg,file/tushujieyue_道德经译注3.jpg','传统文化','9787532598763',1,'791','顾清颜','是','是','2026-04-08 16:29:31','2026-04-08','2026-04-09');
/*!40000 ALTER TABLE `tushuxujie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '管理员' COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-04-08 08:29:32','admin','admin','管理员');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yonghu`
--

DROP TABLE IF EXISTS `yonghu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yonghuming` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `mima` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `xingming` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `xingbie` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nianling` int(11) DEFAULT NULL COMMENT '年龄',
  `youxiang` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `max_password_wrong` int(11) NOT NULL DEFAULT '-1' COMMENT '最大密码输错次数',
  `is_locked` int(11) NOT NULL DEFAULT '0' COMMENT '用户锁定状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yonghuming` (`yonghuming`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yonghu`
--

LOCK TABLES `yonghu` WRITE;
/*!40000 ALTER TABLE `yonghu` DISABLE KEYS */;
INSERT INTO `yonghu` VALUES (51,'2026-04-08 08:29:31','345','123456','钱景明','男','file/yonghuTouxiang1.jpg',42,'qianyi@sina.com',1,0),(52,'2026-04-08 08:29:31','291','123456','郑舒然','女','file/yonghuTouxiang2.jpg',25,'zhengshi@qq.com',2,0),(53,'2026-04-08 08:29:31','389','123456','陈思远','男','file/yonghuTouxiang3.jpg',38,'chensan@yeah.net',3,0),(54,'2026-04-08 08:29:31','657','123456','何雨欣','女','file/yonghuTouxiang4.jpg',40,'heyuxin@sina.com',4,0),(55,'2026-04-08 08:29:31','278','123456','吴彦辰','男','file/yonghuTouxiang5.jpg',32,'wujia@163.com',5,0),(56,'2026-04-08 08:29:31','567','123456','沈泽宇','男','file/yonghuTouxiang6.jpg',36,'shenqi@126.com',6,0),(57,'2026-04-08 08:29:31','145','123456','李若曦','女','file/yonghuTouxiang7.jpg',35,'lisi@qq.com',7,0),(58,'2026-04-08 08:29:31','491','123456','蒋欣怡','女','file/yonghuTouxiang8.jpg',24,'jiangliu@sina.com',8,0),(59,'2026-04-08 08:29:31','713','123456','高思涵','女','file/yonghuTouxiang9.jpg',26,'gaosihan@yeah.net',9,0),(60,'2026-04-08 08:29:31','791','123456','顾清颜','女','file/yonghuTouxiang10.jpg',20,'guqingyan@126.com',10,0);
/*!40000 ALTER TABLE `yonghu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yuqifakuan`
--

DROP TABLE IF EXISTS `yuqifakuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yuqifakuan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yuqibianhao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '逾期编号',
  `zujiebianhao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '租借编号',
  `shujimingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍名称',
  `fengmian` longtext COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shujifenlei` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书籍分类',
  `bianma` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN',
  `jieyueshuliang` int(11) DEFAULT NULL COMMENT '归还数量',
  `yonghuming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `xingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `guihaishijian` date DEFAULT NULL COMMENT '归还时间',
  `fakuanjine` double DEFAULT NULL COMMENT '罚款金额',
  `ispay` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '未支付' COMMENT '是否支付',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yuqibianhao` (`yuqibianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='逾期罚款';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yuqifakuan`
--

LOCK TABLES `yuqifakuan` WRITE;
/*!40000 ALTER TABLE `yuqifakuan` DISABLE KEYS */;
INSERT INTO `yuqifakuan` VALUES (1,'2026-04-08 08:29:32','1111111111','租借编号1','刻意练习','file/yuqifakuan_刻意练习1.jpg,file/yuqifakuan_刻意练习2.jpg,file/yuqifakuan_刻意练习3.jpg','自我提升','9787111640018',148,'345','钱景明','2026-04-08',1,'未支付'),(2,'2026-04-08 08:29:32','2222222222','租借编号2','思考快与慢','file/yuqifakuan_思考快与慢1.jpg,file/yuqifakuan_思考快与慢2.jpg,file/yuqifakuan_思考快与慢3.jpg','心理学','9787508675515',178,'291','郑舒然','2026-04-08',2,'未支付'),(3,'2026-04-08 08:29:32','3333333333','租借编号3','追风筝的人','file/yuqifakuan_追风筝的人1.jpg,file/yuqifakuan_追风筝的人2.jpg,file/yuqifakuan_追风筝的人3.jpg','外国文学','9787530209430',39,'389','陈思远','2026-04-08',3,'未支付'),(4,'2026-04-08 08:29:32','4444444444','租借编号4','深度学习','file/yuqifakuan_深度学习1.jpg,file/yuqifakuan_深度学习2.jpg,file/yuqifakuan_深度学习3.jpg','计算机','9787115528028',23,'657','何雨欣','2026-04-08',4,'未支付'),(5,'2026-04-08 08:29:32','5555555555','租借编号5','活着','file/yuqifakuan_活着1.jpg,file/yuqifakuan_活着2.jpg,file/yuqifakuan_活着3.jpg','通俗小说','9787506365437',62,'278','吴彦辰','2026-04-08',5,'未支付'),(6,'2026-04-08 08:29:32','6666666666','租借编号6','数据库系统概念','file/yuqifakuan_数据库系统概念1.jpg,file/yuqifakuan_数据库系统概念2.jpg,file/yuqifakuan_数据库系统概念3.jpg','计算机','9787111523686',135,'567','沈泽宇','2026-04-08',6,'未支付'),(7,'2026-04-08 08:29:32','7777777777','租借编号7','高效能人士的七个习惯','file/yuqifakuan_高效能人士的七个习惯1.jpg,file/yuqifakuan_高效能人士的七个习惯2.jpg,file/yuqifakuan_高效能人士的七个习惯3.jpg','自我提升','9787508698765',112,'145','李若曦','2026-04-08',7,'未支付'),(8,'2026-04-08 08:29:32','8888888888','租借编号8','Python编程：从入门到实践','file/yuqifakuan_Python编程：从入门到实践1.jpg,file/yuqifakuan_Python编程：从入门到实践2.jpg,file/yuqifakuan_Python编程：从入门到实践3.jpg','计算机','9787115528028	',167,'491','蒋欣怡','2026-04-08',8,'未支付'),(9,'2026-04-08 08:29:32','9999999999','租借编号9','机器学习实战','file/yuqifakuan_机器学习实战1.jpg,file/yuqifakuan_机器学习实战2.jpg,file/yuqifakuan_机器学习实战3.jpg','计算机','9787115428028',200,'713','高思涵','2026-04-08',9,'未支付'),(10,'2026-04-08 08:29:32','11111111110','租借编号10','道德经译注','file/yuqifakuan_道德经译注1.jpg,file/yuqifakuan_道德经译注2.jpg,file/yuqifakuan_道德经译注3.jpg','传统文化','9787532598763',89,'791','顾清颜','2026-04-08',10,'未支付'),(11,'2026-04-08 09:06:44','1775639198601','11111111110','道德经译注','file/tushujieyue_道德经译注1.jpg,file/tushujieyue_道德经译注2.jpg,file/tushujieyue_道德经译注3.jpg','传统文化','9787532598763',1,'791','顾清颜','2026-04-08',300,'已支付');
/*!40000 ALTER TABLE `yuqifakuan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-18 14:34:57
