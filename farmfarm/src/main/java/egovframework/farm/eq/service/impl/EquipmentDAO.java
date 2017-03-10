package egovframework.farm.eq.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.eq.service.EquipmentVO;
import egovframework.farm.eq.service.EquipmentDefaultVO;

/**
 * @Class Name : EquipmentDAO.java
 * @Description : Equipment DAO Class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161123
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("equipmentDAO")
public class EquipmentDAO extends EgovComAbstractDAO {

	/**
	 * EQUIPMENT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertEquipment(EquipmentVO vo) throws Exception {
        return (String)insert("equipmentDAO.insertEquipment_S", vo);
    }

    /**
	 * EQUIPMENT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateEquipment(EquipmentVO vo) throws Exception {
        update("equipmentDAO.updateEquipment_S", vo);
    }

    /**
	 * EQUIPMENT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteEquipment(EquipmentVO vo) throws Exception {
        delete("equipmentDAO.deleteEquipment_S", vo);
    }

    /**
	 * EQUIPMENT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentVO
	 * @return 조회한 EQUIPMENT
	 * @exception Exception
	 */
    public EquipmentVO selectEquipment(EquipmentVO vo) throws Exception {
        return (EquipmentVO) select("equipmentDAO.selectEquipment_S", vo);
    }

    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
    public List<?> selectEquipmentList(EquipmentDefaultVO searchVO) throws Exception {
        return list("equipmentDAO.selectEquipmentList_D", searchVO);
    }

    /**
	 * EQUIPMENT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT 총 갯수
	 * @exception
	 */
    public int selectEquipmentListTotCnt(EquipmentDefaultVO searchVO) {
        return (Integer)select("equipmentDAO.selectEquipmentListTotCnt_S", searchVO);
    }
    
    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
    public List<?> comboEquipmentList(EquipmentDefaultVO searchVO) throws Exception {
        return list("equipmentDAO.comboEquipmentList_D", searchVO);
    }
}
