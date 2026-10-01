package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.lang.*;
import java.math.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import com.cl.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cl.annotation.IgnoreAuth;
import com.cl.annotation.SysLog;

import com.cl.entity.YuqifakuanEntity;
import com.cl.entity.view.YuqifakuanView;

import com.cl.service.YuqifakuanService;
import com.cl.service.TokenService;
import javax.servlet.http.HttpServletResponse;
import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayApiException;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.cl.config.AlipayConfig;

/**
 * 逾期罚款
 * 后端接口
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@RestController
@RequestMapping("/yuqifakuan")
public class YuqifakuanController {
    @Autowired
    private YuqifakuanService yuqifakuanService;











    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,YuqifakuanEntity yuqifakuan,
                                                                                                                                                                                                                        HttpServletRequest request){
            String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                        if(tableName.equals("yonghu")) {
            yuqifakuan.setYonghuming((String)request.getSession().getAttribute("username"));
                    }
                                                                                EntityWrapper<YuqifakuanEntity> ew = new EntityWrapper<YuqifakuanEntity>();
                                                                                                                                                                                                                
    
    
        PageUtils page = yuqifakuanService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, yuqifakuan), params), params));
        Map<String, String> deSens = new HashMap<>();
                                                                                                                                                                                                                                                                DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,YuqifakuanEntity yuqifakuan, 
		HttpServletRequest request){
        EntityWrapper<YuqifakuanEntity> ew = new EntityWrapper<YuqifakuanEntity>();

		PageUtils page = yuqifakuanService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, yuqifakuan), params), params));
        Map<String, String> deSens = new HashMap<>();
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( YuqifakuanEntity yuqifakuan){
       	EntityWrapper<YuqifakuanEntity> ew = new EntityWrapper<YuqifakuanEntity>();
      	ew.allEq(MPUtil.allEQMapPre( yuqifakuan, MPUtil.camelToSnake("yuqifakuan")));
        return R.ok().put("data", yuqifakuanService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(YuqifakuanEntity yuqifakuan){
        EntityWrapper< YuqifakuanEntity> ew = new EntityWrapper< YuqifakuanEntity>();
 		ew.allEq(MPUtil.allEQMapPre( yuqifakuan, MPUtil.camelToSnake("yuqifakuan")));
		YuqifakuanView yuqifakuanView =  yuqifakuanService.selectView(ew);
		return R.ok("查询逾期罚款成功").put("data", yuqifakuanView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        YuqifakuanEntity yuqifakuan = yuqifakuanService.selectById(id);
		yuqifakuan = yuqifakuanService.selectView(new EntityWrapper<YuqifakuanEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(yuqifakuan,deSens);
        return R.ok().put("data", yuqifakuan);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        YuqifakuanEntity yuqifakuan = yuqifakuanService.selectById(id);
		yuqifakuan = yuqifakuanService.selectView(new EntityWrapper<YuqifakuanEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(yuqifakuan,deSens);
        return R.ok().put("data", yuqifakuan);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增逾期罚款")
    public R save(@RequestBody YuqifakuanEntity yuqifakuan, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(yuqifakuan);

        yuqifakuanService.insert(yuqifakuan);
        return R.ok().put("data",yuqifakuan.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增逾期罚款")
    @RequestMapping("/add")
    public R add(@RequestBody YuqifakuanEntity yuqifakuan, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(yuqifakuan);

        yuqifakuanService.insert(yuqifakuan);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改逾期罚款")
    public R update(@RequestBody YuqifakuanEntity yuqifakuan, HttpServletRequest request){
        //ValidatorUtils.validateEntity(yuqifakuan);
        yuqifakuanService.updateById(yuqifakuan);//全部更新
        return R.ok();
    }

    
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除逾期罚款")
    public R delete(@RequestBody Long[] ids){
        yuqifakuanService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	



    @RequestMapping("/page/alipay")
    public R pagePayController(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) Integer isFront) throws IOException {

        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

    AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
            if(isFront!=null && isFront==1) {
            alipayRequest.setReturnUrl(AlipayConfig.return_url_f+"?centerType=1");
        } else {
            alipayRequest.setReturnUrl(AlipayConfig.return_url_b);
        }
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url+"yuqifakuan"+"/notify");

    String out_trade_no = new String(request.getParameter("tradeno"));
        String total_amount = new String(request.getParameter("totalamount").getBytes("ISO-8859-1"),"UTF-8");
    String subject = new String(request.getParameter("subject"));
    String body = "";

        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
                + "\"total_amount\":\"" + total_amount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String form = "";
        try {
            form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        return R.ok().put("data",form);
    }

    
    
    @IgnoreAuth
    @RequestMapping("notify")
    public R nofity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        /* *
         * 功能：支付宝服务器异步通知页面
         *************************页面功能说明*************************
         * 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
         * 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
         * 如果没有收到该页面返回的 success
         * 建议该页面只做支付成功的业务逻辑处理，退款的处理请以调用退款查询接口的结果为准。
         */

        //获取支付宝POST过来反馈信息
        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        //商户订单号
        String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

        //支付宝交易号
        String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

        //交易状态
        String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

        if(trade_status.equals("TRADE_FINISHED")){
            //判断该笔订单是否在商户网站中已经做过处理
            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
            //如果有做过处理，不执行商户的业务程序

            //注意：
            //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
        }else if (trade_status.equals("TRADE_SUCCESS")){
            //判断该笔订单是否在商户网站中已经做过处理
            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
            //如果有做过处理，不执行商户的业务程序

            //注意：
            //付款完成后，支付宝系统发送该交易状态通知
            YuqifakuanEntity yuqifakuan = yuqifakuanService.selectOne(new EntityWrapper<YuqifakuanEntity>().eq("yuqibianhao", out_trade_no));
                                                        if(yuqifakuan!=null) {
        yuqifakuan.setIspay("已支付");
            yuqifakuanService.updateById(yuqifakuan);
    }
    }

        //——请在这里编写您的程序（以上代码仅作参考）——
        return R.ok();
}





}
