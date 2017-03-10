package egovframework.farm.cpr.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.farm.cpr.service.CprDefaultVO;
import egovframework.farm.cpr.service.CprService;
import egovframework.farm.cpr.service.CprVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : CprController.java
 * @Description : Cpr Controller class
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
@SessionAttributes(types=CprVO.class)
public class CprController {

    @Resource(name = "cprService")
    private CprService cprService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * CPR 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 CprDefaultVO
	 * @return "/cpr/CprList"
	 * @exception Exception
	 */
//    @RequestMapping(value="/cpr/CprList.do")
//    public String selectCprList(@ModelAttribute("searchVO") CprDefaultVO searchVO, 
//    		ModelMap model)
//            throws Exception {
//    	
//    	/** EgovPropertyService.sample */
//    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
//    	
//    	/** pageing */
//    	PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		
//        List<?> cprList = cprService.selectCprList(searchVO);
//        model.addAttribute("resultList", cprList);
//        
//        int totCnt = cprService.selectCprListTotCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//        model.addAttribute("paginationInfo", paginationInfo);
//        
//        return "/cpr/CprList";
//    } 
    
    @RequestMapping("/cpr/addCprView.do")
    public String addCprView(
            @ModelAttribute("searchVO") CprDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("cprVO", new CprVO());
        return "/cpr/CprRegister";
    }
    
    @RequestMapping("/cpr/addCpr.do")
    public String addCpr(
            CprVO cprVO,
            @ModelAttribute("searchVO") CprDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cprService.insertCpr(cprVO);
        status.setComplete();
        return "forward:/cpr/CprList.do";
    }
    
    @RequestMapping("/cpr/updateCprView.do")
    public String updateCprView(
            @RequestParam("cprCd") java.lang.String cprCd ,
            @ModelAttribute("searchVO") CprDefaultVO searchVO, Model model)
            throws Exception {
        CprVO cprVO = new CprVO();
        cprVO.setCprCd(cprCd);
        // 변수명은 CoC 에 따라 cprVO
        model.addAttribute(selectCpr(cprVO, searchVO));
        return "/cpr/CprRegister";
    }

    @RequestMapping("/cpr/selectCpr.do")
    public @ModelAttribute("cprVO")
    CprVO selectCpr(
            CprVO cprVO,
            @ModelAttribute("searchVO") CprDefaultVO searchVO) throws Exception {
        return cprService.selectCpr(cprVO);
    }

    @RequestMapping("/cpr/updateCpr.do")
    public String updateCpr(
            CprVO cprVO,
            @ModelAttribute("searchVO") CprDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cprService.updateCpr(cprVO);
        status.setComplete();
        return "forward:/cpr/CprList.do";
    }
    
    @RequestMapping("/cpr/deleteCpr.do")
    public String deleteCpr(
            CprVO cprVO,
            @ModelAttribute("searchVO") CprDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cprService.deleteCpr(cprVO);
        status.setComplete();
        return "forward:/cpr/CprList.do";
    }
    @RequestMapping(value="/cpr/CprSelect.do")
    public String selectMRKT(@ModelAttribute("searchVO") CprDefaultVO searchVO, ModelMap model) throws Exception {  
    	List<?> selectMRKTList = cprService.selectMRKT(searchVO);
        model.addAttribute("MRKTList", selectMRKTList);
        return "/cpr/CprSelect";
    }
    @RequestMapping(value="/cpr/CprSelectForSell.do")
    public String selectMRKTForSell(@ModelAttribute("searchVO") CprDefaultVO searchVO, ModelMap model) throws Exception {  
    	List<?> selectMRKTList = cprService.selectMRKT(searchVO);
        model.addAttribute("MRKTList", selectMRKTList);
        return "/cpr/CprSelectForSell";
    }
    @RequestMapping(value="/cpr/CprSelectSub.do")
    @ResponseBody
    public void selectCPR(CprVO cprVO,
    					  ModelMap model,
    					  HttpServletResponse response) throws Exception {  
    	//return cprService.selectCPR(cprVO);
    
	    List<?> result = cprService.selectCPR(cprVO);
	    //System.out.println(result.get(0));
	    response.setCharacterEncoding("utf-8");
		response.getWriter().print(result);
    }


}
