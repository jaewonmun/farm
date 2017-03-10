package egovframework.farm.job.service;

/**
 * @Class Name : JobProcessVO.java
 * @Description : JobProcess VO class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JobProcessVO extends JobProcessDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** JOB_SEQ */
    private java.math.BigDecimal jobSeq;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** ITEM_CODE */
    private java.math.BigDecimal itemCode;
    
    /** FARMING_PROCESS */
    private java.lang.String farmingProcess;
    
    /** JOB_PROCESS */
    private java.lang.String jobProcess;
    
    public java.math.BigDecimal getJobSeq() {
        return this.jobSeq;
    }
    
    public void setJobSeq(java.math.BigDecimal jobSeq) {
        this.jobSeq = jobSeq;
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
    
    public java.lang.String getFarmingProcess() {
        return this.farmingProcess;
    }
    
    public void setFarmingProcess(java.lang.String farmingProcess) {
        this.farmingProcess = farmingProcess;
    }
    
    public java.lang.String getJobProcess() {
        return this.jobProcess;
    }
    
    public void setJobProcess(java.lang.String jobProcess) {
        this.jobProcess = jobProcess;
    }
    
}
