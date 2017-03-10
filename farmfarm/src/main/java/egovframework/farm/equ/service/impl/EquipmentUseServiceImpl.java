package egovframework.farm.equ.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.farm.equ.service.EquipmentUseDefaultVO;
import egovframework.farm.equ.service.EquipmentUseVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : EquipmentUseServiceImpl.java
 * @Description : EquipmentUse Business Implement class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("equipmentUseService")
public class EquipmentUseServiceImpl extends EgovAbstractServiceImpl implements
        EquipmentUseService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(EquipmentUseServiceImpl.class);

    @Resource(name="equipmentUseDAO")
    private EquipmentUseDAO equipmentUseDAO;
    
    /** ID Generation */
    //@Resource(name="{egovEquipmentUseIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * EQUIPMENT_USE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentUseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertEquipmentUse(EquipmentUseVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	equipmentUseDAO.insertEquipmentUse(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * EQUIPMENT_USE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentUseVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateEquipmentUse(EquipmentUseVO vo) throws Exception {
        equipmentUseDAO.updateEquipmentUse(vo);
    }

    /**
	 * EQUIPMENT_USE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentUseVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteEquipmentUse(EquipmentUseVO vo) throws Exception {
        equipmentUseDAO.deleteEquipmentUse(vo);
    }

    /**
	 * EQUIPMENT_USE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
    public EquipmentUseVO selectEquipmentUse(EquipmentUseVO vo) throws Exception {
        EquipmentUseVO resultVO = equipmentUseDAO.selectEquipmentUse(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * EQUIPMENT_USE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT_USE 목록
	 * @exception Exception
	 */
    public List<?> selectEquipmentUseList(EquipmentUseDefaultVO searchVO) throws Exception {
        return equipmentUseDAO.selectEquipmentUseList(searchVO);
    }

    /**
	 * EQUIPMENT_USE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT_USE 총 갯수
	 * @exception
	 */
    public int selectEquipmentUseListTotCnt(EquipmentUseDefaultVO searchVO) {
		return equipmentUseDAO.selectEquipmentUseListTotCnt(searchVO);
	}

    /**
	 * EQUIPMENT_USE을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
	 * @return 조회한 EQUIPMENT_USE
	 * @exception Exception
	 */
	@Override
	public EquipmentUseVO selectequipmentReport(EquipmentUseVO vo)
			throws Exception {
        EquipmentUseVO resultVO = equipmentUseDAO.selectequipmentReport(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
	}
	
	  /**
		 * EQUIPMENT_USE 통계정보 조회
		 * @param vo - 조회할 정보가 담긴 EquipmentUseVO
		 * @return 조회한 EQUIPMENT_USE
		 * @exception Exception
		 */
	    public List<?> selectEquipmentUseSum(EquipmentUseDefaultVO searchVO) throws Exception {
	        return equipmentUseDAO.selectEquipmentUseSum(searchVO);
	    }
}
