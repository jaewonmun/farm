package egovframework.farm.eq.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.eq.service.EquipmentService;
import egovframework.farm.eq.service.EquipmentDefaultVO;
import egovframework.farm.eq.service.EquipmentVO;
import egovframework.farm.eq.service.impl.EquipmentDAO;

/**
 * @Class Name : EquipmentServiceImpl.java
 * @Description : Equipment Business Implement class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161123
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("equipmentService")
public class EquipmentServiceImpl extends EgovAbstractServiceImpl implements
        EquipmentService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(EquipmentServiceImpl.class);

    @Resource(name="equipmentDAO")
    private EquipmentDAO equipmentDAO;
    
    /** ID Generation */
    //@Resource(name="{egovEquipmentIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * EQUIPMENT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 EquipmentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertEquipment(EquipmentVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	equipmentDAO.insertEquipment(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * EQUIPMENT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 EquipmentVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateEquipment(EquipmentVO vo) throws Exception {
        equipmentDAO.updateEquipment(vo);
    }

    /**
	 * EQUIPMENT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 EquipmentVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteEquipment(EquipmentVO vo) throws Exception {
        equipmentDAO.deleteEquipment(vo);
    }

    /**
	 * EQUIPMENT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 EquipmentVO
	 * @return 조회한 EQUIPMENT
	 * @exception Exception
	 */
    public EquipmentVO selectEquipment(EquipmentVO vo) throws Exception {
        EquipmentVO resultVO = equipmentDAO.selectEquipment(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
    public List<?> selectEquipmentList(EquipmentDefaultVO searchVO) throws Exception {
        return equipmentDAO.selectEquipmentList(searchVO);
    }

    /**
	 * EQUIPMENT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return EQUIPMENT 총 갯수
	 * @exception
	 */
    public int selectEquipmentListTotCnt(EquipmentDefaultVO searchVO) {
		return equipmentDAO.selectEquipmentListTotCnt(searchVO);
	}
    
    /**
	 * EQUIPMENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return EQUIPMENT 목록
	 * @exception Exception
	 */
    public List<?> comboEquipmentList(EquipmentDefaultVO searchVO) throws Exception {
        return equipmentDAO.comboEquipmentList(searchVO);
    }
}
