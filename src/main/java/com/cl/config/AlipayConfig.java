package com.cl.config;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
    //↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "9021000162689498";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCaZ+REFffdz/L8jq4EPywwhg1PPu7WlXkoQq/BymTZrhLGlHU0BXNQIpzin20A0iBLLtvnzxJs1sBRTV9RfcnOjE8Tp7DvuQL1q9whgQ6mCXHI+SrZKWXQrSsXK8gVt+3RfigNZ5GdiBCQuOCMN/yhRWtQlh79qb/mfIf0m1qLjo6YeKEWUJ0OivJLd6oQB5IZ/It+22x3j0ORJOxJIgdwWnSC66PQ6LBxbha30IdK5FXtXT4eCOSCxASGz557ICuse97oIt8zkw3NUYQvcdECx2wrLGPsgqpHanilWtBknI/F2bt7+wO2CZLCLqo56w0950EFFBbNBLRqnbO7pbuvAgMBAAECggEAeJ7ifqHewYQa4Vug66ZiIgIG0bprIG0ieeYmoTA4Oqk297SwHpSHcbmob411vOdp3PHdTqjATxAwqxLTfLjUdyu69rLQkWUpv7ujOvUz+Vd1cTfdVkp1xGATQoWsR/MosLhqF5ap9bN+pWAX4tI149J0ND8iNK1wQWFVYCwgvtXAwyP/Y1BEvoqASagcEJdBaXV47Mi+9WJStby6TrwoU5i7XlBuF/KyNeUas3DJ+BMmqG3xuQI/HxY5tV5pJFEJ30stHVHwokjHDiNYnd104wEOjw79GWWa26sXvzBhWjzgNfd8LbcyT6K/Ra8s6DOUb5OwaRntRX1LGiov31X0cQKBgQDz3zWIe/JQGl4QuM/5gGRoXM4zSVh8inHt17N3x7VKGEeSmrbHJcwQSi6cs2S+1WV5DDmMCo/ENVym9cr3f34O5/GEoyRjP920Y/onPLY9dl5/mdmGHCNy/pcYo0GuSaJ+6tMMU6a1+etZiGniR7EtTAq+I1dXXSnX6Y6fGZuLSQKBgQCiFaswhyEDABwbI/Thb3lPgfQBFSf+QFzxcC6EFYvOXws7b+P0iG0Dt1hGbTCRSVKGy+e58Rdeq1pAMRjSJt6won5ChpAJttPoy5maamyjUnTtTqCGdPfS2OOtzST56PFX1Jy8vglE5SkBL2pz6hVKGacwLZCnQijQHboFOr1XNwKBgDHENSp7EMHj/5ot/NMPrm3VsoaoyxPvNLyyrf8dlBNgzQpP5EjTn8cbPFPiEAcZiTGgmwXHCfuiYBv6QMctD05/arwEhuJyIA418NCdBRuZ0kL75HYHu/w1lCQE/NxSToTT6umzEGxGag7FVcZFlxSFVhPjJmm/q1BSazZwhVtxAoGAIi3nl6gnMfbH9oEylodnUXjZ95B6iocQEmnRpVDV1oL8X2BM9bf/JRV4rAFCiKCpontFNlS81N3VfkvcLBS+SQk7DtRJc4L2VNT6YzGmDxrIRXKbLz9jMzdBa9kivwB8REU1eCeq1LhuWS2iiScHrkSSmPpC0sKE0L40B/5HBykCgYEA1e3MMuXLGmYwrJkJZEaefn72UUOu7hIHSMYhGcR9wxIvyXnpEH/p4WD0MTmzSPPvzgiM6FBxvMmIG2XPxEth42rMRfW5USU9X6K/FsRUzPWxpVNp3rBE+J25056z7pyOdoQIQJSnjSYaRRGNJQE7p1+c9vj21pd6yd7om9W20mI=";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvVJ9t8OCC3W1+kShRTxu35rHTswmZzY3lkq22JfjXe1g7Vn68YI2WEBUw4ZEMCgv+VpOF6ltSGt7zX91x3gHQ6Dnkvf31/oajWUQHn9ewNKZwBQL2tQUqMsDgmCJpndDdBtWzVK6NTl2MQLvqq0GqI6Qin6yjwJde1C+XxFFl7jRFrNJoKZuyJOffivuXzR3nvoYlCydHgmFEluY7yh6juszvS8xCcj7ih9ip1hPMmjygOHEx24FiOeqFvSPY5WD0DwWpxUFNT7NQfi4tPhGiUB39vvG7OOzU73A35UQ9F002o5zK4Zj8gT+UxkeYrsu4dXp2j43RMF/vPr49Kt2QQIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "http://987429woog60.vicp.fun/cl806133279/";
    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url_b = "http://localhost:8080/cl806133279/manage/";
    public static String return_url_f = "http://localhost:8080/cl806133279/client/";
    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

    // 日志路径
    public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis() + ".txt" );
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

