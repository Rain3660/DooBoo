package com.koreait.dooboo.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;

@Mapper
public interface ProductDAO {
	
	// 상품을 판매등록 한다.
	public int insertProduct(ProductDTO params);
	
	public ProductDTO selectProductDetail(long idx);
	
	public int updateProduct(ProductDTO params);
	
	public int deleteProduct(long idx);

	public List<ProductDTO> selectProductList(ProductDTO productDTO);
	
	public int selectProductTotalCount(ProductDTO productDTO);

	public int updateHit(long productNo);
	
	public int insertProductImage(ProductimageDTO productimageDTO);
}
