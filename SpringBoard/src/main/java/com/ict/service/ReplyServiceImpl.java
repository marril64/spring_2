package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mapper.ReplyMapper;
import com.ict.persistence.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	// 서비스는 매퍼를 호출하기때문에 매퍼 생성
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
	}
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return mapper.getList(bno);
	}
	
	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}
	
	@Override
	public void removeReply(Long rno) {
		mapper.delete(rno);
	}

}
