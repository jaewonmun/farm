package egovframework.farm.mbr.service;

/**
 * @Class Name : MbrVO.java
 * @Description : Mbr VO class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MbrVO extends MbrDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** PASSWORD */
    private java.lang.String password;
    
    /** MBR_NAME */
    private java.lang.String mbrName;
    
    /** PERM */
    private java.lang.String perm;
    
    /** CREA_DATE */
    private java.sql.Date creaDate;
    
    /** ADDRESS */
    private java.lang.String address;
    
    /** REGION */
    private java.lang.String region;
    
    /** USER_CONAME */
    private java.lang.String userConame;
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getPassword() {
        return this.password;
    }
    
    public void setPassword(java.lang.String password) {
        this.password = password;
    }
    
    public java.lang.String getMbrName() {
        return this.mbrName;
    }
    
    public void setMbrName(java.lang.String mbrName) {
        this.mbrName = mbrName;
    }
    
    public java.lang.String getPerm() {
        return this.perm;
    }
    
    public void setPerm(java.lang.String perm) {
        this.perm = perm;
    }
    
    public java.sql.Date getCreaDate() {
        return this.creaDate;
    }
    
    public void setCreaDate(java.sql.Date creaDate) {
        this.creaDate = creaDate;
    }
    
    public java.lang.String getAddress() {
        return this.address;
    }
    
    public void setAddress(java.lang.String address) {
        this.address = address;
    }
    
    public java.lang.String getRegion() {
        return this.region;
    }
    
    public void setRegion(java.lang.String region) {
        this.region = region;
    }
    
    public java.lang.String getUserConame() {
        return this.userConame;
    }
    
    public void setUserConame(java.lang.String userConame) {
        this.userConame = userConame;
    }
    
}
