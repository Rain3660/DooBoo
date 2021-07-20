package com.koreait.dooboo.product.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;

@Controller
public class ProductController {

	@Autowired
	private ProductCommand productCommand;
	
	@GetMapping(value = "ProductList")
	public ModelAndView openBoardList(ProductDTO productDTO) {
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> resultMap = productCommand.getBoardList(productDTO);
		mav.addObject("resultMap", resultMap);
		mav.addObject("params", productDTO);
		mav.setViewName("CommunityBoard/prodcuctList");
		return mav;
	}
	
}
