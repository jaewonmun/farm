package egovframework.farm.mbr.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.farm.mbr.service.MbrDefaultVO;
import egovframework.farm.mbr.service.MbrService;
import egovframework.farm.mbr.service.MbrVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : MbrServiceImpl.java
 * @Description : Mbr Business Implement class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("mbrService")
public class MbrServiceImpl extends EgovAbstractServiceImpl implements
        MbrService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MbrServiceImpl.class);

    @Resource(name="mbrDAO")
    private MbrDAO mbrDAO;
    
    /** ID Generation */
    //@Resource(name="{egovMbrIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * MBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMbr(MbrVO vo) throws Exception {
    	String enpassword = EgovFileScrty.encryptPassword(vo.getPassword(), vo.getMbrId());
		vo.setPassword(enpassword);
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	mbrDAO.insertMbr(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * MBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMbr(MbrVO vo) throws Exception {
        mbrDAO.updateMbr(vo);
    }

    /**
	 * MBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMbr(MbrVO vo) throws Exception {
        mbrDAO.deleteMbr(vo);
    }

    /**
	 * MBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
    public MbrVO selectMbr(MbrVO vo) throws Exception {
        MbrVO resultVO = mbrDAO.selectMbr(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * MBR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MBR 목록
	 * @exception Exception
	 */
    public List<?> selectMbrList(MbrDefaultVO searchVO) throws Exception {
        return mbrDAO.selectMbrList(searchVO);
    }

    /**
	 * MBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MBR 총 갯수
	 * @exception
	 */
    public int selectMbrListTotCnt(MbrDefaultVO searchVO) {
		return mbrDAO.selectMbrListTotCnt(searchVO);
	}

	@Override
	public int selectLogin(MbrVO vo) {
		// TODO Auto-generated method stub
		return mbrDAO.selectLogin(vo);
	}

	@Override
	public int idCheck(MbrVO vo) {
		// TODO Auto-generated method stub
		return mbrDAO.idCheck(vo);
	}

	/**
	 * MBR을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 MbrVO
	 * @return 조회한 MBR
	 * @exception Exception
	 */
	@Override
	public MbrVO selectgetReport(MbrVO vo) throws Exception {
		MbrVO resultVO = mbrDAO.selectgetReport(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
	}
	
	
}
