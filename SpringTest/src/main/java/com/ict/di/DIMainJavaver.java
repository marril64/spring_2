package com.ict.di;

import com.ict.di.classfile.Broadcast;
import com.ict.di.classfile.Singer;
import com.ict.di.classfile.Stage;

public class DIMainJavaver {

	public static void main(String[] args) {
		// Singer를 생성해서 노래하게 만들어보세요.
		Singer singer = new Singer(); // 가수를 주석처리해버리면 무대 자체가 성립되지 않는다.
		singer.sing();
		
		// Stage도 만들어서 공연을 시켜보세요.
		//Stage stage = new Stage(singer); // 무대는 가수에 의존한다.
		//stage.perform(); // 무대는 가수없이 존재할 수 없다.
		
		// Broadcast를 생성해서 방송무대를 송출해보겠습니다.
		//Broadcast broadcast = new Broadcast(stage);
		//broadcast.broad();

	}

}
