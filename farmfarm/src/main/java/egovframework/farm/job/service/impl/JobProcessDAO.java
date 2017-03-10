package egovframework.farm.job.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.farm.job.service.JobProcessVO;
import egovframework.farm.job.service.JobProcessDefaultVO;

/**
 * @Class Name : JobProcessDAO.java
 * @Description : JobProcess DAO Class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jobProcessDAO")
public class JobProcessDAO extends EgovComAbstractDAO {

	/**
	 * JOB_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JobProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJobProcess(JobProcessVO vo) throws Exception {
        return (String)insert("jobProcessDAO.insertJobProcess_S", vo);
    }

    /**
	 * JOB_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JobProcessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJobProcess(JobProcessVO vo) throws Exception {
        update("jobProcessDAO.updateJobProcess_S", vo);
    }

    /**
	 * JOB_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JobProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJobProcess(JobProcessVO vo) throws Exception {
        delete("jobProcessDAO.deleteJobProcess_S", vo);
    }

    /**
	 * JOB_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JobProcessVO
	 * @return 조회한 JOB_PROCESS
	 * @exception Exception
	 */
    public JobProcessVO selectJobProcess(JobProcessVO vo) throws Exception {
        return (JobProcessVO) select("jobProcessDAO.selectJobProcess_S", vo);
    }

    /**
	 * JOB_PROCESS 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JOB_PROCESS 목록
	 * @exception Exception
	 */
    public List<?> selectJobProcessList(JobProcessDefaultVO searchVO) throws Exception {
        return list("jobProcessDAO.selectJobProcessList_D", searchVO);
    }

    /**
	 * JOB_PROCESS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JOB_PROCESS 총 갯수
	 * @exception
	 */
    public int selectJobProcessListTotCnt(JobProcessDefaultVO searchVO) {
        return (Integer)select("jobProcessDAO.selectJobProcessListTotCnt_S", searchVO);
    }

}
