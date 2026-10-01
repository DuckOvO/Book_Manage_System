package com.cl.controller.view;

import com.cl.annotation.IgnoreAuth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/client")
public class ClientController {

    @IgnoreAuth
    @RequestMapping("/index")
    public String index() {
        return "client/page/index";
    }

    @IgnoreAuth
    @RequestMapping("/login")
    public String login() {
        return "client/page/login";
    }

    @IgnoreAuth
    @RequestMapping("/forget")
    public String forget() {
        return "client/page/forget";
    }

    @IgnoreAuth
    @RequestMapping("/{a}/register")
    public String register(@PathVariable("a") String a) {
        return String.format("/client/page/%s/register", a);
    }

    @IgnoreAuth
    @RequestMapping("/{a}/{b}")
    public String request(@PathVariable("a") String a, @PathVariable("b") String b) {
        return String.format("/client/page/%s/%s", a, b);
    }
}
