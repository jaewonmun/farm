package egovframework.farm.crop.service;

/**
 * @Class Name : CropsVO.java
 * @Description : Crops VO class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CropsVO extends CropsDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** ITEM_CODE */
    private java.math.BigDecimal itemCode;
    
    /** LATITUDE */
    private java.lang.String latitude;
    
    /** LONGITUDE */
    private java.lang.String longitude;
    
    /** strokeColor */
    private java.lang.String  strokeColor;
    
    /** FILLCOLOR */
    private java.lang.String fillcolor;
    
    /** STROKESTYLE */
    private java.lang.String strokestyle;
    
    /** uploadImage */
    private java.lang.String uploadImage;
    
    /** uploadImageOriginal */
    private java.lang.String uploadImageOriginal;
    
 

	/** scode */
    private java.lang.String scode;
    
    public java.lang.String getUploadImageOriginal() {
 		return uploadImageOriginal;
 	}

 	public void setUploadImageOriginal(java.lang.String uploadImageOriginal) {
 		this.uploadImageOriginal = uploadImageOriginal;
 	}
    public java.lang.String getScode() {
		return scode;
	}

	public void setScode(java.lang.String scode) {
		this.scode = scode;
	}

	public java.lang.String getUploadImage() {
		return uploadImage;
	}

	public void setUploadImage(java.lang.String uploadImage) {
		this.uploadImage = uploadImage;
	}

	public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.math.BigDecimal getItemCode() {
        return this.itemCode;
    }
    
    public void setItemCode(java.math.BigDecimal itemCode) {
        this.itemCode = itemCode;
    }
    
    public java.lang.String getLatitude() {
        return this.latitude;
    }
    
    public void setLatitude(java.lang.String latitude) {
        this.latitude = latitude;
    }
    
    public java.lang.String getLongitude() {
        return this.longitude;
    }
    
    public void setLongitude(java.lang.String longitude) {
        this.longitude = longitude;
    }
    
    public java.lang.String getStrokeColor() {
		return strokeColor;
	}

	public void setStrokeColor(java.lang.String strokeColor) {
		this.strokeColor = strokeColor;
	}

	public java.lang.String getFillcolor() {
        return this.fillcolor;
    }
    
    public void setFillcolor(java.lang.String fillcolor) {
        this.fillcolor = fillcolor;
    }
    
    public java.lang.String getStrokestyle() {
        return this.strokestyle;
    }
    
    public void setStrokestyle(java.lang.String strokestyle) {
        this.strokestyle = strokestyle;
    }
    
}
