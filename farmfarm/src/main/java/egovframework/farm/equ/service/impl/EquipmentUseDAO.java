package egovframework.farm.equ.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.equ.service.EquipmentUseDefaultVO;
import egovframework.farm.equ.service.EquipmentUseVO;

/**
 * @Class Name : EquipmentUseDAO.java
 * @Description : EquipmentUse DAO Class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("equipmentUseDAO")
public class EquipmentUseDAO extends EgovComAbstractDAO {

	/**
	 * EQUIPMENT_USE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentUseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertEquipmentUse(EquipmentUseVO vo) throws Exception {
        return (String)insert("equipmentUseDAO.insertEquipmentUse_S", vo);
    }

    /**
	 * EQUIPMENT_USE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentUseVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateEquipmentUse(EquipmentUseVO vo) throws Exception {
        update("equipmentUseDAO.updateEquipmentUse_S", vo);
    }

    /**
	 * EQUIPMENT_USE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentUseVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteEquipmentUse(EquipmentUseVO vo) throws Exception {
        delete("equipmentUseDAO.deleteEquipmentUse_S", vo);
    }

    /**
	 * EQUIPMENT_USE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    public EquipmentUseVO selectEquipmentUse(EquipmentUseVO vo) throws Exception {
        return (EquipmentUseVO) select("equipmentUseDAO.selectEquipmentUse_S", vo);
    }

    /**
	 * EQUIPMENT_USE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT_USE 목록
	 * @exception Exception
	 */
    public List<?> selectEquipmentUseList(EquipmentUseDefaultVO searchVO) throws Exception {
        return list("equipmentUseDAO.selectEquipmentUseList_D", searchVO);
    }

    /**
	 * EQUIPMENT_USE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT_USE 총 갯수
	 * @exception
	 */
    public int selectEquipmentUseListTotCnt(EquipmentUseDefaultVO searchVO) {
        return (Integer)select("equipmentUseDAO.selectEquipmentUseListTotCnt_S", searchVO);
    }
    
    /**
	 * EQUIPMENT_USE을 조회한다(리포트).
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    public EquipmentUseVO selectequipmentReport(EquipmentUseVO vo) throws Exception {
        return (EquipmentUseVO) select("equipmentUseDAO.selectequipmentReport_S", vo);
    }

    /**
	 * EQUIPMENT_USE 통계정보 조회
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    public List<?> selectEquipmentUseSum(EquipmentUseDefaultVO searchVO) throws Exception {
        return list("equipmentUseDAO.selectEquipmentUseSum", searchVO);
    }
    
}
