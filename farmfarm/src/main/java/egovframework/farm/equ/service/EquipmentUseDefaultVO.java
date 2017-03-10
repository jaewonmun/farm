package egovframework.farm.equ.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * @Class Name : EquipmentUseDefaultVO.java
 * @Description : EquipmentUse Default VO class
 * @Modification Information
 *
 * @author 김형철a
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class EquipmentUseDefaultVO implements Serializable {

	private static final long serialVersionUID = 1L;
		
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    private String searchKey = "";
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;

    /** MEMBERID */
    private java.lang.String mbrId = "";
    
    private java.lang.String equDate = "";
    
    /** category */
    
    private String category;

	/** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    private int pageIndex2 = 1;
    
    private int pageIndex3 = 1;
    
    private int pageIndex4 = 1;
    
    public String getSearchKey() {
		return searchKey;
	}

    
	public java.lang.String getEquDate() {
		return equDate;
	}


	public void setEquDate(java.lang.String equDate) {
		this.equDate = equDate;
	}


	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
    
    public int getPageIndex2() {
		return pageIndex2;
	}

	public void setPageIndex2(int pageIndex2) {
		this.pageIndex2 = pageIndex2;
	}

	public int getPageIndex3() {
		return pageIndex3;
	}

	public void setPageIndex3(int pageIndex3) {
		this.pageIndex3 = pageIndex3;
	}

	public int getPageIndex4() {
		return pageIndex4;
	}

	public void setPageIndex4(int pageIndex4) {
		this.pageIndex4 = pageIndex4;
	}

	
    


	public java.lang.String getMbrId() {
		return mbrId;
	}

	public void setMbrId(java.lang.String mbrId) {
		this.mbrId = mbrId;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
    

}
