package com.koreait.dooboo.product.dao;

import java.util.List;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductVO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.vo.PageVO;

public interface ProductDAO {
	//보람씨가 쓸 DAO
	public int insertProductImage(ProductimageDTO productimageDTO);
	
	public int deleteFile(ProductimageDTO productImageDto);

	public int updateBoard(ProductDTO params);
	
	//----------------------------------------------------------------
	
	public MapDTO getOneLocation(long mapNo); 
	public int insertSellProduct(ProductDTO productDTO);
	public ProductDTO getProductNo(long regNo);
	public ProductVO selectOneProduct(long productNo);
	public int getLikesCount(long productNo);
	
	// 총 데이터 수 반환
	public int getTotalProductListCount();
	// 검색 조건에 맞는 데이터 반환
	public List<ProductVO> getProductList(PageVO pageVO);
}