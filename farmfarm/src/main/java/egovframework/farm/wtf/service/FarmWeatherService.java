package egovframework.farm.wtf.service;

import java.util.List;
import java.util.Map;

import egovframework.farm.wtf.service.FarmWeatherDefaultVO;
import egovframework.farm.wtf.service.FarmWeatherVO;

/**
 * @Class Name : FarmWeatherService.java
 * @Description : FarmWeather Business class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161207
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface FarmWeatherService {
	
	/**
	 * FARM_WEATHER을 등록하는 프로시저를 호출한다.
	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public String procedureWeather(FarmWeatherVO vo) throws Exception;
	
	/**
	 * FARM_WEATHER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 FarmWeatherVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertFarmWeather(FarmWeatherVO vo) throws Exception;
    
    /**
	 * FARM_WEATHER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 FarmWeatherVO
	 * @return void형
	 * @exception Exception
	 */
    void updateFarmWeather(FarmWeatherVO vo) throws Exception;
    
    /**
	 * FARM_WEATHER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 FarmWeatherVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteFarmWeather(FarmWeatherVO vo) throws Exception;
    
    /**
	 * FARM_WEATHER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
    FarmWeatherVO selectFarmWeather(FarmWeatherVO vo) throws Exception;
    
    /**
	 * FARM_WEATHER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARM_WEATHER 목록
	 * @exception Exception
	 */
    List selectFarmWeatherList(Map<String, String> commandMap) throws Exception;
    
    /**
	 * FARM_WEATHER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return FARM_WEATHER 총 갯수
	 * @exception
	 */
    int selectFarmWeatherListTotCnt(FarmWeatherDefaultVO searchVO);
    
    /**
	 * FARM_WEATHER을 조회한다.(리포트)
	 * @param vo - 조회할 정보가 담긴 FarmWeatherVO
	 * @return 조회한 FARM_WEATHER
	 * @exception Exception
	 */
    FarmWeatherVO selectweatherReport(FarmWeatherVO vo) throws Exception;
    
    
}
