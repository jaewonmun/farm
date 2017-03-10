package egovframework.farm.eq.service;

import java.util.List;

import egovframework.farm.eq.service.EquipmentDefaultVO;
import egovframework.farm.eq.service.EquipmentVO;

/**
 * @Class Name : EquipmentService.java
 * @Description : Equipment Business class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161123
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EquipmentService {
	
	/**
	 * EQUIPMENT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertEquipment(EquipmentVO vo) throws Exception;
    
    /**
	 * EQUIPMENT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentVO
	 * @return void형
	 * @exception Exception
	 */
    void updateEquipment(EquipmentVO vo) throws Exception;
    
    /**
	 * EQUIPMENT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteEquipment(EquipmentVO vo) throws Exception;
    
    /**
	 * EQUIPMENT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentVO
	 * @return 조회한 EQUIPMENT
	 * @exception Exception
	 */
    EquipmentVO selectEquipment(EquipmentVO vo) throws Exception;
    
    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
    List selectEquipmentList(EquipmentDefaultVO searchVO) throws Exception;
    
    /**
	 * EQUIPMENT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT 총 갯수
	 * @exception
	 */
    int selectEquipmentListTotCnt(EquipmentDefaultVO searchVO);
    
    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
     List comboEquipmentList(EquipmentDefaultVO searchVO) throws Exception;
}
