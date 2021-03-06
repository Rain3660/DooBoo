package com.koreait.dooboo.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.likeproduct.dto.LikeProductDTO;
import com.koreait.dooboo.product.command.ProductCommand;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;
import com.koreait.dooboo.vo.PageVO;

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
	public Map<String, Object> InsertsellProduct(
			ProductDTO productDTO
			, @RequestParam("mapNo") long mapNo
			, HttpServletResponse response
			, @RequestParam("uploadFile") MultipartFile[] uploadFiles){
		return productCommand.InsertsellProduct(productDTO, mapNo,response,uploadFiles);
	}
	
	@GetMapping(value="p.selectOneProduct")
	public String selectOneProduct(Model model , HttpServletRequest request) {
		model.addAttribute("request", request);
		productCommand.selectProductDetailByProductNo(model);
		return "product/productOne";
	}
	
	// ?????? ????????????(?????????)
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
	// ?????? ????????????(?????????)
	@PostMapping(value ="deleteFile")
	@ResponseBody
	public Map<String,Object> setDeleteFile(ProductimageDTO productImageDTO) {
		boolean deleteYn = productCommand.setDeleteFile(productImageDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}
	// ???????????? ?????? ???????????? ???????????? ?????????
	// page , city , region ??? ????????????.
	@PostMapping(value="p.selectProductList" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getProductList(Model model , @RequestBody PageVO pageVO){
		
		model.addAttribute("pageVO", pageVO);
		
		return productCommand.selectProductList(model);

	}
	@PostMapping(value="p.iLikeThisProduct" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String , Object> iLikeThisProduct(@RequestBody LikeProductDTO likeProductDTO, Model model){
		model.addAttribute("likeProductDTO", likeProductDTO);		
		return productCommand.iLikeThisProduct(model);
	}
	@PostMapping(value="p.iDontLikeThisProduct" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String , Object> iDontLikeThisProduct(@RequestBody LikeProductDTO likeProductDTO, Model model){
		model.addAttribute("likeProductDTO", likeProductDTO);		
		return productCommand.iDontLikeThisProduct(model);
	}

	@PostMapping(value="p.selectProductListByAddressAndQuery")
	@ResponseBody
	public Map<String, Object> selectProductListByAddressAndQuery(Model model , @RequestBody PageVO pageVO){
		model.addAttribute("pageVO", pageVO);
		
		return productCommand.selectProductListByAddressAndQuery(model);
		
	}
	@PostMapping(value="p.selectNewProductList")
	@ResponseBody
	public Map<String, Object> selectNewProductList(Model model , @RequestBody PageVO pageVO){
		model.addAttribute("pageVO", pageVO);
		
		return productCommand.selectNewProductList(model);
	}
	@PostMapping(value="p.selectPopularProductList")
	@ResponseBody
	public Map<String, Object> selectPopularProductList(Model model , @RequestBody PageVO pageVO){
		model.addAttribute("pageVO", pageVO);
		
		return productCommand.selectPopularProductList(model);
	}
}