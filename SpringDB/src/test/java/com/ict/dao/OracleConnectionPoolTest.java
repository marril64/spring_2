package com.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OracleConnectionPoolTest {

	@Autowired
	private DataSource dataSource;
	
	// 하단에 SqlSessionFactory 선언 후 Autowired로 주입
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	// @Test를 주석처리하면 실행타겟에서 벗어남
	// @Test
	public void testConnection() {
		try (Connection con = dataSource.getConnection()) {
			log.info(con);
			log.info("hikariCP connection");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// testMyBatis를 적어주세요.
	@Test
	public void testMyBatis() {
		try (SqlSession session = sqlSessionFactory.openSession();
			 Connection con = session.getConnection();) {
			log.info("sql세션이래요." + session);
			log.info("커넥션이래요." + con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	
}
