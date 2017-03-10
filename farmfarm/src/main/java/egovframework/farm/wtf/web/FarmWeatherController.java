package egovframework.farm.wtf.web;

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

import egovframework.farm.wtf.service.FarmWeatherService;
import egovframework.farm.wtf.service.FarmWeatherDefaultVO;
import egovframework.farm.wtf.service.FarmWeatherVO;

/**
 * @Class Name : FarmWeatherController.java
 * @Description : FarmWeather Controller class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161207
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=FarmWeatherVO.class)
public class FarmWeatherController {

    @Resource(name = "farmWeatherService")
    private FarmWeatherService farmWeatherService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * FARM_WEATHER 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 FarmWeatherDefaultVO
	 * @return "/farmWeather/FarmWeatherList"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/farmWeather/FarmWeatherList.do")
    public String selectFarmWeatherList(@ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	*//** EgovPropertyService.sample *//*
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	*//** pageing *//*
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> farmWeatherList = farmWeatherService.selectFarmWeatherList(searchVO);
        model.addAttribute("resultList", farmWeatherList);
        
        int totCnt = farmWeatherService.selectFarmWeatherListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/farmWeather/FarmWeatherList";
    } 
    */
    @RequestMapping("/farmWeather/addFarmWeatherView.do")
    public String addFarmWeatherView(
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("farmWeatherVO", new FarmWeatherVO());
        return "/farmWeather/FarmWeatherRegister";
    }
    
    @RequestMapping("/farmWeather/addFarmWeather.do")
    public String addFarmWeather(
            FarmWeatherVO farmWeatherVO,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, SessionStatus status)
            throws Exception {
        farmWeatherService.insertFarmWeather(farmWeatherVO);
        status.setComplete();
        return "redirect:/farmingDiary/monthList.do";
    }
    
    @RequestMapping("/farmWeather/updateFarmWeatherView.do")
    public String updateFarmWeatherView(
            @RequestParam("mbrId") java.lang.String mbrId ,
            @RequestParam("weatherDate") java.lang.String weatherDate ,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, Model model)
            throws Exception {
        FarmWeatherVO farmWeatherVO = new FarmWeatherVO();
        farmWeatherVO.setMbrId(mbrId);
        farmWeatherVO.setWeatherDate(weatherDate);
        // 변수명은 CoC 에 따라 farmWeatherVO
        model.addAttribute(selectFarmWeather(farmWeatherVO, searchVO));
        return "/farmWeather/FarmWeatherRegister";
    }

    @RequestMapping("/farmWeather/selectFarmWeather.do")
    public @ModelAttribute("farmWeatherVO")
    FarmWeatherVO selectFarmWeather(
            FarmWeatherVO farmWeatherVO,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO) throws Exception {
        return farmWeatherService.selectFarmWeather(farmWeatherVO);
    }

    @RequestMapping("/farmWeather/updateFarmWeather.do")
    public String updateFarmWeather(
            FarmWeatherVO farmWeatherVO,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, SessionStatus status)
            throws Exception {
        farmWeatherService.updateFarmWeather(farmWeatherVO);
        status.setComplete();
        return "forward:/farmWeather/FarmWeatherList.do";
    }
    
    @RequestMapping("/farmWeather/deleteFarmWeather.do")
    public String deleteFarmWeather(
            FarmWeatherVO farmWeatherVO,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, SessionStatus status)
            throws Exception {
        farmWeatherService.deleteFarmWeather(farmWeatherVO);
        status.setComplete();
        return "forward:/farmWeather/FarmWeatherList.do";
    }
    
    
    @RequestMapping("/farmWeather/procedureWeather.do")
    public String procedureWeather(
            FarmWeatherVO farmWeatherVO,
            @ModelAttribute("searchVO") FarmWeatherDefaultVO searchVO, SessionStatus status)
            throws Exception {
        farmWeatherService.procedureWeather(farmWeatherVO);
        status.setComplete();
        return "redirect:/farmingDiary/monthList.do";
    }

}
