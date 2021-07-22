package com.koreait.dooboo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.koreait.dooboo.map.command.UpdateLocationCommand;
import com.koreait.dooboo.map.command.UpdateUseNowCommand;
import com.koreait.dooboo.map.command.DeleteLocationCommand;
import com.koreait.dooboo.map.command.FirstInsertLocationCommand;
import com.koreait.dooboo.map.command.MapCheckLocationCommand;
import com.koreait.dooboo.map.command.MapInsertLocationCommand;
import com.koreait.dooboo.map.command.SaveLocationCommand;

@Configuration
public class MapConfiguration {
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
	public UpdateLocationCommand updateLocationCommand() {
		return new UpdateLocationCommand();
	}
	
	@Bean
	public DeleteLocationCommand deleteLocationCommand() {
		return new DeleteLocationCommand();
	}
	
	@Bean
	public FirstInsertLocationCommand firstInsertLocationCommand() {
		return new FirstInsertLocationCommand();
	}
	
	@Bean
	public UpdateUseNowCommand updateUseNowCommand() {
		return new UpdateUseNowCommand();
	}
}
