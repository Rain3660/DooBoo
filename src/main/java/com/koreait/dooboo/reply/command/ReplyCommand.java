package com.koreait.dooboo.reply.command;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface ReplyCommand {
	public void execute(SqlSession session, Model model);
}
