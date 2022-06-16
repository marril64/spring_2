package com.ict.persistence;

import lombok.Data;

@Data
public class PageMaker {

	private Long totalBoard;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum;
	// 현재 조회중인 페이지 정보를 획득하기 위해 선언
	private Criteria cri;
	
	public void calcData() {
		this.displayPageNum = 10;
		
		this.endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		this.startPage = (this.endPage - this.displayPageNum) + 1;
		
		int tempEndPage = (int)(Math.ceil(this.totalBoard / (double)cri.getNumber()));
		
		if (this.endPage > tempEndPage) {
			this.endPage = tempEndPage;
		}
		
		this.prev = this.startPage == 1 ? false : true;
		
		this.next = this.endPage * cri.getNumber() >= this.totalBoard ? false : true;
	}
	
	public void setTotalBoard(Long totalBoard) {
		this.totalBoard = totalBoard;
		calcData();
	}
	
}
