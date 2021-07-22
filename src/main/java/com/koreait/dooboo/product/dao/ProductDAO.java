package com.koreait.dooboo.product.dao;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;

public interface ProductDAO {
	//보람씨가 쓸 DAO
	public int insertProductImage(ProductimageDTO productimageDTO);
	
	public int deleteFile(ProductimageDTO productImageDto);

	public int updateBoard(ProductDTO params);
	
	//----------------------------------------------------------------
	
	public MapDTO getOneLocation(long mapNo); 
	public int insertSellProduct(ProductDTO productDTO);
	public ProductDTO getProductNo(long regNo);
	public ProductDTO selectOneProduct(long productNo);
	public int getLikesCount(long productNo);
}