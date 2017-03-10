package egovframework.farm.basic.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.farm.crop.service.CropsDefaultVO;
import egovframework.farm.crop.service.CropsService;
import egovframework.farm.equ.service.EquipmentUseDefaultVO;
import egovframework.farm.equ.service.impl.EquipmentUseService;
import egovframework.farm.fmd.service.FarmingDiaryDefaultVO;
import egovframework.farm.fmd.service.FarmingDiaryService;
import egovframework.farm.job.service.JobProcessVO;
import egovframework.farm.mbr.service.MbrService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.farm.sell.service.SellListDefaultVO;
import egovframework.farm.sell.service.SellListService;
import egovframework.farm.wtf.service.FarmWeatherDefaultVO;
import egovframework.farm.wtf.service.FarmWeatherService;
import egovframework.farm.wtf.service.FarmWeatherVO;
import egovframework.rte.fdl.property.EgovPropertyService;

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
public class BasicInfoController {
	
	@Resource(name = "cropsService")
    private CropsService cropsService;
	@Resource(name = "mbrService")
    private MbrService mbrService;
	@Resource(name = "equipmentUseService")
	private EquipmentUseService equipmentUseService;
	@Resource(name = "farmingDiaryService")
    private FarmingDiaryService farmingDiaryService;
    @Resource(name = "farmWeatherService")
    private FarmWeatherService farmWeatherService;
    @Resource(name = "sellListService")
    private SellListService sellListService;
    
    
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	   
    @RequestMapping("/basicinfo/BasicInfo.do")
    public String selectBasicInfo()
            {
        return "/basicinfo/BasicInfo";
    }
    
    @RequestMapping("/basicinfo/totalInfo.do")
    public String totalInfo(ModelMap model,
    						CropsDefaultVO searchCropVO,
    						EquipmentUseDefaultVO searchEquVO,
    						FarmingDiaryDefaultVO searchFmdVO,
    						SellListDefaultVO searchSellVO,
    						FarmWeatherDefaultVO searchFwtVO, FarmWeatherVO farmWeatherVO,
    						HttpSession session,
    						HttpServletRequest request
    						) throws Exception{
    	String user = ((MbrVO)session.getAttribute("loginInfo")).getMbrId();
    	searchCropVO.setSearchKeyword(user);
    	searchEquVO.setMbrId(user);
    	searchFmdVO.setSearchKeyword(user);
    	searchSellVO.setMbrId(user);
    	farmWeatherVO.setMbrId(user);
    	/*---------------------------------------------------------------------------------------------------*/
    	/*----------------------------날씨 정보 가져오기-----------------------------------------------------*/
    	/*---------------------------------------------------------------------------------------------------*/
    	FarmWeatherVO fwtVO = farmWeatherService.selectFarmWeather(farmWeatherVO);
    	HashMap<String,String> weatherCode = new HashMap<String,String>();
    	weatherCode.put("SKY_O00","38.png");
    	weatherCode.put("SKY_O01","01.png");
    	weatherCode.put("SKY_O02","02.png");
    	weatherCode.put("SKY_O03","03.png");
    	weatherCode.put("SKY_O04","12.png");
    	weatherCode.put("SKY_O05","13.png");
    	weatherCode.put("SKY_O06","14.png");
    	weatherCode.put("SKY_O07","18.png");
    	weatherCode.put("SKY_O08","12.png");
    	weatherCode.put("SKY_O09","32.png");
    	weatherCode.put("SKY_O10","04.png");
    	weatherCode.put("SKY_O11","29.png");
    	weatherCode.put("SKY_O12","26.png");
    	weatherCode.put("SKY_O13","27.png");
    	weatherCode.put("SKY_O14","28.png");
    	String wstat = weatherCode.get(fwtVO.getWeatherStatus()); 
    	model.addAttribute("weather",fwtVO);
    	model.addAttribute("weatherStatus",wstat);
    	
    	/*---------------------------------------------------------------------------------------------------*/
    	/*----------------------------판매 정보 가져오기-----------------------------------------------------*/
    	/*---------------------------------------------------------------------------------------------------*/
    	
    	searchSellVO.setFirstIndex(1);
    	searchSellVO.setLastIndex(6);
    	searchSellVO.setSellDateMax(request.getParameter("weatherDate"));
    	searchSellVO.setSellDateMin(request.getParameter("weatherDate"));
    	List<?> sellListList = sellListService.selectSellListList(searchSellVO);
    	List<?> select3day = sellListService.sellList3day(searchSellVO);
    	model.addAttribute("sellListList", sellListList);
        model.addAttribute("select3day", select3day);
        
        /*---------------------------------------------------------------------------------------------------*/
    	/*----------------------------장비 정보 가져오기-----------------------------------------------------*/
    	/*---------------------------------------------------------------------------------------------------*/
       
        searchEquVO.setEquDate(request.getParameter("weatherDate"));
        List<?> sumEquList = equipmentUseService.selectEquipmentUseSum(searchEquVO); 
        model.addAttribute("sumEquList1", sumEquList.get(0));
        model.addAttribute("sumEquList2", sumEquList.get(1));
        model.addAttribute("sumEquList3", sumEquList.get(2));
        model.addAttribute("sumEquList4", sumEquList.get(3));
        /*---------------------------------------------------------------------------------------------------*/
    	/*----------------------------일지 정보 가져오기-----------------------------------------------------*/
    	/*---------------------------------------------------------------------------------------------------*/
        
        return "/basicinfo/totalInfo";
    }

}
