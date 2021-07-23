package com.koreait.dooboo.product.command;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;
import com.koreait.dooboo.util.PagingUtils;
import com.koreait.dooboo.util.UtilsText;
import com.koreait.dooboo.vo.PageVO;
import com.koreait.dooboo.product.dto.ProductVO;


@Service("productCommand")
public class ProductCommand {
	
	@Autowired
	private ProductDAO productDAO;
	
	// 파일 업로드 및  게시글 수정 관련 (홍보람)
	public boolean registerBoard(ProductDTO params) {
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
			queryResult = productDAO.insertSellProduct(params);
		} else {
			queryResult = productDAO.updateBoard(params);
		}

		return (queryResult == 1) ? true : false;
	}
	
	// 파일 삭제 관련(홍보람)
	public boolean setDeleteFile(ProductimageDTO productImageDto) {
		int queryResult = 0;
		queryResult = productDAO.deleteFile(productImageDto);
		return (queryResult == 1) ? true : false;
	}	
	
	
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
	
	public int getLikesCount(long productNo) {
		int likes = productDAO.getLikesCount(productNo);
		return likes;
	}
	
	/*public int getLikesCount(long productNo) {
		int likes = productDAO.getLikesCount(productNo);
		return likes;
	}*/
	
	public Map<String, Object> selectProductList(Model model){
		
		// 페이지 번호( default 1 ) , city region 을 가지고있습니다.
		PageVO pageVO = (PageVO)model.asMap().get("pageVO");
		int page = pageVO.getPage();
		// 총 데이터 수
		int totalRecord = productDAO.getTotalProductListCount();
		
		// 쿼리에 사용할 PageVO 
		PageVO pageAndQueryVO = PagingUtils.getPage(totalRecord, page);
		pageAndQueryVO.setCity(pageVO.getCity());
		pageAndQueryVO.setRegion(pageVO.getRegion());
		List<ProductVO> productList = productDAO.getProductList(pageAndQueryVO);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageAndQueryVO", pageAndQueryVO);
		resultMap.put("productList", productList);
		return resultMap;
	}
}

