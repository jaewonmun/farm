package egovframework.farm.sell.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.farm.sell.service.SellListDefaultVO;
import egovframework.farm.sell.service.SellListService;
import egovframework.farm.sell.service.SellListVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : SellListServiceImpl.java
 * @Description : SellList Business Implement class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("sellListService")
public class SellListServiceImpl extends EgovAbstractServiceImpl implements
        SellListService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(SellListServiceImpl.class);

    @Resource(name="sellListDAO")
    private SellListDAO sellListDAO;
    
    /** ID Generation */
    //@Resource(name="{egovSellListIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * SELL_LIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SellListVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSellList(SellListVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	sellListDAO.insertSellList(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * SELL_LIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SellListVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSellList(SellListVO vo) throws Exception {
        sellListDAO.updateSellList(vo);
    }

    /**
	 * SELL_LIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SellListVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSellList(SellListVO vo) throws Exception {
        sellListDAO.deleteSellList(vo);
    }

    /**
	 * SELL_LIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
    public SellListVO selectSellList(SellListVO vo) throws Exception {
        SellListVO resultVO = sellListDAO.selectSellList(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * SELL_LIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SELL_LIST 목록
	 * @exception Exception
	 */
    public List<?> selectSellListList(SellListDefaultVO searchVO) throws Exception {
        return sellListDAO.selectSellListList(searchVO);
    }
    /**
   	 * SELL_LIST TOP5를 조회한다.
   	 * @param searchMap - 조회할 정보가 담긴 Map
   	 * @return SELL_LIST 목록
   	 * @exception Exception
   	 */
     public List<?> sellListTop5(SellListDefaultVO searchVO) throws Exception {
         return sellListDAO.sellListTop5(searchVO);
     }
     
     /**
    	 * SELL_LIST 3일 조회한다.
    	 * @param searchMap - 조회할 정보가 담긴 Map
    	 * @return SELL_LIST 목록
    	 * @exception Exception
    	 */
        public List<?> sellList3day(SellListDefaultVO searchVO) throws Exception {
            return sellListDAO.sellList3day(searchVO);
        }
     /**
 	 * SELL_LIST 지난주 데이터를 조회한다.
 	 * @param searchMap - 조회할 정보가 담긴 Map
 	 * @return 조회한 SELL_LIST
 	 * @exception Exception
 	 */
     public Map<?,?> weekStat(SellListDefaultVO searchVO) throws Exception {
         return sellListDAO.weekStat(searchVO);
     }  
       
    /**
	 * SELL_LIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SELL_LIST 총 갯수
	 * @exception
	 */
    public int selectSellListListTotCnt(SellListDefaultVO searchVO) {
		return sellListDAO.selectSellListListTotCnt(searchVO);
	}

    /**
	 * SELL_LIST을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 SellListVO
	 * @return 조회한 SELL_LIST
	 * @exception Exception
	 */
	@Override
	public SellListVO selectselllistReport(SellListVO vo) throws Exception {
	       SellListVO resultVO = sellListDAO.selectselllistReport(vo);
	        if (resultVO == null)
	            throw processException("info.nodata.msg");
	        return resultVO;
	}
    
	
	
	
}
