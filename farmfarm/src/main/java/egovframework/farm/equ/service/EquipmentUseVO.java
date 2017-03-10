package egovframework.farm.equ.service;

/**
 * @Class Name : EquipmentUseVO.java
 * @Description : EquipmentUse VO class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class EquipmentUseVO extends EquipmentUseDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** EQUIPMENT_ID */
    private java.math.BigDecimal equipmentId;
    
    /** CATEGORY */
    private java.lang.String category; 
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** EQUIPMENT_USE_DATE */
    private java.sql.Date equipmentUseDate;
    
    /** EQUIPMENT_QUANTITY */
    private java.math.BigDecimal equipmentQuantity;
    
    /** EQUIPMENT_UNIT */
    private java.lang.String equipmentUnit;
    
    /** EQUIPMENT_PRICE */
    private java.math.BigDecimal equipmentPrice;
    
    /** equipmentUsePk */
    private java.math.BigDecimal equipmentUsePk;
    
    /** EQUIPMENT_NAME */
    private java.lang.String equipmentName;
    
    
    
    
    public java.lang.String getEquipmentName() {
		return equipmentName;
	}

	public void setEquipmentName(java.lang.String equipmentName) {
		this.equipmentName = equipmentName;
	}

	public java.math.BigDecimal getEquipmentUsePk() {
		return equipmentUsePk;
	}

	public void setEquipmentUsePk(java.math.BigDecimal equipmentUsePk) {
		this.equipmentUsePk = equipmentUsePk;
	}

	public java.math.BigDecimal getEquipmentId() {
        return this.equipmentId;
    }
    
    public void setEquipmentId(java.math.BigDecimal equipmentId) {
        this.equipmentId = equipmentId;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.sql.Date getEquipmentUseDate() {
        return this.equipmentUseDate;
    }
    
    public void setEquipmentUseDate(java.sql.Date equipmentUseDate) {
        this.equipmentUseDate = equipmentUseDate;
    }
    
    public java.math.BigDecimal getEquipmentQuantity() {
        return this.equipmentQuantity;
    }
    
    public void setEquipmentQuantity(java.math.BigDecimal equipmentQuantity) {
        this.equipmentQuantity = equipmentQuantity;
    }
    
    public java.lang.String getEquipmentUnit() {
        return this.equipmentUnit;
    }
    
    public void setEquipmentUnit(java.lang.String equipmentUnit) {
        this.equipmentUnit = equipmentUnit;
    }
    
    public java.math.BigDecimal getEquipmentPrice() {
        return this.equipmentPrice;
    }
    
    public void setEquipmentPrice(java.math.BigDecimal equipmentPrice) {
        this.equipmentPrice = equipmentPrice;
    }

	public java.lang.String getCategory() {
		return category;
	}

	public void setCategory(java.lang.String category) {
		this.category = category;
	}
    
}
