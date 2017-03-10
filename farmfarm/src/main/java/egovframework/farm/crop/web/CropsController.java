package egovframework.farm.crop.web;

import java.io.File;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;

import org.apache.tiles.request.Request;
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

import egovframework.farm.crop.service.CropsDefaultVO;
import egovframework.farm.crop.service.CropsService;
import egovframework.farm.crop.service.CropsVO;
import egovframework.farm.equ.service.impl.EquipmentUseService;
import egovframework.farm.fmd.service.FarmingDiaryService;
import egovframework.farm.mbr.service.MbrService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.farm.sell.service.SellListService;
import egovframework.farm.wtf.service.FarmWeatherService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : CropsController.java
 * @Description : Crops Controller class
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
@SessionAttributes(types=CropsVO.class)
public class CropsController {

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
	
    /**
	 * CROPS 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 CropsDefaultVO
	 * @return "/crops/CropsList"
	 * @exception Exception
	 */
    @RequestMapping(value="/crops/CropsList.do")
    public String selectCropsList(@ModelAttribute("searchVO") CropsDefaultVO searchVO, 
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
		
        List<?> cropsList = cropsService.selectCropsList(searchVO);
        model.addAttribute("resultList", cropsList);
        
        int totCnt = cropsService.selectCropsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/crops/CropsList";
    } 
    
    @RequestMapping("/crops/addCropsView.do")
    public String addCropsView(
            @ModelAttribute("searchVO") CropsDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("cropsVO", new CropsVO());
        return "/crops/CropsRegister";
    }
    
    @RequestMapping("/crops/addCrops.do")
    public String addCrops(CropsVO cropsVO,@ModelAttribute("searchVO") CropsDefaultVO searchVO, SessionStatus status, HttpServletRequest request) throws Exception {
    	// request를 multipart로 변환
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		// 첨부파일 읽기
		MultipartFile uploadFile = multipartRequest.getFile("uploadImageTEMP");
		// Blob 필드에 넣을경우
		//vo.setImgData(uploadFile.getBytes());
		// VO에 멀티파트 필드가 있으면
		//MultipartFile uploadFile = vo.getUploadFile();
		String dir_path = request.getSession().getServletContext().getRealPath("/images/makeImage/crops");
		if(!uploadFile.isEmpty() && uploadFile.getSize() >0) {
			System.out.println(uploadFile.getSize());
			System.out.println(dir_path);
			String timestamp = String.valueOf(System.currentTimeMillis());	// 파일 이름을 유니크하게 하기 위함
			String fileName = uploadFile.getOriginalFilename();
			uploadFile.transferTo(new File(dir_path,timestamp + fileName));
			cropsVO.setUploadImageOriginal(timestamp + fileName);
			// 같은 파일이 있으면 rename	이부분은 없음 검색해볼것
			cropsVO.setUploadImage(dir_path +"\\" + timestamp + fileName );
		}
        cropsService.insertCrops(cropsVO);
        status.setComplete();
        return "/crops/farmMap";
    }
    
    @RequestMapping("/crops/updateCropsView.do")
    public String updateCropsView(
            @RequestParam("mbrId") java.lang.String mbrId ,
            @RequestParam("itemCode") java.math.BigDecimal itemCode ,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO, Model model)
            throws Exception {
        CropsVO cropsVO = new CropsVO();
        cropsVO.setMbrId(mbrId);
        cropsVO.setItemCode(itemCode);
        // 변수명은 CoC 에 따라 cropsVO
        model.addAttribute(selectCrops(cropsVO, searchVO));
        return "/crops/CropsRegister";
    }

    @RequestMapping("/crops/selectCrops.do")
    public @ModelAttribute("cropsVO")
    CropsVO selectCrops(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO) throws Exception {
        return cropsService.selectCrops(cropsVO);
    }
    @RequestMapping("/crops/updateCrops.do")
    public String updateCrops(CropsVO cropsVO, @ModelAttribute("searchVO") CropsDefaultVO searchVO, SessionStatus status,HttpServletRequest request) throws Exception{
    	cropsService.updateCrops(cropsVO);
        status.setComplete();
        return "redirect:/crops/manufactureFarmMap.do";
    }
    @RequestMapping("/crops/updateCropsImage.do")
    public String updateCropsImage(CropsVO cropsVO, @ModelAttribute("searchVO") CropsDefaultVO searchVO, SessionStatus status,HttpServletRequest request)
            throws Exception {
    	// request를 multipart로 변환
    			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
    			// 첨부파일 읽기
    			MultipartFile uploadFile = multipartRequest.getFile("uploadImageTemp");
    			System.out.println("==========================================================================================");
    			System.out.println(uploadFile);
    			System.out.println("==========================================================================================");
    			// Blob 필드에 넣을경우
    			//vo.setImgData(uploadFile.getBytes());
    			// VO에 멀티파트 필드가 있으면
    			//MultipartFile uploadFile = vo.getUploadFile();
    			String dir_path = request.getSession().getServletContext().getRealPath("/images/makeImage/crops");
    			if(!uploadFile.isEmpty() && uploadFile.getSize() >0) {
    				System.out.println(uploadFile.getSize());
    				System.out.println(dir_path);
    				String timestamp = String.valueOf(System.currentTimeMillis());	// 파일 이름을 유니크하게 하기 위함
    				String fileName = uploadFile.getOriginalFilename();
    				uploadFile.transferTo(new File(dir_path,timestamp + fileName));
    				cropsVO.setUploadImageOriginal(timestamp + fileName);
    				// 같은 파일이 있으면 rename	이부분은 없음 검색해볼것
    				cropsVO.setUploadImage(dir_path +"\\" + timestamp + fileName );
    			}
    	        cropsService.updateCrops(cropsVO);
    	        status.setComplete();
    	
        cropsService.updateCrops(cropsVO);
        status.setComplete();
        return "redirect:/crops/manufactureFarmMap.do";
    }
    
    @RequestMapping("/crops/deleteCrops.do")
    public String deleteCrops(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cropsService.deleteCrops(cropsVO);
        status.setComplete();
        return "redirect:/crops/manufactureFarmMap.do";
    }

    @RequestMapping("/crops/selectCropsMap.do")
    @ResponseBody
    public List selectCropsMap(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO,HttpServletResponse response) throws Exception {
    	return cropsService.selectCropsListNopage(searchVO);
        
    }
    /*************************************************************************************************/
    @RequestMapping("/crops/selectCropsList.do")
    public String selectCropList(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO,HttpServletResponse response,
            HttpSession session,ModelMap model) throws Exception {
    	List<?> cropsList = cropsService.selectCropsListNopage(searchVO);
        model.addAttribute("resultList", cropsList);
    	return "/crops/selectCropsList";
    }
    @RequestMapping("/crops/selectCropsList_insert.do")
    public String selectCropList_insert(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO,HttpServletResponse response,
            HttpSession session,ModelMap model) throws Exception {
    	List<?> cropsList = cropsService.selectCropsListNopage(searchVO);
        model.addAttribute("resultList", cropsList);
    	return "/crops/selectCropsList_insert";
    }
    @RequestMapping("/crops/selectCropsList_sellList.do")
    public String selectCropList_sellList(
            CropsVO cropsVO,
            @ModelAttribute("searchVO") CropsDefaultVO searchVO,HttpServletResponse response,
            HttpSession session,ModelMap model) throws Exception {
    	List<?> cropsList = cropsService.selectCropsListNopage(searchVO);
        model.addAttribute("resultList", cropsList);
    	return "/crops/selectCropsList_sellList";
        
    }
    /*************************************************************************************************/
    @RequestMapping("/crops/farmMap.do")
    public String farmMap() {
        return "/crops/farmMap";
    }
    
    @RequestMapping("/crops/addFarmMap.do")
    public String addCropMap() {
        return "/crops/addFarmMap";
    }
    @RequestMapping("/crops/manufactureFarmMap.do")
    public String manufactureCropMap(@ModelAttribute("searchVO") CropsDefaultVO searchVO, 
    		ModelMap model,HttpSession session) throws Exception {
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
		
		searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword( ((MbrVO)session.getAttribute("loginInfo")).getMbrId());
    	List<?> cropsList = cropsService.selectCropsList(searchVO);
        model.addAttribute("resultList", cropsList);
        
        int totCnt = cropsService.selectCropsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);  	
        
        return "/crops/manufactureFarmMap";
    }
    
    @RequestMapping("/crops/updateCoopView.do")
    public String updateCoop(HttpServletRequest request,HttpSession session) {
    	request.setAttribute("itemCode", request.getParameter("itemCode"));
    	request.setAttribute("mbrId" ,((MbrVO)session.getAttribute("loginInfo")).getMbrId());
        return "/crops/updateCoopView";
    }
    
    @RequestMapping("/crops/MapColorPicker.do")
    public String mapColorPicker() {
        return "/crops/MapColorPicker";
    }
    
    @RequestMapping("report.do")
	public void report(HttpServletRequest request, HttpServletResponse response) throws
	Exception
	{
		try{
			HashMap<String, Object> map = new HashMap<String, Object>();
			JasperReport report =
					JasperCompileManager.compileReport(request.getSession().getServletContext().getRealPath("reports/v_master_1.jrxml"));
			/*ArrayList<MbrVO> ireport = new ArrayList<MbrVO>();
			MbrVO vo = new MbrVO(); 
			vo.setMbrId((String)(request.getSession().getAttribute("mbrId")));
			ireport.add(mbrService.selectgetReport(vo));*/
			ArrayList<MbrVO> ireport = new ArrayList<MbrVO>();
			MbrVO vo = new MbrVO(); 
			vo.setMbrId(((MbrVO)(request.getSession().getAttribute("loginInfo"))).getMbrId());
			System.out.println(vo+"-------------------------------------");
			ireport.add(mbrService.selectgetReport(vo));
			System.out.println(ireport+"-------------------------------------");
			JRDataSource JRdataSource =	new JRBeanCollectionDataSource(ireport);
			JasperPrint print = JasperFillManager.fillReport(report,map,JRdataSource);
			JRExporter exporter = new JRPdfExporter();
			OutputStream out;
			response.reset();
			out = response.getOutputStream();
			exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, "v_master_1.pdf");
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, out);
			exporter.exportReport();
			out.flush();
			out.close();
		}catch(Exception e) {
				e.printStackTrace();
			}
		}
}
