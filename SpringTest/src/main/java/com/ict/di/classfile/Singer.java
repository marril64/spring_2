package com.ict.di.classfile;

import org.springframework.stereotype.Component;

@Component
public class Singer {

	// 가수는 무대가 있건 없건 노래를 할 수 있기 때문에
	// 다른 어떠한 요소도 없이 오직 노래기능만 넣어둡니다.
	
	public void sing() {
		System.out.println("가수가 노래를 합니다.");
	}
	
}
