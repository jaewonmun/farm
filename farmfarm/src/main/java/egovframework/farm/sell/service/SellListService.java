package egovframework.farm.sell.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : SellListService.java
 * @Description : SellList Business class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface SellListService {
	
	/**
	 * SELL_LIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SellListVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSellList(SellListVO vo) throws Exception;
    
    /**
	 * SELL_LIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SellListVO
	 * @return void형
	 * @exception Exception
	 */
    void updateSellList(SellListVO vo) throws Exception;
    
    /**
	 * SELL_LIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SellListVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteSellList(SellListVO vo) throws Exception;
    
    /**
	 * SELL_LIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    SellListVO selectSellList(SellListVO vo) throws Exception;
    
    /**
	 * SELL_LIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SELL_LIST 목록
	 * @exception Exception
	 */
    List selectSellListList(SellListDefaultVO searchVO) throws Exception;
    
    /**
   	 * SELL_LIST TOP5를 조회한다.
   	 * @param searchMap - 조회할 정보가 담긴 Map
   	 * @return SELL_LIST 목록
   	 * @exception Exception
   	 */
    List sellListTop5(SellListDefaultVO searchVO) throws Exception;
    
    /**
	 * SELL_LIST 3일 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SELL_LIST 목록
	 * @exception Exception
	 */
    List sellList3day(SellListDefaultVO searchVO) throws Exception ;

    /**
 	 * SELL_LIST 지난주 데이터를 조회한다.
 	 * @param searchMap - 조회할 정보가 담긴 Map
 	 * @return 조회한 SELL_LIST
 	 * @exception Exception
 	 */
    Map weekStat(SellListDefaultVO searchVO) throws Exception; 
    
    /**
	 * SELL_LIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SELL_LIST 총 갯수
	 * @exception
	 */
    int selectSellListListTotCnt(SellListDefaultVO searchVO);
    
    /**
	 * SELL_LIST을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    SellListVO selectselllistReport(SellListVO vo) throws Exception;
    
}
