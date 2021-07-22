package com.koreait.dooboo.product.command;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductVO;

@Service("productCommand")
public class ProductCommand {
	
	@Autowired
	private ProductDAO productDAO;
	
	public Map<String, Object> InsertsellProduct(ProductDTO productDTO,long mapNo,HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		MapDTO mapDTO = productDAO.getOneLocation(mapNo);
		productDTO.setAddress(mapDTO.getLocation());
		int result = productDAO.insertSellProduct(productDTO);
		ProductDTO insertNowProductDTO = productDAO.getProductNo(productDTO.getRegNo());
		if(result > 0 && insertNowProductDTO != null) {
			resultMap.put("result", result);
			resultMap.put("productNo", insertNowProductDTO.getProductNo());
		}
		return resultMap;
	}
	
	public ProductVO selectOneProduct(long productNo){
		 ProductVO productVO= productDAO.selectOneProduct(productNo);
		return productVO;
	}
	
/*//	public int getLikesCount(long productNo) {
//		int likes = productDAO.getLikesCount(productNo);
//		return likes;
//	}
*/}
