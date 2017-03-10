package egovframework.farm.job.service;

import java.util.List;
import egovframework.farm.job.service.JobProcessDefaultVO;
import egovframework.farm.job.service.JobProcessVO;

/**
 * @Class Name : JobProcessService.java
 * @Description : JobProcess Business class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JobProcessService {
	
	/**
	 * JOB_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JobProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJobProcess(JobProcessVO vo) throws Exception;
    
    /**
	 * JOB_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JobProcessVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJobProcess(JobProcessVO vo) throws Exception;
    
    /**
	 * JOB_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JobProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJobProcess(JobProcessVO vo) throws Exception;
    
    /**
	 * JOB_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JobProcessVO
	 * @return 조회한 JOB_PROCESS
	 * @exception Exception
	 */
    JobProcessVO selectJobProcess(JobProcessVO vo) throws Exception;
    
    /**
	 * JOB_PROCESS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JOB_PROCESS 목록
	 * @exception Exception
	 */
    List selectJobProcessList(JobProcessDefaultVO searchVO) throws Exception;
    
    /**
	 * JOB_PROCESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JOB_PROCESS 총 갯수
	 * @exception
	 */
    int selectJobProcessListTotCnt(JobProcessDefaultVO searchVO);
    
}
