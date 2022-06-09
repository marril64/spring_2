package com.ict.service;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ict.persistence.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Autowired
	private BoardService service;
	
	@Test
	public void getList() {
		//log.info(service.getList(8L));
	}
	
	// insert 도 테스트 한 번 해주세요.
	//@Test
	public void insert() {
		BoardVO vo = new BoardVO();
		
		vo.setTitle("새로넣는글5");
		vo.setContent("새로넣는본문5");
		vo.setWriter("새로넣는글쓴이5");
		
		service.insert(vo);
	};
	
	// delete를 테스트해보겠습니다.
	//@Test
	public void delete() {
		service.delete(1L);
	}
	
	// update는 쿼리문 특성상 글번호까지 같이 줘야합니다.
	//@Test
	public void update() {
		BoardVO vo = new BoardVO();
		
		ArrayList<Integer> list = new ArrayList<>();
		
		/*for (int i = 0; i < service.getList().size(); i++) {
			list.add(Integer(service.getList().get(i));
		}*/
		
		vo.setBno(1L);
		vo.setTitle("두번 수정된 제목");
		vo.setContent("두번 수정된 본문");
		vo.setWriter("두번 수정된 글쓴이");
		
		service.update(vo);
	}
	
	//@Test
	public void getDetail() {
		service.getDetail(3L);
	}
}
