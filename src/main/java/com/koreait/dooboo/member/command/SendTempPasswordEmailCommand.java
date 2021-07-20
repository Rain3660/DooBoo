package com.koreait.dooboo.member.command;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.SecurityUtils;

// 임시 비밀번호를 이메일로 발송하는 클래스
public class SendTempPasswordEmailCommand{
	@Autowired
	private JavaMailSender mailSender;
	
	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		MemberDTO memberDTO = (MemberDTO)model.asMap().get("memberDTO");
		Map<String, Object> resultMap = new HashMap<>();
		
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		
		// 비밀번호를 바꿀 회원을 찾아보자
		MemberDTO searchedMember = dao.selectMemberByEmailAndId(memberDTO);
		
		if(searchedMember == null) {// 입력한 정보에 해당하는 회원이 없는경우
			resultMap.put("status", 500);
		}else { // 입력한 정보에 해당하는 회원이 있는경우 >> 임시비밀번호로 변경 후 메일발송
			
			// 6자리의 임시 비밀번호를 발급받는다.
			String tempPassword = SecurityUtils.getAuthCode(6);
			
			// 임시 비밀번호를 암호화한다.
			String password = SecurityUtils.encodeBase64(tempPassword);
			
			// DB 에 반영
			dao.updatePassword(password, searchedMember.getMemberNo());
			
			// 메일 보내기
			MimeMessage message = mailSender.createMimeMessage();
			String email = searchedMember.getEmail();
			try {
				message.setHeader("Content-Type", MediaType.TEXT_PLAIN_VALUE + "; charset=utf-8");
				message.setFrom(new InternetAddress("forspringlec@gmail.com", "관리자"));
				message.setRecipient(Message.RecipientType.TO , new InternetAddress(email));
				message.setSubject("임시 비밀번호 발급 메일입니다.");
				message.setText(searchedMember.getMemberId() + "님의 비밀번호를 " + tempPassword + "로 변경했습니다.");
				
				mailSender.send(message);
				
				resultMap.put("status", 200);
				resultMap.put("tempPw", tempPassword);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return resultMap;
	}
}
