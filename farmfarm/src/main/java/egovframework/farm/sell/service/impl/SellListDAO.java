package egovframework.farm.sell.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.sell.service.SellListDefaultVO;
import egovframework.farm.sell.service.SellListVO;

/**
 * @Class Name : SellListDAO.java
 * @Description : SellList DAO Class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("sellListDAO")
public class SellListDAO extends EgovComAbstractDAO {

	/**
	 * SELL_LIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SellListVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSellList(SellListVO vo) throws Exception {
        return (String)insert("sellListDAO.insertSellList_S", vo);
    }

    /**
	 * SELL_LIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SellListVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSellList(SellListVO vo) throws Exception {
        update("sellListDAO.updateSellList_S", vo);
    }

    /**
	 * SELL_LIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SellListVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSellList(SellListVO vo) throws Exception {
        delete("sellListDAO.deleteSellList_S", vo);
    }

    /**
	 * SELL_LIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    public SellListVO selectSellList(SellListVO vo) throws Exception {
        return (SellListVO) select("sellListDAO.selectSellList_S", vo);
    }

    /**
	 * SELL_LIST 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SELL_LIST 목록
	 * @exception Exception
	 */
    public List<?> selectSellListList(SellListDefaultVO searchVO) throws Exception {
        return list("sellListDAO.selectSellListList_D", searchVO);
    }
    /**
	 * SELL_LIST TOP5를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SELL_LIST 목록
	 * @exception Exception
	 */
    public List<?> sellListTop5(SellListDefaultVO searchVO) throws Exception {
        return list("sellListDAO.sellListTop5", searchVO);
    }
    /**
   	 * SELL_LIST 3일 조회한다.
   	 * @param searchMap - 조회할 정보가 담긴 Map
   	 * @return SELL_LIST 목록
   	 * @exception Exception
   	 */
       public List<?> sellList3day(SellListDefaultVO searchVO) throws Exception {
           return list("sellListDAO.sellList3day", searchVO);
       }

    
    /**
	 * SELL_LIST 지난주 데이터를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    public Map<?,?> weekStat(SellListDefaultVO searchVO) throws Exception {
    	System.out.println((Map<?, ?>) select("sellListDAO.weekStat", searchVO));
        return (Map<?, ?>) select("sellListDAO.weekStat", searchVO);
    }
    
    /**
	 * SELL_LIST 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SELL_LIST 총 갯수
	 * @exception
	 */
    public int selectSellListListTotCnt(SellListDefaultVO searchVO) {
        return (Integer)select("sellListDAO.selectSellListListTotCnt_S", searchVO);
    }
    
    /**
	 * SELL_LIST을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    public SellListVO selectselllistReport(SellListVO vo) throws Exception {
        return (SellListVO) select("sellListDAO.selectselllistReport_S", vo);
    }

}
