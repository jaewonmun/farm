package egovframework.farm.cpr.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.cpr.service.CprService;
import egovframework.farm.cpr.service.CprDefaultVO;
import egovframework.farm.cpr.service.CprVO;
import egovframework.farm.cpr.service.impl.CprDAO;

/**
 * @Class Name : CprServiceImpl.java
 * @Description : Cpr Business Implement class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cprService")
public class CprServiceImpl extends EgovAbstractServiceImpl implements
        CprService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CprServiceImpl.class);

    @Resource(name="cprDAO")
    private CprDAO cprDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCprIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * CPR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CprVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCpr(CprVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	cprDAO.insertCpr(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * CPR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CprVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCpr(CprVO vo) throws Exception {
        cprDAO.updateCpr(vo);
    }

    /**
	 * CPR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CprVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCpr(CprVO vo) throws Exception {
        cprDAO.deleteCpr(vo);
    }

    /**
	 * CPR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CprVO
	 * @return 조회한 CPR
	 * @exception Exception
	 */
    public CprVO selectCpr(CprVO vo) throws Exception {
        CprVO resultVO = cprDAO.selectCpr(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * CPR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CPR 목록
	 * @exception Exception
	 */
    public List<?> selectCprList(CprDefaultVO searchVO) throws Exception {
        return cprDAO.selectCprList(searchVO);
    }
    
    /**
	 * CPR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CPR 총 갯수
	 * @exception
	 */
    public int selectCprListTotCnt(CprDefaultVO searchVO) {
		return cprDAO.selectCprListTotCnt(searchVO);
	}

	@Override
	public List<?> selectMRKT(CprDefaultVO searchVO) throws Exception {
        return cprDAO.selectMRKT(searchVO);
    }
	@Override
	public List<?> selectCPR(CprVO vo) throws Exception {
		// TODO Auto-generated method stub
		return cprDAO.selectCPR(vo);
	}
    
}
