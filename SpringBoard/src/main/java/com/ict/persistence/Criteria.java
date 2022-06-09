package com.ict.persistence;

import lombok.Data;

@Data
public class Criteria {
	
	private int page;
	private int number;
	
	public int getPageStart() {
		return (this.page - 1) * number;
	}

}
