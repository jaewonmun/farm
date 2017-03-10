package egovframework.farm.cpr.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.cpr.service.CprVO;
import egovframework.farm.cpr.service.CprDefaultVO;

/**
 * @Class Name : CprDAO.java
 * @Description : Cpr DAO Class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cprDAO")
public class CprDAO extends EgovComAbstractDAO {

	/**
	 * CPR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CprVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCpr(CprVO vo) throws Exception {
        return (String)insert("cprDAO.insertCpr_S", vo);
    }

    /**
	 * CPR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CprVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCpr(CprVO vo) throws Exception {
        update("cprDAO.updateCpr_S", vo);
    }

    /**
	 * CPR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CprVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCpr(CprVO vo) throws Exception {
        delete("cprDAO.deleteCpr_S", vo);
    }

    /**
	 * CPR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CprVO
	 * @return 조회한 CPR
	 * @exception Exception
	 */
    public CprVO selectCpr(CprVO vo) throws Exception {
        return (CprVO) select("cprDAO.selectCpr_S", vo);
    }

    /**
	 * CPR 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CPR 목록
	 * @exception Exception
	 */
    public List<?> selectCprList(CprDefaultVO searchVO) throws Exception {
        return list("cprDAO.selectCprList_D", searchVO);
    }
    
    public List<?> selectMRKT(CprDefaultVO searchVO) throws Exception {
        return list("cprDAO.selectMRKT_D", searchVO);
    }
    
    public List<?> selectCPR(CprVO vo) throws Exception {
        return list("cprDAO.selectCPR_D", vo);
    }
    
    /**
	 * CPR 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CPR 총 갯수
	 * @exception
	 */
    public int selectCprListTotCnt(CprDefaultVO searchVO) {
        return (Integer)select("cprDAO.selectCprListTotCnt_S", searchVO);
    }
    
}
