package egovframework.farm.eq.service;

/**
 * @Class Name : EquipmentVO.java
 * @Description : Equipment VO class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161123
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class EquipmentVO extends EquipmentDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** EQUIPMENT_ID */
    private java.lang.String equipmentId;
    
    /** CATEGORY */
    private java.lang.String category;
    
    /** EQUIPMENT_NAME */
    private java.lang.String equipmentName;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    public java.lang.String getEquipmentId() {
        return this.equipmentId;
    }
    
    public void setEquipmentId(java.lang.String equipmentId) {
        this.equipmentId = equipmentId;
    }
    
    public java.lang.String getCategory() {
        return this.category;
    }
    
    public void setCategory(java.lang.String category) {
        this.category = category;
    }
    
    public java.lang.String getEquipmentName() {
        return this.equipmentName;
    }
    
    public void setEquipmentName(java.lang.String equipmentName) {
        this.equipmentName = equipmentName;
    }

	public java.lang.String getMbrId() {
		return mbrId;
	}

	public void setMbrId(java.lang.String mbrId) {
		this.mbrId = mbrId;
	}
    
}
