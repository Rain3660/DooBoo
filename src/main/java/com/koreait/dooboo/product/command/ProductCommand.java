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

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;
import com.koreait.dooboo.util.UtilsText;

@Service("productCommand")
public class ProductCommand {
	
	@Autowired
	private ProductDAO productDAO;
	
/*	public boolean registerBoard(ProductDTO params) {
		int queryResult = 0;
		//일단 임시값
		params.setRegNo(1);
		params.setModNo(1);
		
		for(FileUpload fileUpload : params.getFileUploadList()) {
			ProductimageDTO productimageDTO = null;
			try {
				String fileName = UtilsText.concat(UtilsText.parseFileRename(), ".", fileUpload.getExt());
				String filePath = UtilsText.getFilePath("product");
				//파일생성
				fileUpload.transferTo(filePath, fileName, true);
				productimageDTO = new ProductimageDTO();
				Long productNo = params.getProductNo();
				productimageDTO.setProductNo(productNo.intValue()); 
				productimageDTO.setFileName(fileUpload.getOrgFileName());
				productimageDTO.setFilePath(filePath+fileName);
				productimageDTO.setRegNo(1111);

			} catch (Exception e) {
				e.printStackTrace();
			}
			if(null != productimageDTO) {
				System.out.println(productimageDTO);
				productDAO.insertProductImage(productimageDTO);
			}
		}
		
		if (params.getProductNo() == 0) {
			queryResult = productDAO.insertBoard(params);
		} else {
			queryResult = productDAO.updateBoard(params);
		}

		return (queryResult == 1) ? true : false;
	}
	*/
	
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
	
	public ProductDTO selectOneProduct(long productNo){
		 ProductDTO productDTO= productDAO.selectOneProduct(productNo);
		return productDTO;
	}
	
	public int getLikesCount(long productNo) {
		int likes = productDAO.getLikesCount(productNo);
		return likes;
	}
}