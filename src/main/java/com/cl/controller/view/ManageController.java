package com.cl.controller.view;

import com.cl.annotation.IgnoreAuth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/manage")
public class ManageController {
    @IgnoreAuth
    @RequestMapping("/login")
    public String login() {
        return "manage/page/login";
    }
    
    @IgnoreAuth
    @RequestMapping("/forget")
    public String forget() {
        return "manage/page/forget";
    }
    
    @IgnoreAuth
    @RequestMapping("/{a}/register")
    public String register(@PathVariable("a") String a) {
        return String.format("/manage/page/%s/register", a);
    }

    @IgnoreAuth
    @RequestMapping("/index")
    public String index() {
        return "manage/page/index";
    }
    
    @RequestMapping("/{a}/{b}")
    @IgnoreAuth
    public String request(@PathVariable("a") String a, @PathVariable("b") String b) {
        return String.format("/manage/page/%s/%s", a, b);
    }
}
