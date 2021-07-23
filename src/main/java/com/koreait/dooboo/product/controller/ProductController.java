package com.koreait.dooboo.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductVO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;
import com.koreait.dooboo.util.GetMidLocation;

@Controller
public class ProductController {

	@Autowired
	private ProductCommand productCommand;
	
	
	@GetMapping(value="p.insertSellProductPage")
	public String sellProductPage() {		
		return "product/insertSellProduct";
	}
	
	@PostMapping(value="p.sellProduct")
	@ResponseBody
	public Map<String, Object> InsertsellProduct(ProductDTO productDTO,@RequestParam("mapNo") long mapNo,HttpServletResponse response) {
		return productCommand.InsertsellProduct(productDTO, mapNo,response);
		
	}
	
	@GetMapping(value="p.selectOneProduct")
	public String selectOneProduct(Model model,@RequestParam("productNo") long productNo) {
		model.addAttribute("productVO",productCommand.selectOneProduct(productNo));
		return "product/productOne";
	}
	
	// 파일 저장관련(홍보람)
	@PostMapping(value ="p.save")
	@ResponseBody
	public Map<String,Object> openBoardSave(ProductDTO productDTO,@RequestParam("uploadFile") MultipartFile[] uploadFiles) {
		
		List<FileUpload> files = new ArrayList<FileUpload>(); 
		if(null != uploadFiles) {
			for(MultipartFile multiPartFile : uploadFiles) {
				FileUpload file = new FileUpload(multiPartFile);
				files.add(file);
			}
			productDTO.setFileUploadList(files);
		}
		
		boolean saveYn = productCommand.registerBoard(productDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("saveYn", saveYn);
		return resultMap;
	}
	// 파일 삭제관련(홍보람)
	@PostMapping(value ="deleteFile")
	@ResponseBody
	public Map<String,Object> setDeleteFile(ProductimageDTO productImageDTO) {
		boolean deleteYn = productCommand.setDeleteFile(productImageDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}
	
	@GetMapping(value="p.selectProductListByLocation")
	@ResponseBody
	public Map<String, Object> selectProductListByLocation(@RequestParam("memberNo")long memberNo,Model model){	
		
		return productCommand.selectProductListByLocation(productCommand.getUseNowLocation(memberNo));
	}
	
	@GetMapping(value="p.productListPage")
	public String productListPage() {
		return "product/productList";
	}


	
}