package com.koreait.dooboo.product.dao;

import java.util.List;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.vo.ProductVO;

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
	public List<ProductVO> selectProductListByLocation(String location);
}