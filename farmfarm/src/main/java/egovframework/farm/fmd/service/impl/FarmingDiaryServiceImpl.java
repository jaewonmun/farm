package egovframework.farm.fmd.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.fmd.service.FarmingDiaryService;
import egovframework.farm.fmd.service.FarmingDiaryDefaultVO;
import egovframework.farm.fmd.service.FarmingDiaryVO;
import egovframework.farm.fmd.service.impl.FarmingDiaryDAO;

/**
 * @Class Name : FarmingDiaryServiceImpl.java
 * @Description : FarmingDiary Business Implement class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("farmingDiaryService")
public class FarmingDiaryServiceImpl extends EgovAbstractServiceImpl implements
        FarmingDiaryService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(FarmingDiaryServiceImpl.class);

    @Resource(name="farmingDiaryDAO")
    private FarmingDiaryDAO farmingDiaryDAO;
    
    /** ID Generation */
    //@Resource(name="{egovFarmingDiaryIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * FARMING_DIARY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmingDiaryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertFarmingDiary(FarmingDiaryVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	farmingDiaryDAO.insertFarmingDiary(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * FARMING_DIARY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmingDiaryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateFarmingDiary(FarmingDiaryVO vo) throws Exception {
        farmingDiaryDAO.updateFarmingDiary(vo);
    }

    /**
	 * FARMING_DIARY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmingDiaryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteFarmingDiary(FarmingDiaryVO vo) throws Exception {
        farmingDiaryDAO.deleteFarmingDiary(vo);
    }

    /**
	 * FARMING_DIARY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
    public FarmingDiaryVO selectFarmingDiary(FarmingDiaryVO vo) throws Exception {
        FarmingDiaryVO resultVO = farmingDiaryDAO.selectFarmingDiary(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * FARMING_DIARY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARMING_DIARY 목록
	 * @exception Exception
	 */
    public List<?> selectFarmingDiaryList(Map<String, String> commandMap) throws Exception {
        return farmingDiaryDAO.selectFarmingDiaryList(commandMap);
    }
    public List<?> selectFarmingDiaryListForMain(FarmingDiaryVO vo) throws Exception {
        return farmingDiaryDAO.selectFarmingDiaryListForMain(vo);
    }
    /**
	 * FARMING_DIARY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARMING_DIARY 총 갯수
	 * @exception
	 */
    public int selectFarmingDiaryListTotCnt(FarmingDiaryDefaultVO searchVO) {
		return farmingDiaryDAO.selectFarmingDiaryListTotCnt(searchVO);
	}

    
    
    
    /**
	 * FARMING_DIARY을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
	@Override
	public FarmingDiaryVO selectdiaryReport(FarmingDiaryVO vo) throws Exception {
		FarmingDiaryVO resultVO = farmingDiaryDAO.selectdiaryReport(vo);
		if(resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}
	
	
    
	
	
    
}
