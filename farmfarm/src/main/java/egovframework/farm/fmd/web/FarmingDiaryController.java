package egovframework.farm.fmd.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.farm.fmd.service.FarmingDiaryDefaultVO;
import egovframework.farm.fmd.service.FarmingDiaryService;
import egovframework.farm.fmd.service.FarmingDiaryVO;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.farm.wtf.service.FarmWeatherService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : FarmingDiaryController.java
 * @Description : FarmingDiary Controller class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=FarmingDiaryVO.class)
public class FarmingDiaryController {

    @Resource(name = "farmingDiaryService")
    private FarmingDiaryService farmingDiaryService;
    
    @Resource(name = "farmWeatherService")
    private FarmWeatherService farmWeatherService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	/*
    *//**
	 * FARMING_DIARY 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 FarmingDiaryDefaultVO
	 * @return "/farmingDiary/FarmingDiaryList"
	 * @exception Exception
	 *//*
    @RequestMapping(value="/farmingDiary/FarmingDiaryList.do")
    public String selectFarmingDiaryList(@ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, 
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
		
        List<?> farmingDiaryList = farmingDiaryService.selectFarmingDiaryList(searchVO);
        model.addAttribute("resultList", farmingDiaryList);
        
        int totCnt = farmingDiaryService.selectFarmingDiaryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/farmingDiary/FarmingDiaryList";
    } */
    
/*    @RequestMapping("/farmingDiary/addFarmingDiaryView.do")
    public String addFarmingDiaryView(
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("farmingDiaryVO", new FarmingDiaryVO());
        return "/farmingDiary/FarmingDiaryRegister";
    }*/
    
 /*   
    @RequestMapping("/farmingDiary/ok2cal.do")
    public String ok2cal(
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("ok2cal", new FarmingDiaryVO());
        return "/farmingDiary/ok2cal";
    }*/
    
    @RequestMapping("/farmingDiary/addFarmingDiary.do")
    public String addFarmingDiary(
            FarmingDiaryVO farmingDiaryVO,
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, SessionStatus status,
            HttpServletRequest request)
            throws Exception {
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		// 첨부파일 읽기
		MultipartFile uploadFile = multipartRequest.getFile("diaryUploadFileTEMP");
		// Blob 필드에 넣을경우
		//vo.setImgData(uploadFile.getBytes());
		// VO에 멀티파트 필드가 있으면
		//MultipartFile uploadFile = vo.getUploadFile();
		String dir_path = request.getSession().getServletContext().getRealPath("/images/makeImage/diaryImage");
		if(!uploadFile.isEmpty() && uploadFile.getSize() >0) {
			System.out.println("---------------------------------------------------------------"+uploadFile.getSize());
			System.out.println(dir_path);
			String timestamp = String.valueOf(System.currentTimeMillis());	// 파일 이름을 유니크하게 하기 위함
			String fileName = uploadFile.getOriginalFilename();
			uploadFile.transferTo(new File(dir_path,timestamp + fileName));
			farmingDiaryVO.setDiaryUploadFileOriginal(timestamp + fileName);
			// 같은 파일이 있으면 rename	이부분은 없음 검색해볼것
			farmingDiaryVO.setDiaryUploadFile(dir_path +"\\" + timestamp + fileName );
		}
        farmingDiaryService.insertFarmingDiary(farmingDiaryVO);
        status.setComplete();
        return "redirect:/farmingDiary/monthList.do";
    }
    
/*    @RequestMapping("/farmingDiary/updateFarmingDiaryView.do")
    public String updateFarmingDiaryView(
            @RequestParam("farmingDiarySeq") java.math.BigDecimal farmingDiarySeq ,
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, Model model)
            throws Exception {
        FarmingDiaryVO farmingDiaryVO = new FarmingDiaryVO();
        farmingDiaryVO.setFarmingDiarySeq(farmingDiarySeq);
        // 변수명은 CoC 에 따라 farmingDiaryVO
        model.addAttribute(selectFarmingDiary(farmingDiaryVO, searchVO));
        return "/farmingDiary/FarmingDiaryRegister";
    }*/

    @RequestMapping("/farmingDiary/selectFarmingDiary.do")
    public @ModelAttribute("farmingDiaryVO")
    FarmingDiaryVO selectFarmingDiary(
            FarmingDiaryVO farmingDiaryVO,
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO) throws Exception {
        return farmingDiaryService.selectFarmingDiary(farmingDiaryVO);
    }

    @RequestMapping("/farmingDiary/selectFarmingDiaryListForMain.do")
    @ResponseBody
    public List<?> selectFarmingDiaryListForMain(
            FarmingDiaryVO farmingDiaryVO) throws Exception {
        return farmingDiaryService.selectFarmingDiaryListForMain(farmingDiaryVO);
    }
    
    @RequestMapping("/farmingDiary/updateFarmingDiary.do")
    public String updateFarmingDiary(
            FarmingDiaryVO farmingDiaryVO,
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, SessionStatus status,
            HttpServletRequest request)
            throws Exception {
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		// 첨부파일 읽기
		MultipartFile uploadFile = multipartRequest.getFile("diaryUploadFileTEMP");
		// Blob 필드에 넣을경우
		//vo.setImgData(uploadFile.getBytes());
		// VO에 멀티파트 필드가 있으면
		//MultipartFile uploadFile = vo.getUploadFile();
		String dir_path = request.getSession().getServletContext().getRealPath("/images/makeImage/diaryImage");
		if(!uploadFile.isEmpty() && uploadFile.getSize() >0) {
			System.out.println(uploadFile.getSize());
			System.out.println(dir_path);
			String timestamp = String.valueOf(System.currentTimeMillis());	// 파일 이름을 유니크하게 하기 위함
			String fileName = uploadFile.getOriginalFilename();
			uploadFile.transferTo(new File(dir_path,timestamp + fileName));
			farmingDiaryVO.setDiaryUploadFileOriginal(timestamp + fileName);
			// 같은 파일이 있으면 rename	이부분은 없음 검색해볼것
			farmingDiaryVO.setDiaryUploadFile(dir_path +"\\" + timestamp + fileName );
		}
        farmingDiaryService.updateFarmingDiary(farmingDiaryVO);
        status.setComplete();
        return "redirect:/farmingDiary/monthList.do";
    }
    
    @RequestMapping("/farmingDiary/deleteFarmingDiary.do")
    public String deleteFarmingDiary(
            FarmingDiaryVO farmingDiaryVO,
            @ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, SessionStatus status)
            throws Exception {
        farmingDiaryService.deleteFarmingDiary(farmingDiaryVO);
        status.setComplete();
        return "redirect:/farmingDiary/monthList.do";
    }
/*    @RequestMapping("/farmingDiary/calendar.do")
    public String calendar(HttpServletRequest request,HttpServletResponse response) throws IOException{
    	String date = request.getParameter("date");
    	request.setAttribute("date", date);
    	return "/farmingDiary/calendar";
    }*/
    
    /**
	 * 일정(월별) 목록을 조회한다.
	 * @param commandMap
	 * @param FarmingDiaryDefaultVO
	 * @param model
	 * @return "farmingDiary/monthList"
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unused" })
	@RequestMapping("/farmingDiary/monthList.do")
	public String monthList(
			@RequestParam Map<String, String> commandMap,
			@ModelAttribute("searchVO") FarmingDiaryDefaultVO searchVO, 
    		ModelMap model, HttpSession session)
    throws Exception {
		//일정구분 검색 유지
//        model.addAttribute("searchKeyword", commandMap.get("searchKeyword") == null ? "" : (String)commandMap.get("searchKeyword"));
//        model.addAttribute("searchCondition", commandMap.get("searchCondition") == null ? "" : (String)commandMap.get("searchCondition"));
        commandMap.put("mbrId",((MbrVO)session.getAttribute("loginInfo")).getMbrId());
		java.util.Calendar cal = java.util.Calendar.getInstance();

		String sYear = commandMap.get("year");
		String sMonth = commandMap.get("month");

		int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		int iDate = cal.get(java.util.Calendar.DATE);

                //검색 설정
                String sSearchDate = "";
                if(sYear == null || sMonth == null){
                        sSearchDate += Integer.toString(iYear);
                        sSearchDate += Integer.toString(iMonth+1).length() == 1 ? "0" + Integer.toString(iMonth+1) : Integer.toString(iMonth+1);
                }else{
                        iYear = Integer.parseInt(sYear);
                        iMonth = Integer.parseInt(sMonth);
                        sSearchDate += sYear;
                        sSearchDate += Integer.toString(iMonth+1).length() == 1 ? "0" + Integer.toString(iMonth+1) :Integer.toString(iMonth+1);
                }

    	commandMap.put("searchMonth", sSearchDate);
    	commandMap.put("searchMode", "MONTH");
    	List resultWeather = farmWeatherService.selectFarmWeatherList(commandMap);
        List resultList = farmingDiaryService.selectFarmingDiaryList(commandMap);
        model.addAttribute("resultWeather",resultWeather);
        model.addAttribute("resultList", resultList);

		return "farmingDiary/monthList";
	}
    
}
