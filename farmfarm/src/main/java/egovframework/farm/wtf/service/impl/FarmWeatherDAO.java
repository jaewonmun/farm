package egovframework.farm.wtf.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.wtf.service.FarmWeatherDefaultVO;
import egovframework.farm.wtf.service.FarmWeatherVO;

/**
 * @Class Name : FarmWeatherDAO.java
 * @Description : FarmWeather DAO Class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161207
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("farmWeatherDAO")
public class FarmWeatherDAO extends EgovComAbstractDAO {
	
	/**
   	 * FARM_WEATHER을 등록하는 프로시저를 호출한다.
   	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
   	 * @return 등록 결과
   	 * @exception Exception
   	 */
	public String procedureWeather(FarmWeatherVO vo) throws Exception {
        return (String)insert("farmWeatherDAO.procedureWeather", vo);
    }
	
	/**
	 * FARM_WEATHER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertFarmWeather(FarmWeatherVO vo) throws Exception {
        return (String)insert("farmWeatherDAO.insertFarmWeather_S", vo);
    }
    

    /**
	 * FARM_WEATHER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmWeatherVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateFarmWeather(FarmWeatherVO vo) throws Exception {
        update("farmWeatherDAO.updateFarmWeather_S", vo);
    }

    /**
	 * FARM_WEATHER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmWeatherVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteFarmWeather(FarmWeatherVO vo) throws Exception {
        delete("farmWeatherDAO.deleteFarmWeather_S", vo);
    }

    /**
	 * FARM_WEATHER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
    public FarmWeatherVO selectFarmWeather(FarmWeatherVO vo) throws Exception {
        return (FarmWeatherVO) select("farmWeatherDAO.selectFarmWeather_S", vo);
    }

    /**
	 * FARM_WEATHER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return FARM_WEATHER 목록
	 * @exception Exception
	 */
    public List<?> selectFarmWeatherList(Map<String, String> commandMap) throws Exception {
        return list("farmWeatherDAO.selectFarmWeatherList_D", commandMap);
    }

    /**
	 * FARM_WEATHER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return FARM_WEATHER 총 갯수
	 * @exception
	 */
    public int selectFarmWeatherListTotCnt(FarmWeatherDefaultVO searchVO) {
        return (Integer)select("farmWeatherDAO.selectFarmWeatherListTotCnt_S", searchVO);
    }
    
    /**
	 * FARM_WEATHER을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
    public FarmWeatherVO selectweatherReport(FarmWeatherVO vo) throws Exception {
        return (FarmWeatherVO) select("farmWeatherDAO.selectweatherReport_S", vo);
    }

}
