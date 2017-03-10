package egovframework.farm.mbr.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.farm.mbr.service.MbrDefaultVO;
import egovframework.farm.mbr.service.MbrService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : MbrController.java
 * @Description : Mbr Controller class
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
@SessionAttributes(types=MbrVO.class)
public class MbrController {

    @Resource(name = "mbrService")
    private MbrService mbrService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * MBR 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 MbrDefaultVO
	 * @return "/mbr/MbrList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mbr/MbrList.do")
    public String selectMbrList(@ModelAttribute("searchVO") MbrDefaultVO searchVO, 
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
		
        List<?> mbrList = mbrService.selectMbrList(searchVO);
        model.addAttribute("resultList", mbrList);
        
        int totCnt = mbrService.selectMbrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mbr/MbrList";
    } 
    
    @RequestMapping("/mbr/addMbrView.do")
    public String addMbrView(
            @ModelAttribute("searchVO") MbrDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("mbrVO", new MbrVO());
        return "/mbr/MbrRegister";
    }
    
    @RequestMapping("/mbr/addMbr.do")
    public String addMbr(
            MbrVO mbrVO,
            @ModelAttribute("searchVO") MbrDefaultVO searchVO, SessionStatus status)
            throws Exception {
        mbrService.insertMbr(mbrVO);
        status.setComplete();
        return "redirect:/crops/farmMap.do";
    }
    
    @RequestMapping("/mbr/updateMbrView.do")
    public String updateMbrView(
            @RequestParam("mbrId") java.lang.String mbrId ,
            @ModelAttribute("searchVO") MbrDefaultVO searchVO, Model model)
            throws Exception {
        MbrVO mbrVO = new MbrVO();
        mbrVO.setMbrId(mbrId);
        // 변수명은 CoC 에 따라 mbrVO
        model.addAttribute(selectMbr(mbrVO, searchVO));
        return "/mbr/MbrRegister";
    }

    @RequestMapping("/mbr/selectMbr.do")
    public @ModelAttribute("mbrVO")
    MbrVO selectMbr(
            MbrVO mbrVO,
            @ModelAttribute("searchVO") MbrDefaultVO searchVO) throws Exception {
        return mbrService.selectMbr(mbrVO);
    }

    @RequestMapping("/mbr/updateMbr.do")
    public String updateMbr(
            MbrVO mbrVO,
            @ModelAttribute("searchVO") MbrDefaultVO searchVO, SessionStatus status)
            throws Exception {
        mbrService.updateMbr(mbrVO);
        status.setComplete();
        return "forward:/mbr/MbrList.do";
    }
    
    @RequestMapping("/mbr/deleteMbr.do")
    public String deleteMbr(
            MbrVO mbrVO,
            @ModelAttribute("searchVO") MbrDefaultVO searchVO, SessionStatus status)
            throws Exception {
        mbrService.deleteMbr(mbrVO);
        status.setComplete();
        return "forward:/mbr/MbrList.do";
    }
    @RequestMapping("/mbr/loginView.do")
    public String loginMbrView() {
    	return "mbr/Login";
    }
    
    @RequestMapping("/mbr/login.do")
    public String loginMbr(MbrVO mbrVO,
    					   HttpServletRequest request,
    					   HttpServletResponse response,Model model) throws Exception {
    	 	
    	String input_mbrId = (String)request.getParameter("mbrId");			// 로그인 페이지에서 받아온 파라미터
    	//System.out.println(input_mbrId);
    	
    	/**
    	 *  입력받은 패스워드 암호화
    	 */
    	String enpassword = EgovFileScrty.encryptPassword(mbrVO.getPassword(), mbrVO.getMbrId());
    	mbrVO.setPassword(enpassword);
    	
    	mbrVO.setMbrId(input_mbrId);						// 받아온 파라미터를 VO에 넣는다.
    	
    	MbrVO sessionTemp = null;	// 회원정보 VO에 저장 하기위해 임시 객체 생성
    	
    	int check = mbrService.selectLogin(mbrVO);			// Mybatis 호출 ID/PW/ 일치여부 판단 틀리면 0, 맞으면 1		
    	response.setCharacterEncoding("utf-8");
    	PrintWriter out = response.getWriter();			
    	if(check == 0 ) {
			out.println("<script language='javascript'>"); 
			out.println("alert('ID/PW가 올바르지 않습니다.');");		// 오류 메시지를 띄운다
			out.println("history.back();");								// 다시 로그인 페이지로 돌아온다
			out.println("</script>"); 
			out.close();
			return null;												// 틀리면 페이지 이동 없음
    	} else {
    		sessionTemp = mbrService.selectMbr(mbrVO);					// 로그인에 성공하면 임시객체에 로그인정보 저장
    		mbrVO.setRegion(sessionTemp.getRegion());	
    		mbrVO.setUserConame(sessionTemp.getUserConame());
    		request.getSession().setAttribute("loginInfo", mbrVO);		// 로그인 정보 세션에 저장 
    		model.addAttribute("msg", "로그인 되었습니다.");
        	model.addAttribute("returnUrl", "crops/farmMap.do");
        	//model.addAttribute("parentYn", "Y");
        	return "/egovframework/com/cmm/alert";
    	}
    	
    }
    @RequestMapping("/mbr/logout.do")
    public String logoutMbr(HttpServletRequest request,Model model) throws IOException {
    	request.getSession().removeAttribute("loginInfo");
    	request.getSession().invalidate();
    	model.addAttribute("msg", "로그아웃되었습니다.");
    	model.addAttribute("returnUrl", "index.do");
    	model.addAttribute("parentYn", "Y");
    	return "/egovframework/com/cmm/alert";
    }
    // 회원가입시 지도 선택
    @RequestMapping("/mbr/mapSelect.do")
    public String mapSelect(){
    	return "/mbr/mapSelect";
    }
    
    @RequestMapping("/mbr/idCheck.do")
    public void idCheck(MbrVO mbrVO,HttpServletResponse response, HttpServletRequest request, Model model) throws IOException{
    	int check = mbrService.idCheck(mbrVO);
    	response.setCharacterEncoding("utf-8");
    	PrintWriter out = response.getWriter();	
    	if(check == 0) {
    		out.print("사용가능한 ID 입니다.");
    		//model.addAttribute("check", "true");
    	}
    	else{
    		out.print("중복된 ID 입니다.");
    		//model.addAttribute("check", "false");
    	}
    }
    
    
    /**
     * 
     * 미사용 메소드
     * @return
     */
    @RequestMapping("/mbr/conameSearch.do")
    public String conameSearch() {
    	return "/mbr/conameSearch";
    }
    
    @RequestMapping("/mbr/coname.do")
    public String coname() {
    	return "/mbr/coname";
    }
    
    
}
