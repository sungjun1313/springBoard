package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		log.info("BoardMapperTests testGetList");
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		log.info("BoardMapperTests testInsert");
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		log.info("BoardMapperTests testInsertSelectKey");
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	@Test
	public void testRead() {
		log.info("BoardMapperTests testRead");
		
		BoardVO board = mapper.read(2L);//bno가 1이 것을 select한다.
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("BoardMapperTests testDelete");
		log.info("DELETE COUNT: " + mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		log.info("BoardMapperTests testUpdate");
		
		BoardVO board = new BoardVO();
		board.setBno(2L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT: " + count);
	}
	
	@Test
	public void testPaging() {
		log.info("BoardMapperTests testPaging");
		
		Criteria cri = new Criteria();
		cri.setPageNum(2);
		cri.setAmount(10);
		mapper.getListWithPaging(cri).forEach(board -> log.info(board));
	}
	
	@Test
	public void testSearch() {
		log.info("BoardMapperTests testSearch....................");
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");
		mapper.getListWithPaging(cri).forEach(board -> log.info(board));
	}
}
