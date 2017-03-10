package egovframework.farm.crop.service;

import java.util.List;

import egovframework.farm.crop.service.CropsDefaultVO;
import egovframework.farm.crop.service.CropsVO;

/**
 * @Class Name : CropsService.java
 * @Description : Crops Business class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CropsService {
	
	/**
	 * CROPS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CropsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertCrops(CropsVO vo) throws Exception;
    
    /**
	 * CROPS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CropsVO
	 * @return void형
	 * @exception Exception
	 */
    void updateCrops(CropsVO vo) throws Exception;
    
    /**
	 * CROPS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CropsVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteCrops(CropsVO vo) throws Exception;
    
    /**
	 * CROPS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CropsVO
	 * @return 조회한 CROPS
	 * @exception Exception
	 */
    CropsVO selectCrops(CropsVO vo) throws Exception;
    
    /**
	 * CROPS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CROPS 목록
	 * @exception Exception
	 */
    List selectCropsList(CropsDefaultVO searchVO) throws Exception;
    
    /**
	 * CROPS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CROPS 총 갯수
	 * @exception
	 */
    int selectCropsListTotCnt(CropsDefaultVO searchVO);
   
    /**
	 * 지도에 표시할 목록을 조회한다
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CROPS 목록
	 * @exception Exception
	 */
    List<?> selectCropsListNopage(CropsDefaultVO searchVO);
    
    

}
