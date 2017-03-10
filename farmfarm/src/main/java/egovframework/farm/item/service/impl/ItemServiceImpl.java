package egovframework.farm.item.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.cpr.service.CprDefaultVO;
import egovframework.farm.cpr.service.CprVO;
import egovframework.farm.item.service.ItemService;
import egovframework.farm.item.service.ItemDefaultVO;
import egovframework.farm.item.service.ItemVO;
import egovframework.farm.item.service.impl.ItemDAO;

/**
 * @Class Name : ItemServiceImpl.java
 * @Description : Item Business Implement class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("itemService")
public class ItemServiceImpl extends EgovAbstractServiceImpl implements
        ItemService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ItemServiceImpl.class);

    @Resource(name="itemDAO")
    private ItemDAO itemDAO;
    
    /** ID Generation */
    //@Resource(name="{egovItemIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertItem(ItemVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	itemDAO.insertItem(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateItem(ItemVO vo) throws Exception {
        itemDAO.updateItem(vo);
    }

    /**
	 * ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteItem(ItemVO vo) throws Exception {
        itemDAO.deleteItem(vo);
    }

    /**
	 * ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemVO
	 * @return 조회한 ITEM
	 * @exception Exception
	 */
    public ItemVO selectItem(ItemVO vo) throws Exception {
        ItemVO resultVO = itemDAO.selectItem(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * ITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ITEM 목록
	 * @exception Exception
	 */
    public List<?> selectItemList(ItemDefaultVO searchVO) throws Exception {
        return itemDAO.selectItemList(searchVO);
    }

    /**
	 * ITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ITEM 총 갯수
	 * @exception
	 */
    public int selectItemListTotCnt(ItemDefaultVO searchVO) {
		return itemDAO.selectItemListTotCnt(searchVO);
	}
    
	@Override
	public List<?> selectItemL(ItemVO vo) throws Exception {
        return itemDAO.selectItemL(vo);
    }
	@Override
	public List<?> selectItemM(ItemVO vo) throws Exception {
		return itemDAO.selectItemM(vo);
	}
	@Override
	public List<?> selectItemS(ItemVO vo) throws Exception {
		return itemDAO.selectItemS(vo);
	}
    
}
