package com.koreait.dooboo.product.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.util.FileUpload;

@Controller
public class ProductController {

	@Autowired
	private ProductCommand productCommand;
	
	@GetMapping("p.productList")
	public ModelAndView openBoardList(ProductDTO productDTO) {
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> resultMap = productCommand.getProductList(productDTO);
		mav.addObject("resultMap", resultMap);
		mav.addObject("params", productDTO);
		mav.setViewName("product/productList");
		return mav;
	}
	
	@GetMapping("productDetail")
	public ModelAndView openBoardDetail(ProductDTO productDTO) {
		
		ModelAndView mav = new ModelAndView();
		ProductDTO resultMap = productCommand.getProductDetail(productDTO.getProductNo());
		
		mav.addObject("product", resultMap);
		mav.setViewName("product/productRead");
		
		return mav; 
	}
	
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

		productCommand.insertProduct(productDTO, multipartRequest);

		mav.setViewName("redirect:/");

		return mav;
	}
	
	@GetMapping(value = "productUpdate")
	public ModelAndView openBoardUpdate(ProductDTO productDTO) {
		
		ModelAndView mav = new ModelAndView();
		ProductDTO resultMap = productCommand.getProductDetail(productDTO.getProductNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("product/productUpdate");
		
		return mav;
	}
	 
	@PostMapping(value ="productSave")
	@ResponseBody
	public Map<String,Object> openBoardSave(ProductDTO productDTO, @RequestParam("uploadFile") MultipartFile[] uploadFiles) {
		
		List<FileUpload> files = new ArrayList<FileUpload>(); 
		if(null != uploadFiles) {
			for(MultipartFile multiPartFile : uploadFiles) {
				FileUpload file = new FileUpload(multiPartFile);
				System.out.println(file.getFileName());
				System.out.println(file.getOrgFileName());
				files.add(file);
			}
			productDTO.setFileUploadList(files);
		}
		
		boolean saveYn = productCommand.registerBoard(productDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("saveYn", saveYn);
		return resultMap;
	}

	@PostMapping(value ="productDelete")
	@ResponseBody
	public Map<String,Object> openBoardDelete(CommunityBoardDTO boardDTO) {
		boolean deleteYn = productCommand.deleteProduct((int) boardDTO.getBoardNo());
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}


}
