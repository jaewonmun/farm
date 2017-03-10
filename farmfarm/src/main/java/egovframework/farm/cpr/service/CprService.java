package egovframework.farm.cpr.service;

import java.util.List;

import egovframework.farm.cpr.service.CprDefaultVO;
import egovframework.farm.cpr.service.CprVO;

/**
 * @Class Name : CprService.java
 * @Description : Cpr Business class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CprService {
	
	/**
	 * CPR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CprVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertCpr(CprVO vo) throws Exception;
    
    /**
	 * CPR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CprVO
	 * @return void형
	 * @exception Exception
	 */
    void updateCpr(CprVO vo) throws Exception;
    
    /**
	 * CPR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CprVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteCpr(CprVO vo) throws Exception;
    
    /**
	 * CPR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CprVO
	 * @return 조회한 CPR
	 * @exception Exception
	 */
    CprVO selectCpr(CprVO vo) throws Exception;
    
    /**
	 * CPR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CPR 목록
	 * @exception Exception
	 */
    List selectCprList(CprDefaultVO searchVO) throws Exception;
    List selectMRKT(CprDefaultVO searchVO) throws Exception;
    List selectCPR(CprVO vo) throws Exception;
    /**
	 * CPR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CPR 총 갯수
	 * @exception
	 */
    int selectCprListTotCnt(CprDefaultVO searchVO);
    
}
