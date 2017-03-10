package egovframework.farm.sell.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.com.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.farm.sell.service.SellListDefaultVO;
import egovframework.farm.sell.service.SellListService;
import egovframework.farm.sell.service.SellListVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SellListController.java
 * @Description : SellList Controller class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=SellListVO.class)
public class SellListController {

    @Resource(name = "sellListService")
    private SellListService sellListService;
    
    @Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * SELL_LIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SellListDefaultVO
	 * @return "/sellList/SellListList"
	 * @exception Exception
	 */
    @RequestMapping(value="/sellList/SellListList.do")
    public String selectSellListList(@ModelAttribute("searchVO") SellListDefaultVO searchVO, 
    		HttpServletRequest request,ModelMap model,HttpSession session)
            throws Exception {
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setMbrId(((MbrVO)session.getAttribute("loginInfo")).getMbrId());
        List<?> sellListList = sellListService.selectSellListList(searchVO);
        model.addAttribute("resultList", sellListList);
        System.out.println(searchVO);
        int totCnt = sellListService.selectSellListListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        /* 단위코드조회 */
        CmmnDetailCodeVO codeVO1 = new CmmnDetailCodeVO();
    	codeVO1.setSearchCondition("1");
    	codeVO1.setSearchKeyword("0I");
    	model.addAttribute("UnitList", 
    			cmmnDetailCodeManageService.selectCmmnDetailCodeList(codeVO1));
    	
    	/* top5 정보 가져옴 */
    	List<?> top5List = sellListService.sellListTop5(searchVO);
    	model.addAttribute("top5",top5List);
    	
    	/* 지난주 정보 가져옴 */
    	Map<?,?> week = sellListService.weekStat(searchVO);
    	model.addAttribute("sun",week.get("sun"));
    	model.addAttribute("mon",week.get("mon"));
    	model.addAttribute("tus",week.get("tus"));
    	model.addAttribute("wed",week.get("wed"));
    	model.addAttribute("thr",week.get("thr"));
    	model.addAttribute("fri",week.get("fri"));
    	model.addAttribute("sat",week.get("sat"));
    	
        return "/sellList/SellListList";
    } 
    
    @RequestMapping("/sellList/addSellListView.do")
    public String addSellListView(
            @ModelAttribute("searchVO") SellListDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("sellListVO", new SellListVO());
        return "/sellList/SellListRegister";
    }
    
    @RequestMapping("/sellList/addSellList.do")
    public String addSellList(
            SellListVO sellListVO,
            @ModelAttribute("searchVO") SellListDefaultVO searchVO, SessionStatus status)
            throws Exception {
        sellListService.insertSellList(sellListVO);
        status.setComplete();
        return "redirect:/sellList/SellListList.do";
    }
    
    @RequestMapping("/sellList/updateSellListView.do")
    public String updateSellListView(
            @RequestParam("sellCode") java.math.BigDecimal sellCode ,
            @ModelAttribute("searchVO") SellListDefaultVO searchVO, Model model)
            throws Exception {
        SellListVO sellListVO = new SellListVO();
        sellListVO.setSellCode(sellCode);
        // 변수명은 CoC 에 따라 sellListVO
        model.addAttribute(selectSellList(sellListVO, searchVO));
        return "/sellList/SellListRegister";
    }

    @RequestMapping("/sellList/selectSellList.do")
    public @ModelAttribute("sellListVO")
    SellListVO selectSellList(
            SellListVO sellListVO,
            @ModelAttribute("searchVO") SellListDefaultVO searchVO) throws Exception {
        return sellListService.selectSellList(sellListVO);
    }

    @RequestMapping("/sellList/updateSellList.do")
    public String updateSellList(
            SellListVO sellListVO,
            @ModelAttribute("searchVO") SellListDefaultVO searchVO, SessionStatus status)
            throws Exception {
        sellListService.updateSellList(sellListVO);
        status.setComplete();
        return "forward:/sellList/SellListList.do";
    }
    
    @RequestMapping("/sellList/deleteSellList.do")
    public String deleteSellList(
            SellListVO sellListVO,
            @ModelAttribute("searchVO") SellListDefaultVO searchVO, SessionStatus status,
            HttpSession session)      
            throws Exception {
        sellListService.deleteSellList(sellListVO);
        
        status.setComplete();
        return "redirect:/sellList/SellListList.do";
    }
    
    @RequestMapping("/sellList/sellInfo.do")
    public String sellInfo(){
    	return "sellList/sellInfo";
    }
}
