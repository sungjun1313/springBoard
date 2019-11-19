package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.ReplyVO;
import org.zerock.domain.Criteria;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPage(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
	
	public int deleteAll(Long bno);
}
