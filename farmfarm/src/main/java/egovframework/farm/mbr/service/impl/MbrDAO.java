package egovframework.farm.mbr.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.mbr.service.MbrDefaultVO;
import egovframework.farm.mbr.service.MbrVO;

/**
 * @Class Name : MbrDAO.java
 * @Description : Mbr DAO Class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("mbrDAO")
public class MbrDAO extends EgovComAbstractDAO {

	/**
	 * MBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMbr(MbrVO vo) throws Exception {
    	System.out.println(vo.getMbrId());
    	System.out.println(vo.getRegion());
        return (String)insert("mbrDAO.insertMbr_S", vo);
    }

    /**
	 * MBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMbr(MbrVO vo) throws Exception {
        update("mbrDAO.updateMbr_S", vo);
    }

    /**
	 * MBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMbr(MbrVO vo) throws Exception {
        delete("mbrDAO.deleteMbr_S", vo);
    }

    /**
	 * MBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
    public MbrVO selectMbr(MbrVO vo) throws Exception {
        return (MbrVO) select("mbrDAO.selectMbr_S", vo);
    }

    /**
	 * MBR 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MBR 목록
	 * @exception Exception
	 */
    public List<?> selectMbrList(MbrDefaultVO searchVO) throws Exception {
        return list("mbrDAO.selectMbrList_D", searchVO);
    }

    /**
	 * MBR 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MBR 총 갯수
	 * @exception
	 */
    public int selectMbrListTotCnt(MbrDefaultVO searchVO) {
        return (Integer)select("mbrDAO.selectMbrListTotCnt_S", searchVO);
    }
    /**
     *  로그인 체크를 한다
     *  @param 아이디, 패스워드
     *  @return 조회 건수 COUNT
     */
    public int selectLogin(MbrVO vo) {
    	return (Integer)select("mbrDAO.selectLogin",vo);
    }
    /**
     *  ID 중복체크를 한다
     *  @param 아이디
     *  @return 조회 건수 COUNT
     */
    public int idCheck(MbrVO vo) {
    	return (Integer)select("mbrDAO.idCheck",vo);	
    }
    
    /**
	 * MBR을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
    public MbrVO selectgetReport(MbrVO vo) throws Exception {
        return (MbrVO) select("mbrDAO.selectgetReport_S", vo);
    }
}
