package egovframework.farm.fmd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.fmd.service.FarmingDiaryDefaultVO;
import egovframework.farm.fmd.service.FarmingDiaryVO;

/**
 * @Class Name : FarmingDiaryDAO.java
 * @Description : FarmingDiary DAO Class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("farmingDiaryDAO")
public class FarmingDiaryDAO extends EgovComAbstractDAO {

	/**
	 * FARMING_DIARY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmingDiaryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertFarmingDiary(FarmingDiaryVO vo) throws Exception {
        return (String)insert("farmingDiaryDAO.insertFarmingDiary_S", vo);
    }

    /**
	 * FARMING_DIARY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmingDiaryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateFarmingDiary(FarmingDiaryVO vo) throws Exception {
        update("farmingDiaryDAO.updateFarmingDiary_S", vo);
    }

    /**
	 * FARMING_DIARY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmingDiaryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteFarmingDiary(FarmingDiaryVO vo) throws Exception {
        delete("farmingDiaryDAO.deleteFarmingDiary_S", vo);
    }

    /**
	 * FARMING_DIARY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
    public FarmingDiaryVO selectFarmingDiary(FarmingDiaryVO vo) throws Exception {
        return (FarmingDiaryVO) select("farmingDiaryDAO.selectFarmingDiary_S", vo);
    }
    public List<?> selectFarmingDiaryListForMain(FarmingDiaryVO vo) throws Exception {
        return list("farmingDiaryDAO.selectFarmingDiaryListForMain", vo);
    }
   
    /**
	 * FARMING_DIARY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return FARMING_DIARY 목록
	 * @exception Exception
	 */
    public List<?> selectFarmingDiaryList(Map<String, String> commandMap) throws Exception {
    	//System.out.println(commandMap);
        return list("farmingDiaryDAO.selectFarmingDiaryList_D", commandMap);
    }

    /**
	 * FARMING_DIARY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return FARMING_DIARY 총 갯수
	 * @exception
	 */
    public int selectFarmingDiaryListTotCnt(FarmingDiaryDefaultVO searchVO) {
        return (Integer)select("farmingDiaryDAO.selectFarmingDiaryListTotCnt_S", searchVO);
    }
    
    /**
	 * FARMING_DIARY을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmingDiaryVO
	 * @return 조회한 FARMING_DIARY
	 * @exception Exception
	 */
    public FarmingDiaryVO selectdiaryReport(FarmingDiaryVO vo) throws Exception {
        return (FarmingDiaryVO) select("farmingDiaryDAO.selectdiaryReport_S", vo);
    }

}
