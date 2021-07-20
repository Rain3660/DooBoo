package com.koreait.dooboo.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;

@Controller
public class ProductController {

	@Autowired
	private ProductCommand productCommand;

	@GetMapping("p.sellProductPage")
	public ModelAndView sellProductPage(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("product/sellProductPage");

		return mav;
	}
	
	// 판매 상품을 등록한다
	@PostMapping("p.sellProduct")
	public ModelAndView sellProduct(MultipartHttpServletRequest multipartRequest, ProductDTO productDTO) {

		ModelAndView mav = new ModelAndView();

		productCommand.sellProduct(productDTO, multipartRequest);

		mav.setViewName("redirect:/");

		return mav;
	}
	// 판매등록한 상품을 삭제한다.
	@GetMapping("p.deleteProduct")
	public ModelAndView deleteProduct(HttpServletRequest request , HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		return mav;
	}
}
