package egovframework.farm.item.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.item.service.ItemDefaultVO;
import egovframework.farm.item.service.ItemVO;

/**
 * @Class Name : ItemDAO.java
 * @Description : Item DAO Class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("itemDAO")
public class ItemDAO extends EgovComAbstractDAO {

	/**
	 * ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertItem(ItemVO vo) throws Exception {
        return (String)insert("itemDAO.insertItem_S", vo);
    }

    /**
	 * ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateItem(ItemVO vo) throws Exception {
        update("itemDAO.updateItem_S", vo);
    }

    /**
	 * ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteItem(ItemVO vo) throws Exception {
        delete("itemDAO.deleteItem_S", vo);
    }

    /**
	 * ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemVO
	 * @return 조회한 ITEM
	 * @exception Exception
	 */
    public ItemVO selectItem(ItemVO vo) throws Exception {
        return (ItemVO) select("itemDAO.selectItem_S", vo);
    }

    /**
	 * ITEM 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ITEM 목록
	 * @exception Exception
	 */
    public List<?> selectItemList(ItemDefaultVO searchVO) throws Exception {
        return list("itemDAO.selectItemList_D", searchVO);
    }
    public List<?> selectItemL(ItemDefaultVO searchVO) throws Exception {
        return list("itemDAO.selectItemL", searchVO);
    }
    public List<?> selectItemM(ItemDefaultVO searchVO) throws Exception {
        return list("itemDAO.selectItemM", searchVO);
    }
    public List<?> selectItemS(ItemVO vo) throws Exception {
        return list("itemDAO.selectItemS", vo);
    }

    /**
	 * ITEM 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ITEM 총 갯수
	 * @exception
	 */
    public int selectItemListTotCnt(ItemDefaultVO searchVO) {
        return (Integer)select("itemDAO.selectItemListTotCnt_S", searchVO);
    }

}
