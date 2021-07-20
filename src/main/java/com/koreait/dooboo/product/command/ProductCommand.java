package com.koreait.dooboo.product.command;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingInfo;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductDTO;

@Service
public class ProductCommand {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ListPagingDTO listpagingDTO;
	
	
	public Map<String,Object> getBoardList(ProductDTO productDTO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		List<ProductDTO> productList = Collections.emptyList();
		int boardTotalCount = productDAO.selectProductTotalCount(productDTO);
		
		ListPagingInfo listPagingInfo = new ListPagingInfo();
		listPagingInfo.setListPagingVo(listpagingDTO);
		listPagingInfo.setTotalRecordCount(boardTotalCount);
		resultMap.put("boardTotalCount", boardTotalCount);
		if (boardTotalCount > 0) {
			
			productList = productDAO.selectProductList(productDTO);
			resultMap.put("productList", productList);
		}
		resultMap.put("listPagingInfo", listPagingInfo);

		return resultMap;
	}

}
