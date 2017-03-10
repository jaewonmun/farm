package egovframework.farm.wtf.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.wtf.service.FarmWeatherService;
import egovframework.farm.wtf.service.FarmWeatherDefaultVO;
import egovframework.farm.wtf.service.FarmWeatherVO;
import egovframework.farm.wtf.service.impl.FarmWeatherDAO;

/**
 * @Class Name : FarmWeatherServiceImpl.java
 * @Description : FarmWeather Business Implement class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161207
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("farmWeatherService")
public class FarmWeatherServiceImpl extends EgovAbstractServiceImpl implements
        FarmWeatherService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(FarmWeatherServiceImpl.class);

    @Resource(name="farmWeatherDAO")
    private FarmWeatherDAO farmWeatherDAO;
    
    /** ID Generation */
    //@Resource(name="{egovFarmWeatherIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    /**
   	 * FARM_WEATHER을 등록하는 프로시저를 호출한다.
   	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
   	 * @return 등록 결과
   	 * @exception Exception
   	 */
       public String procedureWeather(FarmWeatherVO vo) throws Exception {
       	LOGGER.debug(vo.toString());
       	farmWeatherDAO.procedureWeather(vo);
       	return null;
       }
       
	/**
	 * FARM_WEATHER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertFarmWeather(FarmWeatherVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	farmWeatherDAO.insertFarmWeather(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * FARM_WEATHER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmWeatherVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateFarmWeather(FarmWeatherVO vo) throws Exception {
        farmWeatherDAO.updateFarmWeather(vo);
    }

    /**
	 * FARM_WEATHER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmWeatherVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteFarmWeather(FarmWeatherVO vo) throws Exception {
        farmWeatherDAO.deleteFarmWeather(vo);
    }

    /**
	 * FARM_WEATHER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
    public FarmWeatherVO selectFarmWeather(FarmWeatherVO vo) throws Exception {
        FarmWeatherVO resultVO = farmWeatherDAO.selectFarmWeather(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * FARM_WEATHER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARM_WEATHER 목록
	 * @exception Exception
	 */
    public List<?> selectFarmWeatherList(Map<String, String> commandMap) throws Exception {
        return farmWeatherDAO.selectFarmWeatherList(commandMap);
    }

    /**
	 * FARM_WEATHER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARM_WEATHER 총 갯수
	 * @exception
	 */
    public int selectFarmWeatherListTotCnt(FarmWeatherDefaultVO searchVO) {
		return farmWeatherDAO.selectFarmWeatherListTotCnt(searchVO);
	}

    /**
	 * FARM_WEATHER을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
	@Override
	public FarmWeatherVO selectweatherReport(FarmWeatherVO vo) throws Exception {
		FarmWeatherVO resultVO = farmWeatherDAO.selectweatherReport(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
	}
    
}
