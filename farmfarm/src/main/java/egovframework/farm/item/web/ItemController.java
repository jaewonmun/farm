package egovframework.farm.item.web;

import java.util.List;

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

import egovframework.farm.item.service.ItemDefaultVO;
import egovframework.farm.item.service.ItemService;
import egovframework.farm.item.service.ItemVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : ItemController.java
 * @Description : Item Controller class
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
@SessionAttributes(types=ItemVO.class)
public class ItemController {

    @Resource(name = "itemService")
    private ItemService itemService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * ITEM 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ItemDefaultVO
	 * @return "/item/ItemList"
	 * @exception Exception
	 */
    @RequestMapping(value="/item/ItemList.do")
    public String selectItemList(@ModelAttribute("searchVO") ItemDefaultVO searchVO, ItemVO vo,
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
		
        List<?> itemList = itemService.selectItemList(searchVO);
        model.addAttribute("resultList", itemList);
        
        int totCnt = itemService.selectItemListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
    	List<?> selectItemL = itemService.selectItemL(vo);
        model.addAttribute("LList", selectItemL);
        
    	List<?> selectItemM = itemService.selectItemM(vo);
        model.addAttribute("MList", selectItemM);
        
    	List<?> selectItemS = itemService.selectItemS(vo);
        model.addAttribute("SList", selectItemS);
        
        return "/item/ItemList";
    } 
    
    @RequestMapping("/item/addItemView.do")
    public String addItemView(
            @ModelAttribute("searchVO") ItemDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("itemVO", new ItemVO());
        return "/item/ItemRegister";
    }
    
    @RequestMapping("/item/addItem.do")
    public String addItem(
            ItemVO itemVO,
            @ModelAttribute("searchVO") ItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        itemService.insertItem(itemVO);
        status.setComplete();
        return "forward:/item/ItemList.do";
    }
    
    @RequestMapping("/item/updateItemView.do")
    public String updateItemView(
            @RequestParam("itemCode") java.math.BigDecimal itemCode ,
            @ModelAttribute("searchVO") ItemDefaultVO searchVO, Model model)
            throws Exception {
        ItemVO itemVO = new ItemVO();
        itemVO.setItemCode(itemCode);
        // 변수명은 CoC 에 따라 itemVO
        model.addAttribute(selectItem(itemVO, searchVO));
        return "/item/ItemRegister";
    }

    @RequestMapping("/item/selectItem.do")
    public @ModelAttribute("itemVO")
    ItemVO selectItem(
            ItemVO itemVO,
            @ModelAttribute("searchVO") ItemDefaultVO searchVO) throws Exception {
        return itemService.selectItem(itemVO);
    }

    @RequestMapping("/item/updateItem.do")
    public String updateItem(
            ItemVO itemVO,
            @ModelAttribute("searchVO") ItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        itemService.updateItem(itemVO);
        status.setComplete();
        return "forward:/item/ItemList.do";
    }
    
    @RequestMapping("/item/deleteItem.do")
    public String deleteItem(
            ItemVO itemVO,
            @ModelAttribute("searchVO") ItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        itemService.deleteItem(itemVO);
        status.setComplete();
        return "forward:/item/ItemList.do";
    }

    @RequestMapping("/item/ItemAPI.do")
    public String itemAPI() {
    	return "/item/ItemAPI";		
    }
    

    @RequestMapping("/item/selectItemM.do")
    @ResponseBody
    public List selectItemM(ItemVO vo, ModelMap model) throws Exception {
    	return itemService.selectItemM(vo);
    }
    
/*    @RequestMapping("/item/selectItemS.do")
    public List selectItemS(ItemVO vo, ModelMap model) throws Exception {
    	//List<?> selectItemS = itemService.selectItemS(vo);
        //model.addAttribute("SList", selectItemS);
        return itemService.selectItemS(vo);
    }*/
    @RequestMapping("/item/selectItemS.do")
    @ResponseBody
    public List selectItemS(ItemVO vo, ModelMap model) throws Exception {  
	   // List<?> result = itemService.selectItemS(vo);
	   // response.setCharacterEncoding("utf-8");
	   // response.getWriter().print(result);
	    return itemService.selectItemS(vo);
		
    }
    		
}
