package egovframework.farm.eq.web;

import java.util.List;

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
import egovframework.farm.eq.service.EquipmentDefaultVO;
import egovframework.farm.eq.service.EquipmentService;
import egovframework.farm.eq.service.EquipmentVO;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EquipmentController.java
 * @Description : Equipment Controller class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161123
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=EquipmentVO.class)
public class EquipmentController {

	@Resource(name = "equipmentService")
	private EquipmentService equipmentService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * EQUIPMENT 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 EquipmentDefaultVO
	 * @return "/equipment/EquipmentList"
	 * @exception Exception
	 */

	@Resource(name = "CmmnDetailCodeManageService")
	private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

	@RequestMapping(value="/equipment/EquipmentList.do")
	public String selectEquipmentList(HttpServletRequest request,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO,
			HttpSession session,
			ModelMap model)
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
		
		searchVO.setCategory("0BB1");	// 농약
		searchVO.setMbrId(((MbrVO)session.getAttribute("loginInfo")).getMbrId());
		List<?> equipmentList1 = equipmentService.selectEquipmentList(searchVO);
		model.addAttribute("resultList1", equipmentList1);
		
		int totCnt = equipmentService.selectEquipmentListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo1", paginationInfo);
		
		PaginationInfo paginationInfo2 = new PaginationInfo();
		paginationInfo2.setCurrentPageNo(searchVO.getPageIndex2());
		paginationInfo2.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo2.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo2.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo2.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo2.getRecordCountPerPage());
		
		searchVO.setCategory("0BB2");	// 비료
		List<?> equipmentList2 = equipmentService.selectEquipmentList(searchVO);
		model.addAttribute("resultList2", equipmentList2);

		int totCnt2 = equipmentService.selectEquipmentListTotCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		model.addAttribute("paginationInfo2", paginationInfo2);
		
		PaginationInfo paginationInfo3 = new PaginationInfo();
		paginationInfo3.setCurrentPageNo(searchVO.getPageIndex3());
		paginationInfo3.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo3.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo3.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo3.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo3.getRecordCountPerPage());

		searchVO.setCategory("0BB3");	// 인력
		List<?> equipmentList3 = equipmentService.selectEquipmentList(searchVO);
		model.addAttribute("resultList3", equipmentList3);

		int totCnt3 = equipmentService.selectEquipmentListTotCnt(searchVO);
		paginationInfo3.setTotalRecordCount(totCnt3);
		model.addAttribute("paginationInfo3", paginationInfo3);
		
		PaginationInfo paginationInfo4 = new PaginationInfo();
		paginationInfo4.setCurrentPageNo(searchVO.getPageIndex4());
		paginationInfo4.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo4.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo4.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo4.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo4.getRecordCountPerPage());
				
		searchVO.setCategory("0BB4");	// 장비	
		List<?> equipmentList4 = equipmentService.selectEquipmentList(searchVO);
		model.addAttribute("resultList4", equipmentList4);	

		int totCnt4 = equipmentService.selectEquipmentListTotCnt(searchVO);
		paginationInfo4.setTotalRecordCount(totCnt4);
		model.addAttribute("paginationInfo4", paginationInfo4);
		
		// 애러때문에 잠시 주석처리
		/*CmmnDetailCodeVO codeVO1 = new CmmnDetailCodeVO();

		 장비공통코드 
		codeVO1.setSearchCondition("1");
		codeVO1.setSearchKeyword("0B");
		model.addAttribute("categoryList", 
				cmmnDetailCodeManageService.selectCmmnDetailCodeList(codeVO1));
*/
		return "/equipment/EquipmentList";
	} 

	@RequestMapping("/equipment/addEquipmentView.do")
	public String addEquipmentView(
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO, Model model)
					throws Exception {
		model.addAttribute("equipmentVO", new EquipmentVO());
		return "/equipment/EquipmentRegister";
	}

	@RequestMapping("/equipment/addEquipment.do")
	public String addEquipment(
			EquipmentVO equipmentVO,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentService.insertEquipment(equipmentVO);
		status.setComplete();
		return "redirect:/equipment/EquipmentList.do";
	}

	@RequestMapping("/equipment/updateEquipmentView.do")
	public String updateEquipmentView(
			@RequestParam("equipmentId") java.lang.String equipmentId ,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO, Model model)
					throws Exception {
		EquipmentVO equipmentVO = new EquipmentVO();
		equipmentVO.setEquipmentId(equipmentId);
		// 변수명은 CoC 에 따라 equipmentVO
		model.addAttribute(selectEquipment(equipmentVO, searchVO));
		return "/equipment/EquipmentRegister";
	}

	@RequestMapping("/equipment/selectEquipment.do")
	public @ModelAttribute("equipmentVO")
	EquipmentVO selectEquipment(
			EquipmentVO equipmentVO,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO) throws Exception {
		return equipmentService.selectEquipment(equipmentVO);
	}

	@RequestMapping("/equipment/updateEquipment.do")
	public String updateEquipment(
			EquipmentVO equipmentVO,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentService.updateEquipment(equipmentVO);
		status.setComplete();
		return "redirect:/equipment/EquipmentList.do";
	}

	@RequestMapping("/equipment/deleteEquipment.do")
	public String deleteEquipment(
			EquipmentVO equipmentVO,
			@ModelAttribute("searchVO") EquipmentDefaultVO searchVO, SessionStatus status)
					throws Exception {
		equipmentService.deleteEquipment(equipmentVO);
		status.setComplete();
		return "redirect:/equipment/EquipmentList.do";
	}

}
