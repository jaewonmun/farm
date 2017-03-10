package egovframework.farm.equ.service.impl;

import java.util.List;

import egovframework.farm.equ.service.EquipmentUseDefaultVO;
import egovframework.farm.equ.service.EquipmentUseVO;

/**
 * @Class Name : EquipmentUseService.java
 * @Description : EquipmentUse Business class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EquipmentUseService {
	
	/**
	 * EQUIPMENT_USE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentUseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertEquipmentUse(EquipmentUseVO vo) throws Exception;
    
    /**
	 * EQUIPMENT_USE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentUseVO
	 * @return void형
	 * @exception Exception
	 */
    void updateEquipmentUse(EquipmentUseVO vo) throws Exception;
    
    /**
	 * EQUIPMENT_USE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentUseVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteEquipmentUse(EquipmentUseVO vo) throws Exception;
    
    /**
	 * EQUIPMENT_USE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    EquipmentUseVO selectEquipmentUse(EquipmentUseVO vo) throws Exception;
    
    /**
	 * EQUIPMENT_USE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT_USE 목록
	 * @exception Exception
	 */
    List selectEquipmentUseList(EquipmentUseDefaultVO searchVO) throws Exception;
    
    /**
	 * EQUIPMENT_USE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT_USE 총 갯수
	 * @exception
	 */
    int selectEquipmentUseListTotCnt(EquipmentUseDefaultVO searchVO);
    
    /**
	 * EQUIPMENT_USE을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    EquipmentUseVO selectequipmentReport(EquipmentUseVO vo) throws Exception;
	
	  /**
		 * EQUIPMENT_USE 통계정보 조회
		 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
		 * @return 조회한 EQUIPMENT_USE
		 * @exception Exception
		 */
   List selectEquipmentUseSum(EquipmentUseDefaultVO searchVO) throws Exception;
}