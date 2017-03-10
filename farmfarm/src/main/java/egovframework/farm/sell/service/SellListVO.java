package egovframework.farm.sell.service;

/**
 * @Class Name : SellListVO.java
 * @Description : SellList VO class
 * @Modification Information
 *
 * @author 문재원
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class SellListVO extends SellListDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SELL_CODE */
    private java.math.BigDecimal sellCode;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** ITEM_CODE */
    private java.lang.String itemCode;
    
    /** SELL_DATE */
    private java.lang.String sellDate;
    
    /** SUMAMT */
    private java.math.BigDecimal sumamt;
    
    /** SELL_UNIT_CODE */
    private java.lang.String sellUnitCode;
    
    /** PRICE */
    private java.math.BigDecimal price;
    
    /** CONAME */
    private java.lang.String coname;
    
    /* JOIN ITEM NAME (CODE) */
    private java.lang.String itemName;
    
    public java.lang.String getItemName() {
		return itemName;
	}

	public void setItemName(java.lang.String itemName) {
		this.itemName = itemName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public java.math.BigDecimal getSellCode() {
        return this.sellCode;
    }
    
    public void setSellCode(java.math.BigDecimal sellCode) {
        this.sellCode = sellCode;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getItemCode() {
        return this.itemCode;
    }
    
    public void setItemCode(java.lang.String itemCode) {
        this.itemCode = itemCode;
    }
    
    public java.lang.String getSellDate() {
        return this.sellDate;
    }
    
    public void setSellDate(java.lang.String sellDate) {
        this.sellDate = sellDate;
    }
    
    public java.math.BigDecimal getSumamt() {
        return this.sumamt;
    }
    
    public void setSumamt(java.math.BigDecimal sumamt) {
        this.sumamt = sumamt;
    }
    
    public java.lang.String getSellUnitCode() {
        return this.sellUnitCode;
    }
    
    public void setSellUnitCode(java.lang.String sellUnitCode) {
        this.sellUnitCode = sellUnitCode;
    }
    
    public java.math.BigDecimal getPrice() {
        return this.price;
    }
    
    public void setPrice(java.math.BigDecimal price) {
        this.price = price;
    }
    
    public java.lang.String getConame() {
        return this.coname;
    }
    
    public void setConame(java.lang.String coname) {
        this.coname = coname;
    }
    
}
