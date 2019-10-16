package first.sample.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import first.common.common.CommandMap;
import first.sample.service.SampleService;

@Controller
public class SampleController {
	Logger log = Logger.getLogger(this.getClass());

	/*
	 * @RequestMapping(value = "/sample/openSampleList.do") public ModelAndView
	 * openSampleList(Map<String, Object> commandMap) throws Exception {
	 * ModelAndView mv = new ModelAndView(""); log.debug("인터셉터 테스트"); return mv;
	 * }
	 */

	@Resource(name = "sampleService")
	private SampleService sampleService;

	@RequestMapping(value="/sample/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
	     
	    ModelAndView mv = new ModelAndView("sample/boardList");
	    
	    String category = (String)commandMap.get("category");
	    if(category != null){
	    	if(category.equals("tab-0")){
	    		commandMap.put("category", "");
	    	}else if(category.equals("tab-1")){
	    		commandMap.put("category", "관광지");
		    }else if(category.equals("tab-2")){
		    	commandMap.put("category", "음식점");
		    }else if(category.equals("tab-3")){
		    	commandMap.put("category", "숙박");
		    }
	    }else {
	    	category = "tab-0";
	    }
	    
	    
	    Map<String,Object> map = sampleService.selectBoardList(commandMap.getMap());
	    mv.addObject("list", map.get("result"));
	    
	    
	    mv.addObject("paginationInfo", (PaginationInfo)map.get("paginationInfo"));
	    
	    mv.addObject("category", category);
	     
	    return mv;
	}

	@RequestMapping(value = "/sample/testMapArgumentResolver.do")
	public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("");
		if (commandMap.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while (iterator.hasNext()) {
				entry = iterator.next();
				log.debug("key : " + entry.getKey() + ", value : " + entry.getValue());
			}
		}
		return mv;
	}

	// 입력 페이지로
	@RequestMapping(value = "/sample/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardWrite");
		return mv;
	}

	// DB 글쓰기 기능
	@RequestMapping(value = "/sample/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
		sampleService.insertBoard(commandMap.getMap(), request);
		return mv;
	}

	// 상세화면 보기
	@RequestMapping(value = "/sample/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardDetail");				
	    // 상세 글 호출
		Map<String, Object> map = sampleService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get("map")); // 현재 글의 위경도값을 담고 있는 map
		mv.addObject("list", map.get("list"));	// 현재 글 대상 정보
		
		return mv;
	}
	
	// 상세 페이지 맵
	@RequestMapping(value = "/sample/openBoardDetailMap.do")
	
	public ModelAndView openBoardDetailMap(String lat, String lon, String category) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardDetailMapList");			  
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("lat", lat);
		map.put("lon", lon);
		map.put("category", category);	
			
		Map<String,Object> map3 = sampleService.selectBoardList2(map); // 전체 리스트에 대입시켜서
		mv.addObject("resultList", map3.get("result")); // 전체 리스트를 호출		
		
		return mv;
	}
	
	// 수정 페이지로
	@RequestMapping(value = "/sample/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardUpdate");
		Map<String, Object> map = sampleService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));
		return mv;
	}

	// DB 수정 기능
	@RequestMapping(value = "/sample/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardDetail.do");
		sampleService.updateBoard(commandMap.getMap(), request);
		mv.addObject("IDX", commandMap.get("IDX"));
		return mv;
	}

	// 글 삭제
	@RequestMapping(value = "/sample/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
		sampleService.deleteBoard(commandMap.getMap());
		return mv;
	}

}
