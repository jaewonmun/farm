package egovframework.farm.insects.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.farm.job.service.JobProcessService;
import egovframework.farm.job.service.JobProcessDefaultVO;
import egovframework.farm.job.service.JobProcessVO;

/**
 * @Class Name : JobProcessController.java
 * @Description : JobProcess Controller class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JobProcessVO.class)
public class insectsInfoController {

   /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	   
    @RequestMapping("/insectsinfo/InsectsInfo.do")
    public String selectInsectsInfo() {
        return "/insectsinfo/InsectsInfo";
    }
        
}
