package com.koreait.dooboo.config;

import java.util.Properties;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.koreait.dooboo.api.NaverLoginBO;
import com.koreait.dooboo.map.command.ChangeLocationCommand;
import com.koreait.dooboo.map.command.ChangeToNowLocation;
import com.koreait.dooboo.map.command.DeleteLocationCommand;
import com.koreait.dooboo.map.command.MapCheckLocationCommand;
import com.koreait.dooboo.map.command.MapInsertLocationCommand;
import com.koreait.dooboo.map.command.SaveLocationCommand;
import com.koreait.dooboo.member.command.CurrentPasswordCheckCommand;
import com.koreait.dooboo.member.command.DeleteCommand;
import com.koreait.dooboo.member.command.FindIdCommand;
import com.koreait.dooboo.member.command.IdCheckCommand;
import com.koreait.dooboo.member.command.JoinCommand;
import com.koreait.dooboo.member.command.LogOutCommand;
import com.koreait.dooboo.member.command.LoginCommand;
import com.koreait.dooboo.member.command.SendTempPasswordEmailCommand;
import com.koreait.dooboo.member.command.UpdateContactCommand;
import com.koreait.dooboo.member.command.UpdateInfoCommand;
import com.koreait.dooboo.member.command.UpdatePasswordCommand;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"com.koreait.dooboo.*.dao"}) // mapper 스캔
public class BeanConfiguration {

	@Autowired
	private ApplicationContext applicationContext;
	
	@Bean
	public HikariConfig hikariConfig() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName("oracle.jdbc.OracleDriver");
		hikariConfig.setJdbcUrl("jdbc:oracle:thin:@sih8859.iptime.org:11521:XE");
		hikariConfig.setUsername("dooboo");
		hikariConfig.setPassword("qwer1234!@");
		return hikariConfig;
	}
	
	@Bean
	public HikariDataSource hikariDataSource() {
		return new HikariDataSource(hikariConfig());

	}

	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		
		Properties properties = new Properties();
		properties.put("mapUnderscoreToCamelCase", true);
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setConfigurationProperties(properties); //카멜케이스 설정 
		sqlSessionFactory.setDataSource(hikariDataSource());
		sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:com/koreait/dooboo/mapper/*.xml"));
		//카멜케이스 설정
		Resource myBatisConfig = new PathMatchingResourcePatternResolver().getResource("classpath:mybatis-config.xml");
		sqlSessionFactory.setConfigLocation(myBatisConfig);		
		
		return sqlSessionFactory.getObject();
	}

	@Bean
	public SqlSessionTemplate sqlSession() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setDefaultEncoding("utf-8");
		multipartResolver.setMaxUploadSize(1024 * 1024 * 10);
		return multipartResolver;
	}
	@Bean
	public JoinCommand joinCommand() {
		return new JoinCommand();
	}
	@Bean
	public LoginCommand loginCommand() {
		return new LoginCommand();
	}

	@Bean
	public DeleteCommand deleteCommand() {
		return new DeleteCommand();

	}

	@Bean
	public NaverLoginBO naverLoginBO() {
		return new NaverLoginBO();

	}
	@Bean
	public LogOutCommand logOutCommand() {
		return new LogOutCommand();
	}
	@Bean
	public UpdateInfoCommand updateInfoCommand() {
		return new UpdateInfoCommand();
	}
	@Bean
	public CurrentPasswordCheckCommand currentPasswordCheckCommand() {
		return new CurrentPasswordCheckCommand();
	}
	@Bean
	public UpdatePasswordCommand updatePasswordCommand() {
		return new UpdatePasswordCommand();
	}
	@Bean
	public UpdateContactCommand updateContactCommand() {
		return new UpdateContactCommand();
	}
	@Bean
	public MapCheckLocationCommand mapCheckLocationCommand() {
		return new MapCheckLocationCommand();
	}
	
	@Bean
	public MapInsertLocationCommand mapInsertLocationCommand() {
		return new MapInsertLocationCommand();
	}
	
	@Bean
	public SaveLocationCommand saveLocationCommand() {
		return new SaveLocationCommand();
	}
	@Bean
	public ChangeLocationCommand changeLocationCommand() {
		return new ChangeLocationCommand();
	}
	
	@Bean
	public ChangeToNowLocation changeToNowLocation() {
		return new ChangeToNowLocation();
	}
	
	@Bean
	public DeleteLocationCommand deleteLocationCommand() {
		return new DeleteLocationCommand();
	}

	@Bean
	public FindIdCommand findIdCommand() {
		return new FindIdCommand();
	}
	@Bean
	public SendTempPasswordEmailCommand sendTempPasswordEmailCommand() {
		return new SendTempPasswordEmailCommand();
	}
	@Bean
	public IdCheckCommand idCheckCommand() {
		return new IdCheckCommand();
	}
}
