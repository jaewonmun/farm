package egovframework.farm.cpr.service;

/**
 * @Class Name : CprVO.java
 * @Description : Cpr VO class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CprVO extends CprDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** WHSAL_MRKT_CD */
    private java.lang.String WHSAL_MRKT_CD;
    
    /** WHSAL_MRKT_NM */
    private java.lang.String WHSAL_MRKT_NM;
    
    /** CPR_CD */
    private java.lang.String CPR_CD;
    
    /** CPR_NM */
    private java.lang.String CPR_NM;
    
    public java.lang.String getWhsalMrktCd() {
        return this.WHSAL_MRKT_CD;
    }
    
    public void setWhsalMrktCd(java.lang.String WHSAL_MRKT_CD) {
        this.WHSAL_MRKT_CD = WHSAL_MRKT_CD;
    }
    
    public java.lang.String getWhsalMrktNm() {
        return this.WHSAL_MRKT_NM;
    }
    
    public void setWhsalMrktNm(java.lang.String WHSAL_MRKT_NM) {
        this.WHSAL_MRKT_NM = WHSAL_MRKT_NM;
    }
    
    public java.lang.String getCprCd() {
        return this.CPR_CD;
    }
    
    public void setCprCd(java.lang.String CPR_CD) {
        this.CPR_CD = CPR_CD;
    }
    
    public java.lang.String getCprNm() {
        return this.CPR_NM;
    }
    
    public void setCprNm(java.lang.String CPR_NM) {
        this.CPR_NM = CPR_NM;
    }

	@Override
	public String toString() {
		return "CprVO ['WHSAL_MRKT_CD'='" + WHSAL_MRKT_CD + "', 'WHSAL_MRKT_NM'='"
				+ WHSAL_MRKT_NM + "', 'CPR_CD'='" + CPR_CD + "', 'CPR_NM'='" + CPR_NM
				+ "']";
	}
    
}
