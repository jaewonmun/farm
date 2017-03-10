<?xml version="1.0" encoding="UTF-8"?>
<!-- 
	수정일                 수정자                          수정내용
  =========     =======    =================================================
  2011.9.2   	정진오     	 	FRST_REGIST_PNTTM컬럼에 FRST_REGISTER_PNTTM Alias 추가
  							SCHDUL_KND_CODE컬럼에 SCHDUL_KIND_CODE Alias 추가
  							(egovMap을 사용하는 조회 쿼리의경우)
  							DeptSchdulManage.selectDeptSchdulManageRetrieve에 SCHDUL_CHARGER_NAME 추가(Daily 조회시 필요)
  2011.10.05    서준식               보안 취약점 점검사항 반영 $->#변경	
-->
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd">

<sqlMap namespace="DeptSchdulManage">

	<typeAlias  alias="egovMap" type="egovframework.rte.psl.dataaccess.util.EgovMap"/>
	<typeAlias  alias="comDefaultVO" type="egovframework.com.cmm.ComDefaultVO"/>
	<typeAlias  alias="DeptSchdulManageVO" type="egovframework.com.cop.smt.sdm.service.DeptSchdulManageVO"/>

	<resultMap id="DeptSchdulManage" class="egovframework.com.cop.smt.sdm.service.DeptSchdulManageVO">
		<result property="schdulId" column="SCHDUL_ID" columnIndex="1"/>
		<result property="schdulSe" column="SCHDUL_SE" columnIndex="2"/>
		<result property="schdulDeptId" column="SCHDUL_DEPT_ID" columnIndex="3"/>
		<result property="schdulDeptName" column="SCHDUL_DEPT_NAME" columnIndex="4"/>
		
		<result property="schdulKindCode" column="SCHDUL_KND_CODE" columnIndex="5"/>
		<result property="schdulBgnde" column="SCHDUL_BGNDE" columnIndex="6"/>
		<result property="schdulEndde" column="SCHDUL_ENDDE" columnIndex="7"/>
		<result property="schdulNm" column="SCHDUL_NM" columnIndex="8"/>
		<result property="schdulCn" column="SCHDUL_CN" columnIndex="9"/>
		<result property="schdulPlace" column="SCHDUL_PLACE" columnIndex="10"/>
		<result property="schdulIpcrCode" column="SCHDUL_IPCR_CODE" columnIndex="11"/>
		<result property="schdulChargerId" column="SCHDUL_CHARGER_ID" columnIndex="12"/>
		<result property="schdulChargerName" column="SCHDUL_CHARGER_NAME" columnIndex="13"/>
		
		<result property="atchFileId" column="ATCH_FILE_ID" columnIndex="14"/>
		<result property="reptitSeCode" column="REPTIT_SE_CODE" columnIndex="15"/>    
		<result property="frstRegisterPnttm" column="FRST_REGIST_PNTTM" columnIndex="16" />
		<result property="frstRegisterId" column="FRST_REGISTER_ID" columnIndex="17"/>
		<result property="lastUpdusrPnttm" column="LAST_UPDT_PNTTM" columnIndex="18"/>
		<result property="lastUpdusrId" column="LAST_UPDUSR_ID" columnIndex="19" />				
	</resultMap>
	
	<!-- 메인페이지/일정관리조회 -->  
	<select id="DeptSchdulManage.selectDeptSchdulManageMainList" parameterClass="java.util.Map" resultClass="egovMap">
	
		SELECT MAIN.* 
		FROM (
		SELECT 
			TO_CHAR(sysdate, 'YYYY-MM-DD') TO_DAY,
			A.SCHDUL_ID,
			A.SCHDUL_SE,
			A.SCHDUL_DEPT_ID,
			A.SCHDUL_KND_CODE SCHDUL_KIND_CODE,
			A.SCHDUL_BGNDE,
			A.SCHDUL_ENDDE,
			A.SCHDUL_NM,
			A.SCHDUL_CN,
			A.SCHDUL_PLACE,
			A.SCHDUL_IPCR_CODE,
			A.SCHDUL_CHARGER_ID,		
			A.ATCH_FILE_ID,
			TO_CHAR(A.FRST_REGIST_PNTTM,'YYYY-MM-DD') FRST_REGIST_PNTTM,
			A.FRST_REGISTER_ID FRST_REGISTER_PNTTM,
			A.LAST_UPDT_PNTTM,
			A.LAST_UPDUSR_ID,
			A.REPTIT_SE_CODE 
		FROM COMTNSCHDULINFO A
		WHERE 1=1 
		AND A.SCHDUL_KND_CODE = '1'   
		AND (A.SCHDUL_CHARGER_ID = #uniqId# OR A.FRST_REGISTER_ID = #uniqId#)  
		
		<![CDATA[
		AND ( 
		 ( SUBSTR(A.SCHDUL_BGNDE,1,8) > TO_CHAR(sysdate, 'YYYYMMDD') AND SUBSTR(A.SCHDUL_BGNDE,1,8) <= TO_CHAR(sysdate, 'YYYYMMDD') )
		OR
		 ( SUBSTR(A.SCHDUL_ENDDE,1,8) > TO_CHAR(sysdate, 'YYYYMMDD') AND SUBSTR(A.SCHDUL_BGNDE,1,8) <= TO_CHAR(sysdate, 'YYYYMMDD') )
		) 
		
		ORDER BY A.FRST_REGIST_PNTTM DESC

		 ) MAIN 
		 WHERE ROWNUM < 5 
		 
		 ]]>
	</select>
	
	<!-- 부서일정정보::목록조회 -->
	<select id="DeptSchdulManage.selectDeptSchdulManageRetrieve" parameterClass="java.util.Map" resultClass="egovMap">
	 <![CDATA[
		SELECT 
			A.SCHDUL_ID,
			A.SCHDUL_SE,
			A.SCHDUL_DEPT_ID,
			A.SCHDUL_KND_CODE SCHDUL_KIND_CODE,
			A.SCHDUL_BGNDE,
			A.SCHDUL_ENDDE,
			A.SCHDUL_NM,
			A.SCHDUL_CN,
			A.SCHDUL_PLACE,
			A.SCHDUL_IPCR_CODE,
			A.SCHDUL_CHARGER_ID,
			(SELECT USER_NM FROM COMTNEMPLYRINFO WHERE ESNTL_ID = A.SCHDUL_CHARGER_ID) SCHDUL_CHARGER_NAME,		
			A.ATCH_FILE_ID,
			A.FRST_REGIST_PNTTM FRST_REGISTER_PNTTM,
			A.FRST_REGISTER_ID,
			A.LAST_UPDT_PNTTM,
			A.LAST_UPDUSR_ID,
			A.REPTIT_SE_CODE 
		FROM COMTNSCHDULINFO A
		WHERE 1=1 
		AND A.SCHDUL_KND_CODE = '1' 
	 ]]>
	 <isNotEmpty property="searchMode">
	 <isEqual property="searchMode" compareValue="MONTH">
	 
		 <isNotEmpty property="searchMonth">
		 	<isNotEqual property="searchMonth" compareValue="">
		 	 AND (#searchMonth# BETWEEN SUBSTR(A.SCHDUL_BGNDE, 1, 6)  AND SUBSTR(A.SCHDUL_ENDDE, 1, 6) ) 
		 	</isNotEqual>
		 </isNotEmpty>
	 
	 </isEqual>
	 <isEqual property="searchMode" compareValue="WEEK">
	 <![CDATA[ 
		AND (  
		 ( SUBSTR(A.SCHDUL_BGNDE,1,8) > #schdulBgnde# AND SUBSTR(A.SCHDUL_BGNDE,1,8) <= #schdulEndde#)
		OR
		 ( SUBSTR(A.SCHDUL_ENDDE,1,8) > #schdulBgnde# AND SUBSTR(A.SCHDUL_BGNDE,1,8) <= #schdulEndde#)
		)
	]]>
	 </isEqual>
	 <isEqual property="searchMode" compareValue="DAILY">
	 <![CDATA[
	 	 AND (#searchDay# BETWEEN SUBSTR(A.SCHDUL_BGNDE, 1, 8)  AND SUBSTR(A.SCHDUL_ENDDE, 1, 8) )
	  ]]> 
	 </isEqual>
	 </isNotEmpty>

	 <isNotEmpty property="searchKeyword">
	 	<isNotEqual property="searchKeyword" compareValue="">
			<isEqual property="searchCondition" compareValue="SCHDUL_SE">
 				AND SCHDUL_SE LIKE '%' || #searchKeyword# || '%'
 			</isEqual> 		
	 	</isNotEqual>
	 </isNotEmpty>

	</select>
	
	<!-- 부서일정정보::상세보기 -->
	<select id="DeptSchdulManage.selectDeptSchdulManageDetailVO" resultMap="DeptSchdulManage">
		SELECT 
			A.SCHDUL_ID,
			A.SCHDUL_SE,
			A.SCHDUL_DEPT_ID,
			(SELECT ORGNZT_NM FROM COMTNORGNZTINFO WHERE ORGNZT_ID = A.SCHDUL_DEPT_ID) SCHDUL_DEPT_NAME,
			A.SCHDUL_KND_CODE,
			A.SCHDUL_BGNDE,
			A.SCHDUL_ENDDE,
			A.SCHDUL_NM,
			A.SCHDUL_CN,
			A.SCHDUL_PLACE,
			A.SCHDUL_IPCR_CODE,
			A.SCHDUL_CHARGER_ID,
			(SELECT USER_NM FROM COMTNEMPLYRINFO WHERE ESNTL_ID = A.SCHDUL_CHARGER_ID) SCHDUL_CHARGER_NAME,	
			A.ATCH_FILE_ID,
			A.REPTIT_SE_CODE,
			A.FRST_REGIST_PNTTM,
			A.FRST_REGISTER_ID,
			A.LAST_UPDT_PNTTM,
			A.LAST_UPDUSR_ID 
		FROM COMTNSCHDULINFO A
		WHERE 1=1 
		AND SCHDUL_ID = #schdulId#
	</select>
	
	<!-- 부서일정정보::목록조회_게시물정보 -->
	<select id="DeptSchdulManage.selectDeptSchdulManage" parameterClass="comDefaultVO" resultClass="egovMap">
	<![CDATA[	
	SELECT *
	FROM (
	SELECT T0.*, ROWNUM RNUM
		FROM (
	]]>
	
	 <![CDATA[
		SELECT 
			A.SCHDUL_ID,
			A.SCHDUL_SE,
			A.SCHDUL_DEPT_ID,
			A.SCHDUL_KND_CODE SCHDUL_KIND_CODE,
			A.SCHDUL_BGNDE,
			A.SCHDUL_ENDDE,
			A.SCHDUL_NM,
			A.SCHDUL_CN,
			A.SCHDUL_PLACE,
			A.SCHDUL_IPCR_CODE,
			A.SCHDUL_CHARGER_ID,		
			A.ATCH_FILE_ID,
			A.FRST_REGIST_PNTTM FRST_REGISTER_PNTTM,
			A.FRST_REGISTER_ID,
			A.LAST_UPDT_PNTTM,
			A.LAST_UPDUSR_ID,
			A.REPTIT_SE_CODE 
		FROM COMTNSCHDULINFO A
		WHERE 1=1 
	 ]]>
	 <isNotEmpty property="searchKeyword">
	 	<isNotEqual property="searchKeyword" compareValue="">
 				AND SCHDUL_NM LIKE '%' || #searchKeyword# || '%'
	 	</isNotEqual>
	 </isNotEmpty>
	 <![CDATA[
		ORDER BY A.FRST_REGIST_PNTTM DESC
	]]>
	
	<![CDATA[	
		) T0
	) Z
	WHERE RNUM BETWEEN #firstIndex# + 1 AND #firstIndex# + #recordCountPerPage#
	]]>	
	</select>
	
	<!-- 부서일정정보::목록조회_게시물 총갯수  -->
	<select id="DeptSchdulManage.selectDeptSchdulManageCnt" parameterClass="comDefaultVO" resultClass="int">
		SELECT 
		COUNT(*) totcnt
		FROM COMTNSCHDULINFO
		WHERE 1=1 
	 <isNotEmpty property="searchKeyword">
	 	<isNotEqual property="searchKeyword" compareValue="">
 				AND SCHDUL_NM LIKE '%' || #searchKeyword# || '%'
	 	</isNotEqual>
	 </isNotEmpty>
	</select>

	
	<!-- 부서일정정보::삭제  -->
	<delete id="DeptSchdulManage.deleteDiaryManage">
			DELETE FROM COMTNDIARYINFO 
			WHERE SCHDUL_ID = #schdulId#
	</delete>
	<delete id="DeptSchdulManage.deleteDeptSchdulManage"> 
		<![CDATA[
			DELETE FROM COMTNSCHDULINFO 
			WHERE SCHDUL_ID = #schdulId#
		]]>
	</delete>

	<!-- 부서일정정보::수정  -->
	<update id="DeptSchdulManage.updateDeptSchdulManage"> 
		UPDATE COMTNSCHDULINFO 
		SET  
			SCHDUL_SE=#schdulSe#,
			SCHDUL_DEPT_ID=#schdulDeptId#,
			SCHDUL_KND_CODE=#schdulKindCode#,
			SCHDUL_BGNDE=#schdulBgnde#,
			SCHDUL_ENDDE=#schdulEndde#,
			SCHDUL_NM=#schdulNm#,
			SCHDUL_CN=#schdulCn#,
			SCHDUL_IPCR_CODE=#schdulIpcrCode#,
			SCHDUL_CHARGER_ID=#schdulChargerId#,
			ATCH_FILE_ID=#atchFileId#,
			REPTIT_SE_CODE=#reptitSeCode#,
			LAST_UPDT_PNTTM = SYSDATETIME,
			LAST_UPDUSR_ID = #lastUpdusrId#
		WHERE SCHDUL_ID = #schdulId#
	</update>
	
	<!-- 부서일정정보::상세보기 -->
	<select id="DeptSchdulManage.selectDeptSchdulManageDetail" resultClass="egovMap">
		SELECT 
			A.SCHDUL_ID,
			A.SCHDUL_SE,
			A.SCHDUL_DEPT_ID,
			(SELECT ORGNZT_NM FROM COMTNORGNZTINFO WHERE ORGNZT_ID = A.SCHDUL_DEPT_ID) SCHDUL_DEPT_NAME,
			A.SCHDUL_KND_CODE SCHDUL_KIND_CODE,
			A.SCHDUL_BGNDE,
			A.SCHDUL_ENDDE,
			A.SCHDUL_NM,
			A.SCHDUL_CN,
			A.SCHDUL_PLACE,
			A.SCHDUL_IPCR_CODE,
			A.SCHDUL_CHARGER_ID,
			(SELECT USER_NM FROM COMTNEMPLYRINFO WHERE ESNTL_ID = A.SCHDUL_CHARGER_ID) SCHDUL_CHARGER_NAME,	
			A.ATCH_FILE_ID,
			A.FRST_REGIST_PNTTM FRST_REGISTER_PNTTM,
			A.FRST_REGISTER_ID,
			A.LAST_UPDT_PNTTM,
			A.LAST_UPDUSR_ID,
			A.REPTIT_SE_CODE
		FROM COMTNSCHDULINFO A
		WHERE 1=1
		AND SCHDUL_ID = #schdulId#
	</select>
	
	<!-- 부서일정정보::입력  -->
	<insert id="DeptSchdulManage.insertDeptSchdulManage">
	 <![CDATA[
	 
		INSERT INTO COMTNSCHDULINFO ( 
			SCHDUL_ID,
			SCHDUL_SE,
			SCHDUL_DEPT_ID,
			SCHDUL_KND_CODE,
			SCHDUL_BGNDE,
			SCHDUL_ENDDE,
			SCHDUL_NM,
			SCHDUL_CN,
			SCHDUL_PLACE,
			SCHDUL_IPCR_CODE,
			SCHDUL_CHARGER_ID,
			ATCH_FILE_ID,
			REPTIT_SE_CODE,
			FRST_REGIST_PNTTM,
			FRST_REGISTER_ID,
			LAST_UPDT_PNTTM,
			LAST_UPDUSR_ID
		)VALUES( 
			#schdulId#,
			#schdulSe#,
			#schdulDeptId#,
			#schdulKindCode#,
			#schdulBgnde#,
			#schdulEndde#,
			#schdulNm#,
			#schdulCn#,
			#schdulPlace#,
			#schdulIpcrCode#,
			#schdulChargerId#,
			#atchFileId#,
			#reptitSeCode#,    
			SYSDATETIME,
			#frstRegisterId#,
			SYSDATETIME,
			#lastUpdusrId# 
		)

	 ]]>
	</insert>


</sqlMap>