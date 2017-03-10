package egovframework.farm.wtf.service;

/**
 * @Class Name : FarmWeatherVO.java
 * @Description : FarmWeather VO class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161207
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class FarmWeatherVO extends FarmWeatherDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** WEATHER_DATE */
    private java.lang.String weatherDate;
    
    /** WEATHER_STATUS */
    private java.lang.String weatherStatus;
    
    /** LOWEST_TEMP */
    private java.math.BigDecimal lowestTemp;
    
    /** HIGHEST_TEMP */
    private java.math.BigDecimal highestTemp;
    
    /** RAINFALL */
    private java.math.BigDecimal rainfall;
    
    /** SNOWFALL */
    private java.math.BigDecimal snowfall;
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getWeatherDate() {
        return this.weatherDate;
    }
    
    public void setWeatherDate(java.lang.String weatherDate) {
        this.weatherDate = weatherDate;
    }
    
    public java.lang.String getWeatherStatus() {
        return this.weatherStatus;
    }
    
    public void setWeatherStatus(java.lang.String weatherStatus) {
        this.weatherStatus = weatherStatus;
    }
    
    public java.math.BigDecimal getLowestTemp() {
        return this.lowestTemp;
    }
    
    public void setLowestTemp(java.math.BigDecimal lowestTemp) {
        this.lowestTemp = lowestTemp;
    }
    
    public java.math.BigDecimal getHighestTemp() {
        return this.highestTemp;
    }
    
    public void setHighestTemp(java.math.BigDecimal highestTemp) {
        this.highestTemp = highestTemp;
    }
    
    public java.math.BigDecimal getRainfall() {
        return this.rainfall;
    }
    
    public void setRainfall(java.math.BigDecimal rainfall) {
        this.rainfall = rainfall;
    }
    
    public java.math.BigDecimal getSnowfall() {
        return this.snowfall;
    }
    
    public void setSnowfall(java.math.BigDecimal snowfall) {
        this.snowfall = snowfall;
    }
    
}
