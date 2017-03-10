package egovframework.farm.crop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.crop.service.CropsService;
import egovframework.farm.crop.service.CropsDefaultVO;
import egovframework.farm.crop.service.CropsVO;
import egovframework.farm.crop.service.impl.CropsDAO;

/**
 * @Class Name : CropsServiceImpl.java
 * @Description : Crops Business Implement class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cropsService")
public class CropsServiceImpl extends EgovAbstractServiceImpl implements
        CropsService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CropsServiceImpl.class);

    @Resource(name="cropsDAO")
    private CropsDAO cropsDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCropsIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * CROPS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CropsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCrops(CropsVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	cropsDAO.insertCrops(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * CROPS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CropsVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCrops(CropsVO vo) throws Exception {
        cropsDAO.updateCrops(vo);
    }

    /**
	 * CROPS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CropsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCrops(CropsVO vo) throws Exception {
        cropsDAO.deleteCrops(vo);
    }

    /**
	 * CROPS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CropsVO
	 * @return 조회한 CROPS
	 * @exception Exception
	 */
    public CropsVO selectCrops(CropsVO vo) throws Exception {
        CropsVO resultVO = cropsDAO.selectCrops(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * CROPS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CROPS 목록
	 * @exception Exception
	 */
    public List<?> selectCropsList(CropsDefaultVO searchVO) throws Exception {
        return cropsDAO.selectCropsList(searchVO);
    }

    /**
	 * CROPS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CROPS 총 갯수
	 * @exception
	 */
    public int selectCropsListTotCnt(CropsDefaultVO searchVO) {
		return cropsDAO.selectCropsListTotCnt(searchVO);
	}

	@Override
	public List<?> selectCropsListNopage(CropsDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return cropsDAO.selectCropsListNopage(searchVO);
	}
    
}
