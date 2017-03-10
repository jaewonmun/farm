package egovframework.farm.job.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.farm.job.service.JobProcessService;
import egovframework.farm.job.service.JobProcessDefaultVO;
import egovframework.farm.job.service.JobProcessVO;
import egovframework.farm.job.service.impl.JobProcessDAO;

/**
 * @Class Name : JobProcessServiceImpl.java
 * @Description : JobProcess Business Implement class
 * @Modification Information
 *
 * @author 김형철
 * @since 20161122
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jobProcessService")
public class JobProcessServiceImpl extends EgovAbstractServiceImpl implements
        JobProcessService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(JobProcessServiceImpl.class);

    @Resource(name="jobProcessDAO")
    private JobProcessDAO jobProcessDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJobProcessIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * JOB_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JobProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJobProcess(JobProcessVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	jobProcessDAO.insertJobProcess(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JOB_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JobProcessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJobProcess(JobProcessVO vo) throws Exception {
        jobProcessDAO.updateJobProcess(vo);
    }

    /**
	 * JOB_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JobProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJobProcess(JobProcessVO vo) throws Exception {
        jobProcessDAO.deleteJobProcess(vo);
    }

    /**
	 * JOB_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JobProcessVO
	 * @return 조회한 JOB_PROCESS
	 * @exception Exception
	 */
    public JobProcessVO selectJobProcess(JobProcessVO vo) throws Exception {
        JobProcessVO resultVO = jobProcessDAO.selectJobProcess(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JOB_PROCESS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JOB_PROCESS 목록
	 * @exception Exception
	 */
    public List<?> selectJobProcessList(JobProcessDefaultVO searchVO) throws Exception {
        return jobProcessDAO.selectJobProcessList(searchVO);
    }

    /**
	 * JOB_PROCESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JOB_PROCESS 총 갯수
	 * @exception
	 */
    public int selectJobProcessListTotCnt(JobProcessDefaultVO searchVO) {
		return jobProcessDAO.selectJobProcessListTotCnt(searchVO);
	}
    
}
