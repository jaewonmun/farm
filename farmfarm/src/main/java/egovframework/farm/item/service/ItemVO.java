package egovframework.farm.item.service;

/**
 * @Class Name : ItemVO.java
 * @Description : Item VO class
 * @Modification Information
 *
 * @author 박석현
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ItemVO extends ItemDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** selectLCODE */
    private java.lang.String selectItemL;
    
    /** selectMCODE */
    private java.lang.String selectItemM;
    
    /** selectSCODE */
    private java.lang.String selectItemS;
    
    /** ITEM_CODE */
    private java.math.BigDecimal itemCode;
    
    /** CREA_DATE */
    private java.sql.Date creaDate;
    
    /** LCODE */
    private java.lang.String lcode;
    
    /** MCODE */
    private java.lang.String mcode;
    
    /** SCODE */
    private java.lang.String scode;
    
    /** BRAND_NAME */
    private java.lang.String brandName;
    
    /** REMARK */
    private java.lang.String remark;
    
    public java.lang.String getSelectItemL() {
		return selectItemL;
	}

	public void setSelectItemL(java.lang.String selectItemL) {
		this.selectItemL = selectItemL;
	}

	public java.lang.String getSelectItemM() {
		return selectItemM;
	}

	public void setSelectItemM(java.lang.String selectItemM) {
		this.selectItemM = selectItemM;
	}

	public java.lang.String getSelectItemS() {
		return selectItemS;
	}

	public void setSelectItemS(java.lang.String selectItemS) {
		this.selectItemS = selectItemS;
	}

	public java.math.BigDecimal getItemCode() {
        return this.itemCode;
    }
    
    public void setItemCode(java.math.BigDecimal itemCode) {
        this.itemCode = itemCode;
    }
    
    public java.sql.Date getCreaDate() {
        return this.creaDate;
    }
    
    public void setCreaDate(java.sql.Date creaDate) {
        this.creaDate = creaDate;
    }
    
    public java.lang.String getLcode() {
        return this.lcode;
    }
    
    public void setLcode(java.lang.String lcode) {
        this.lcode = lcode;
    }
    
    public java.lang.String getMcode() {
        return this.mcode;
    }
    
    public void setMcode(java.lang.String mcode) {
        this.mcode = mcode;
    }
    
    public java.lang.String getScode() {
        return this.scode;
    }
    
    public void setScode(java.lang.String scode) {
        this.scode = scode;
    }
    
    public java.lang.String getBrandName() {
        return this.brandName;
    }
    
    public void setBrandName(java.lang.String brandName) {
        this.brandName = brandName;
    }
    
    public java.lang.String getRemark() {
        return this.remark;
    }
    
    public void setRemark(java.lang.String remark) {
        this.remark = remark;
    }

	@Override
	public String toString() {
		return "ItemVO [selectItemL=" + selectItemL + ", selectItemM="
				+ selectItemM + ", selectItemS=" + selectItemS + ", itemCode="
				+ itemCode + ", creaDate=" + creaDate + ", lcode=" + lcode
				+ ", mcode=" + mcode + ", scode=" + scode + ", brandName="
				+ brandName + ", remark=" + remark + "]";
	}
    
    
    
}
