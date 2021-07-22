package com.koreait.dooboo.product.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;

@Controller
public class ProductController {

	@Autowired
	private ProductCommand productCommand;
	
	@GetMapping(value="p.insertSellProduct")
	public ModelAndView sellProductPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/insertSellProduct");
		return mav;
	}
	
	@PostMapping(value="p.sellProduct")
	@ResponseBody
	public Map<String, Object> InsertsellProduct(ProductDTO productDTO,@RequestParam("mapNo") long mapNo,HttpServletResponse response) {
		
		return productCommand.InsertsellProduct(productDTO, mapNo,response);
		
	}
	
	@GetMapping(value="p.selectOneProduct")
	public ModelAndView selectOneProduct(@RequestParam("productNo") long productNo) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("likes",productCommand.getLikesCount(productNo));
		mav.addObject("productDTO",productCommand.selectOneProduct(productNo));
		mav.setViewName("product/productOne");
		return mav;
	}
	
}