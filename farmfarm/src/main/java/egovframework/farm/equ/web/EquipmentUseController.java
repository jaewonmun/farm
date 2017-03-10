package egovframework.farm.equ.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
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
import egovframework.farm.eq.service.EquipmentDefaultVO;
import egovframework.farm.eq.service.EquipmentService;
import egovframework.farm.equ.service.EquipmentUseDefaultVO;
import egovframework.farm.equ.service.EquipmentUseVO;
import egovframework.farm.equ.service.impl.EquipmentUseService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EquipmentUseController.java
 * @Description : EquipmentUse Controller class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=EquipmentUseVO.class)
public class EquipmentUseController {

	@Resource(name = "equipmentUseService")
	private EquipmentUseService equipmentUseService;
	@Resource(name = "equipmentService")
	private EquipmentService equipmentService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * EQUIPMENT_USE 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 EquipmentUseDefaultVO
	 * @return "/equipmentUse/EquipmentUseList"
	 * @exception Exception
	 */
    @Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
    
	@RequestMapping(value="/equipmentUse/EquipmentUseList.do")
	public String selectEquipmentUseList(@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, 
			ModelMap model, 
			HttpServletRequest request,
			HttpSession session,
			EquipmentDefaultVO equipmentDefaultVO)
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
		//searchVO.setMbrId((String) request.getSession().getAttribute("loginInfo.mbrId"));
		searchVO.setMbrId(((MbrVO)session.getAttribute("loginInfo")).getMbrId());
		searchVO.setSearchKeyword("0BB1");	// 농약
		List<?> equipmentUseList1 = equipmentUseService.selectEquipmentUseList(searchVO);
		model.addAttribute("resultList1", equipmentUseList1);
		
		int totCnt = equipmentUseService.selectEquipmentUseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo1",paginationInfo);
		
		PaginationInfo paginationInfo2 = new PaginationInfo();
		paginationInfo2.setCurrentPageNo(searchVO.getPageIndex2());
		paginationInfo2.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo2.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo2.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo2.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo2.getRecordCountPerPage());
		//searchVO.setMbrId((String) request.getSession().getAttribute("loginInfo.mbrId"));
		
		searchVO.setSearchKeyword("0BB2");	// 비료
		List<?> equipmentUseList2 = equipmentUseService.selectEquipmentUseList(searchVO);
		model.addAttribute("resultList2", equipmentUseList2);

		int totCnt2 = equipmentUseService.selectEquipmentUseListTotCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		model.addAttribute("paginationInfo2",paginationInfo2);
		
		PaginationInfo paginationInfo3 = new PaginationInfo();
		paginationInfo3.setCurrentPageNo(searchVO.getPageIndex3());
		paginationInfo3.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo3.setPageSize(searchVO.getPageSize());
		
		
		searchVO.setSearchKeyword("0BB3");	// 인력
		List<?> equipmentUseList3 = equipmentUseService.selectEquipmentUseList(searchVO);
		model.addAttribute("resultList3", equipmentUseList3);

		int totCnt3 = equipmentUseService.selectEquipmentUseListTotCnt(searchVO);
		paginationInfo3.setTotalRecordCount(totCnt3);
		model.addAttribute("paginationInfo3",paginationInfo3);
		
		searchVO.setFirstIndex(paginationInfo3.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo3.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo3.getRecordCountPerPage());
		//searchVO.setMbrId((String) request.getSession().getAttribute("loginInfo.mbrId"));
		
		PaginationInfo paginationInfo4 = new PaginationInfo();
		paginationInfo4.setCurrentPageNo(searchVO.getPageIndex4());
		paginationInfo4.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo4.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo4.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo4.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo4.getRecordCountPerPage());
		//searchVO.setMbrId((String) request.getSession().getAttribute("loginInfo.mbrId"));
		
		searchVO.setSearchKeyword("0BB4");	// 장비
		List<?> equipmentUseList4 = equipmentUseService.selectEquipmentUseList(searchVO);
		model.addAttribute("resultList4", equipmentUseList4);
		
		int totCnt4 = equipmentUseService.selectEquipmentUseListTotCnt(searchVO);
		paginationInfo4.setTotalRecordCount(totCnt4);
		model.addAttribute("paginationInfo4",paginationInfo4);
        /* 단위코드조회 */
        CmmnDetailCodeVO codeVO1 = new CmmnDetailCodeVO();
    	codeVO1.setSearchCondition("1");
    	codeVO1.setSearchKeyword("0G");
    	model.addAttribute("UnitList", 
    			cmmnDetailCodeManageService.selectCmmnDetailCodeList(codeVO1));

		/* 장비공통코드    */
		codeVO1.setSearchCondition("1");
		codeVO1.setSearchKeyword("0B");
		model.addAttribute("categoryList", 
				cmmnDetailCodeManageService.selectCmmnDetailCodeList(codeVO1));
    	
    	/* 사용자별 등록장비조회 (list값을 json으로 변경)*/
    	ObjectMapper mapper = new ObjectMapper();
    	equipmentDefaultVO.setMbrId(((MbrVO)session.getAttribute("loginInfo")).getMbrId());
    	model.addAttribute("equipcomboList", mapper.writeValueAsString(equipmentService.comboEquipmentList(equipmentDefaultVO)));  			

    	/* 사용자별 사용내역 */
    	model.addAttribute("EquipmentUseList");

		return "/equipmentUse/EquipmentUseList";
	} 

	@RequestMapping("/equipmentUse/addEquipmentUseView.do")
	public String addEquipmentUseView(
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, Model model)
					throws Exception {
		model.addAttribute("equipmentUseVO", new EquipmentUseVO());
		return "/equipmentUse/EquipmentUseRegister";
	}

	@RequestMapping("/equipmentUse/addEquipmentUse.do")
	public String addEquipmentUse(
			EquipmentUseVO equipmentUseVO,
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentUseService.insertEquipmentUse(equipmentUseVO);
		status.setComplete();
		return "redirect:/equipmentUse/EquipmentUseList.do";
	}

	@RequestMapping("/equipmentUse/updateEquipmentUseView.do")
	public String updateEquipmentUseView(
			@RequestParam("equipmentUsePk") java.math.BigDecimal equipmentUsePk ,
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, Model model)
					throws Exception {
		EquipmentUseVO equipmentUseVO = new EquipmentUseVO();
		equipmentUseVO.setEquipmentUsePk(equipmentUsePk);
		
		// 변수명은 CoC 에 따라 equipmentUseVO
		model.addAttribute(selectEquipmentUse(equipmentUseVO, searchVO));
		return "/equipmentUse/EquipmentUseRegister";
	}

	@RequestMapping("/equipmentUse/selectEquipmentUse.do")
	public @ModelAttribute("equipmentUseVO")
	EquipmentUseVO selectEquipmentUse(
			EquipmentUseVO equipmentUseVO,
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO) throws Exception {
		return equipmentUseService.selectEquipmentUse(equipmentUseVO);
	}

	@RequestMapping("/equipmentUse/updateEquipmentUse.do")
	public String updateEquipmentUse(
			EquipmentUseVO equipmentUseVO,
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentUseService.updateEquipmentUse(equipmentUseVO);
		status.setComplete();
		return "redirect:/equipmentUse/EquipmentUseList.do";
	}

	@RequestMapping("/equipmentUse/deleteEquipmentUse.do")
	public String deleteEquipmentUse(
			EquipmentUseVO equipmentUseVO,
			@ModelAttribute("searchVO") EquipmentUseDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentUseService.deleteEquipmentUse(equipmentUseVO);
		status.setComplete();
		return "redirect:/equipmentUse/EquipmentUseList.do";
	}

}
