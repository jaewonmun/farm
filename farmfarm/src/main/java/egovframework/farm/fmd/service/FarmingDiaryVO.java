package egovframework.farm.fmd.service;

/**
 * @Class Name : FarmingDiaryVO.java
 * @Description : FarmingDiary VO class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class FarmingDiaryVO extends FarmingDiaryDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** JOIN ITEM SCODE(NAME) */
    private java.lang.String scode;
    
    public java.lang.String getScode() {
		return scode;
	}

	public void setScode(java.lang.String scode) {
		this.scode = scode;
	}

	/** FARMING_DIARY_SEQ */
    private java.math.BigDecimal farmingDiarySeq;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** ITEM_CODE */
    private java.math.BigDecimal itemCode;
    
    /** DIARY_DATE */
    private java.lang.String diaryDate;
    
    /** DIARY_SUBJECT */
    private java.lang.String diarySubject;
    
    /** DIARY_CONTENT */
    private java.lang.String diaryContent;
    
    
    /** DIARY_UPLOAD_FILE */
    private java.lang.String diaryUploadFile;
    
    /** DIARY_UPLOAD_FILE */
    private java.lang.String diaryUploadFileOriginal;
    
    /** WEATHER_STATUS */
    private java.lang.String weatherStatus;
    
    public java.lang.String getDiaryUploadFileOriginal() {
		return diaryUploadFileOriginal;
	}

	public void setDiaryUploadFileOriginal(java.lang.String diaryUploadFileOriginal) {
		this.diaryUploadFileOriginal = diaryUploadFileOriginal;
	}

	public java.math.BigDecimal getFarmingDiarySeq() {
        return this.farmingDiarySeq;
    }
    
    public void setFarmingDiarySeq(java.math.BigDecimal farmingDiarySeq) {
        this.farmingDiarySeq = farmingDiarySeq;
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
    
    public java.lang.String getDiaryDate() {
        return this.diaryDate;
    }
    
    public void setDiaryDate(java.lang.String diaryDate) {
        this.diaryDate = diaryDate;
    }
    
    public java.lang.String getDiarySubject() {
        return this.diarySubject;
    }
    
    public void setDiarySubject(java.lang.String diarySubject) {
        this.diarySubject = diarySubject;
    }
    
    public java.lang.String getDiaryContent() {
        return this.diaryContent;
    }
    
    public void setDiaryContent(java.lang.String diaryContent) {
        this.diaryContent = diaryContent;
    }
    
    public java.lang.String getDiaryUploadFile() {
        return this.diaryUploadFile;
    }
    
    public void setDiaryUploadFile(java.lang.String diaryUploadFile) {
        this.diaryUploadFile = diaryUploadFile;
    }
    
    public java.lang.String getWeatherStatus() {
        return this.weatherStatus;
    }
    
    public void setWeatherStatus(java.lang.String weatherStatus) {
        this.weatherStatus = weatherStatus;
    }

    
}
