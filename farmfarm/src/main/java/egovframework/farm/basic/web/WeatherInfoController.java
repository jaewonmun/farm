package egovframework.farm.basic.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.farm.job.service.JobProcessVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : WeatherInfoController.java
 * @Description : WeatherInfo Controller class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161127
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JobProcessVO.class)
public class WeatherInfoController {

   /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	   
    @RequestMapping("/weather/weatherInfo.do")
    public String weatherInfo()
            {
        return "/weather/weather";
    }
    
    @RequestMapping("/weather/weatherSK.do")
    public String weatherSK()
            {
        return "/weather/weatherSK";
    }
    
    @RequestMapping("/weather/googleKML.do")
    public String googleKML()
            {
        return "/weather/googleKML";
    }

}
