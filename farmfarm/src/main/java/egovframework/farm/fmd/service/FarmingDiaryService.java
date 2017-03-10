package egovframework.farm.fmd.service;

import java.util.List;
import java.util.Map;

import egovframework.farm.fmd.service.FarmingDiaryDefaultVO;
import egovframework.farm.fmd.service.FarmingDiaryVO;

/**
 * @Class Name : FarmingDiaryService.java
 * @Description : FarmingDiary Business class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface FarmingDiaryService {
	
	/**
	 * FARMING_DIARY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmingDiaryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertFarmingDiary(FarmingDiaryVO vo) throws Exception;
    
    /**
	 * FARMING_DIARY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmingDiaryVO
	 * @return void형
	 * @exception Exception
	 */
    void updateFarmingDiary(FarmingDiaryVO vo) throws Exception;
    
    /**
	 * FARMING_DIARY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmingDiaryVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteFarmingDiary(FarmingDiaryVO vo) throws Exception;
    
    /**
	 * FARMING_DIARY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
    FarmingDiaryVO selectFarmingDiary(FarmingDiaryVO vo) throws Exception;
    List<?> selectFarmingDiaryListForMain(FarmingDiaryVO vo) throws Exception;
    /**
	 * FARMING_DIARY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARMING_DIARY 목록
	 * @exception Exception
	 */
    List selectFarmingDiaryList(Map<String, String> commandMap) throws Exception;
    
    /**
	 * FARMING_DIARY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARMING_DIARY 총 갯수
	 * @exception
	 */
    int selectFarmingDiaryListTotCnt(FarmingDiaryDefaultVO searchVO);
    
    /**
	 * FARMING_DIARY을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
    FarmingDiaryVO selectdiaryReport(FarmingDiaryVO vo) throws Exception;
}
