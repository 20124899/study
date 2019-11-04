package first.sample.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface SampleService {
	Map<String,Object> selectBoardList(Map<String, Object> map) throws Exception;
	Map<String,Object> selectBoardList2(Map<String, Object> map) throws Exception;
	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	void insertBoardTour(Map<String, Object> map) throws Exception;

	// void insertBoard(Map<String, Object> map) throws Exception;
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;
	Map<String, Object> selectBoardDetailTour(Map<String, Object> map) throws Exception;
	void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	void updateBoardTour(Map<String, Object> map) throws Exception;
	void deleteBoard(Map<String, Object> map) throws Exception;
}
