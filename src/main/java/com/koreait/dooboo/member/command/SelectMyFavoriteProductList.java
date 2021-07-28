package com.koreait.dooboo.member.command;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.vo.ProductVO;

public class SelectMyFavoriteProductList implements MemberCommand{
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		// model 에는 session 이 들어있다.
		HttpSession session = (HttpSession)model.asMap().get("session");
		
		// 현재 접속한 회원의 회원번호를 가져온다.
		long memberNo = ((MemberDTO)session.getAttribute("loginUser")).getMemberNo();
		
		// 좋아요 누른 상품 리스트를 가져온다.
		List<ProductVO> myFavoriteProductList = sqlSession.getMapper(ProductDAO.class).selectMyFavoriteProductList(memberNo);
		
		// 현재 내가 팔고있는 상품 리스트를 가져온다.
		List<ProductVO> myOnSaleProductList = sqlSession.getMapper(ProductDAO.class).selectMyOnSaleProductList(memberNo);
		
		model.addAttribute("myFavoriteProductList", myFavoriteProductList);
		model.addAttribute("myFavoriteProductListSize", myFavoriteProductList.size());

		model.addAttribute("myOnSaleProductList", myOnSaleProductList);
		model.addAttribute("myOnSaleProductListSize", myOnSaleProductList.size());
		
		

	}
}
