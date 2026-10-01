package com.cl.controller.view;

import com.cl.annotation.IgnoreAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/index")
public class indexController {
    /**
     * 前台首页
     */
    @IgnoreAuth
    @RequestMapping("/web")
    public String index(Model model){
        Map pageParams = new HashMap();
        pageParams.put("page","1");
        pageParams.put("limit","20");
                                                                                                                                                                                                                                                                                                                            pageParams.put("sort", "click_number");
        pageParams.put("order", "desc");
                                                                                                                                                                                                                                                                                                                            return "client/page/index";
    }
}
