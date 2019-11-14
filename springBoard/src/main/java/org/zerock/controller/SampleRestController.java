package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/rest/*")
@Slf4j
public class SampleRestController {
	//테스트용
	@GetMapping(value="/getText", produces="text/plain;charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE );
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSampe() {
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value="/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "로켓", "라쿤");
	}
	
	@GetMapping(value="/getSampleList")
	public List<SampleVO> getSampleList(){
		return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i+"first", i+"last"))
				.collect(Collectors.toList());
	}
	
	@GetMapping(value="/getSampleMap")
	public Map<String, SampleVO> getSampleMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));
		return map;
	}
	
	@GetMapping(value="/getCheck", params= {"height", "weight"})
	public ResponseEntity<SampleVO> getCheck(Double height, Double weight){
		SampleVO vo = new SampleVO(0, ""+height, ""+weight);
		ResponseEntity<SampleVO> result = null;
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping(value="/sample/{cat}/{pid}")
	public String[] getSampePath(@PathVariable String cat, @PathVariable("pid") Integer pid) {
		return new String[] {"category: " + cat, "productId: " + pid};
	}
	
	@PostMapping("/samplePost")
	public SampleVO sampleConver(@RequestBody SampleVO vo) {
		log.info("convert........" + vo);
		return vo;
	}
}
