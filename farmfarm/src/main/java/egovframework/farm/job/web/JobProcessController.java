package egovframework.farm.job.web;

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
public class JobProcessController {

    @Resource(name = "jobProcessService")
    private JobProcessService jobProcessService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * JOB_PROCESS 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JobProcessDefaultVO
	 * @return "/jobProcess/JobProcessList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jobProcess/JobProcessList.do")
    public String selectJobProcessList(@ModelAttribute("searchVO") JobProcessDefaultVO searchVO, 
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
		
        List<?> jobProcessList = jobProcessService.selectJobProcessList(searchVO);
        model.addAttribute("resultList", jobProcessList);
        
        int totCnt = jobProcessService.selectJobProcessListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jobProcess/JobProcessList";
    } 
    
    @RequestMapping("/jobProcess/addJobProcessView.do")
    public String addJobProcessView(
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("jobProcessVO", new JobProcessVO());
        return "/jobProcess/JobProcessRegister";
    }
    
    @RequestMapping("/jobProcess/addJobProcess.do")
    public String addJobProcess(
            JobProcessVO jobProcessVO,
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jobProcessService.insertJobProcess(jobProcessVO);
        status.setComplete();
        return "forward:/jobProcess/JobProcessList.do";
    }
    
    @RequestMapping("/jobProcess/updateJobProcessView.do")
    public String updateJobProcessView(
            @RequestParam("jobSeq") java.math.BigDecimal jobSeq ,
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO, Model model)
            throws Exception {
        JobProcessVO jobProcessVO = new JobProcessVO();
        jobProcessVO.setJobSeq(jobSeq);
        // 변수명은 CoC 에 따라 jobProcessVO
        model.addAttribute(selectJobProcess(jobProcessVO, searchVO));
        return "/jobProcess/JobProcessRegister";
    }

    @RequestMapping("/jobProcess/selectJobProcess.do")
    public @ModelAttribute("jobProcessVO")
    JobProcessVO selectJobProcess(
            JobProcessVO jobProcessVO,
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO) throws Exception {
        return jobProcessService.selectJobProcess(jobProcessVO);
    }

    @RequestMapping("/jobProcess/updateJobProcess.do")
    public String updateJobProcess(
            JobProcessVO jobProcessVO,
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jobProcessService.updateJobProcess(jobProcessVO);
        status.setComplete();
        return "forward:/jobProcess/JobProcessList.do";
    }
    
    @RequestMapping("/jobProcess/deleteJobProcess.do")
    public String deleteJobProcess(
            JobProcessVO jobProcessVO,
            @ModelAttribute("searchVO") JobProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jobProcessService.deleteJobProcess(jobProcessVO);
        status.setComplete();
        return "forward:/jobProcess/JobProcessList.do";
    }

}
