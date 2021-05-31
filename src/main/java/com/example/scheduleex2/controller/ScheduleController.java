package com.example.scheduleex2.controller;

import com.example.scheduleex2.dto.ScheduleVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
//@RequestMapping("/schedule") url 경로추가
public class ScheduleController {

//    @RequestMapping(method = RequestMethod.GET, path = "/getRequest") //localhost8080/schedule/getRequest
//    public String getRequest () {
//        return "this is request ! " ;
//    }

    //
    @RequestMapping( "/jsp")
    public String getRequest () {
        return "main" ;
    }
    //RequestMapping이 Get방식인 것
    @GetMapping("/getMapping")    // << -- >> PostMapping
    public String getReques () {
        return "Mapping ! ! !";
    }
//
//    // GetMapping은 RequestMapping과는 다르게 메소드유형 없이 주소만 지정해주면된다.
//    @GetMapping("/getParameters")  // localhost:8080/getParameters?id=ancrea&email=ancrea7@gmail.com
//    public String getParameters(@RequestParam String id, @RequestParam String email){
//        return "아이디는 "+id+" 이메일은 "+email;
//    }



}
