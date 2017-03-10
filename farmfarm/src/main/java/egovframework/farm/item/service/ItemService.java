package egovframework.farm.item.service;

import java.util.List;
import egovframework.farm.item.service.ItemDefaultVO;
import egovframework.farm.item.service.ItemVO;

/**
 * @Class Name : ItemService.java
 * @Description : Item Business class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ItemService {
	
	/**
	 * ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertItem(ItemVO vo) throws Exception;
    
    /**
	 * ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemVO
	 * @return void형
	 * @exception Exception
	 */
    void updateItem(ItemVO vo) throws Exception;
    
    /**
	 * ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteItem(ItemVO vo) throws Exception;
    
    /**
	 * ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemVO
	 * @return 조회한 ITEM
	 * @exception Exception
	 */
    ItemVO selectItem(ItemVO vo) throws Exception;
    
    /**
	 * ITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ITEM 목록
	 * @exception Exception
	 */
    List selectItemList(ItemDefaultVO searchVO) throws Exception;
    List selectItemL(ItemVO vo) throws Exception;
    List selectItemM(ItemVO vo) throws Exception;
    List selectItemS(ItemVO vo) throws Exception;
    
    /**
	 * ITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ITEM 총 갯수
	 * @exception
	 */
    int selectItemListTotCnt(ItemDefaultVO searchVO);
    
}
