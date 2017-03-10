package egovframework.farm.mbr.service;

import java.util.List;

import egovframework.farm.mbr.service.MbrDefaultVO;
import egovframework.farm.mbr.service.MbrVO;

/**
 * @Class Name : MbrService.java
 * @Description : Mbr Business class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MbrService {
	
	/**
	 * MBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertMbr(MbrVO vo) throws Exception;
    
    /**
	 * MBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MbrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMbr(MbrVO vo) throws Exception;
    
    /**
	 * MBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MbrVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteMbr(MbrVO vo) throws Exception;
    
    /**
	 * MBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
    MbrVO selectMbr(MbrVO vo) throws Exception;
    
    /**
	 * MBR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MBR 목록
	 * @exception Exception
	 */
    List selectMbrList(MbrDefaultVO searchVO) throws Exception;
    
    /**
	 * MBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MBR 총 갯수
	 * @exception
	 */
    int selectMbrListTotCnt(MbrDefaultVO searchVO);
    
    /**
     *  로그인 체크를 한다
     *  @param 아이디, 패스워드
     *  @return 조회 건수 COUNT
     */
    public int selectLogin(MbrVO vo);
    /**
     * 회원가입시 id중복체크
     * @param vo
     * @return 조회 건수 COUNT
     */
    public int idCheck(MbrVO vo);
    
    /**
	 * MBR을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
    MbrVO selectgetReport(MbrVO vo) throws Exception;
    
}
