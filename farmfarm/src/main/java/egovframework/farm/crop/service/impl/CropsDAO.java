package egovframework.farm.crop.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.crop.service.CropsDefaultVO;
import egovframework.farm.crop.service.CropsVO;

/**
 * @Class Name : CropsDAO.java
 * @Description : Crops DAO Class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cropsDAO")
public class CropsDAO extends EgovComAbstractDAO {

	/**
	 * CROPS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CropsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCrops(CropsVO vo) throws Exception {
        return (String)insert("cropsDAO.insertCrops_S", vo);
    }

    /**
	 * CROPS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CropsVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCrops(CropsVO vo) throws Exception {
        update("cropsDAO.updateCrops_S", vo);
    }

    /**
	 * CROPS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CropsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCrops(CropsVO vo) throws Exception {
        delete("cropsDAO.deleteCrops_S", vo);
    }

    /**
	 * CROPS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CropsVO
	 * @return 조회한 CROPS
	 * @exception Exception
	 */
    public CropsVO selectCrops(CropsVO vo) throws Exception {
        return (CropsVO) select("cropsDAO.selectCrops_S", vo);
    }

    /**
	 * CROPS 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CROPS 목록
	 * @exception Exception
	 */
    public List<?> selectCropsList(CropsDefaultVO searchVO) throws Exception {
        return list("cropsDAO.selectCropsList_D", searchVO);
    }

    /**
	 * CROPS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CROPS 총 갯수
	 * @exception
	 */
    public int selectCropsListTotCnt(CropsDefaultVO searchVO) {
        return (Integer)select("cropsDAO.selectCropsListTotCnt_S", searchVO);
    }
    /**
	 * 지도에 표시할 목록을 조회한다
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CROPS 목록
	 * @exception Exception
	 */
    public List<?> selectCropsListNopage(CropsDefaultVO searchVO) {
    	return list("cropsDAO.selectCropsListNopage_D", searchVO);
    }
    /**
	 * 리포트에 표시할 목록을 조회한다
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return report 목록
	 * @exception Exception
	 */
    public List<?> getReport(CropsDefaultVO searchVO) {
    	return list("cropsDAO.getReport_R", searchVO);
    }
}
