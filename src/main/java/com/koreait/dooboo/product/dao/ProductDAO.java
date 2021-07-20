package com.koreait.dooboo.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.dooboo.product.dto.ProductDTO;

@Mapper
public interface ProductDAO {
	
	public List<ProductDTO> selectProductList(ProductDTO productDTO);
	
	public int selectProductTotalCount(ProductDTO productDTO);

	public int updateHit(long productNo);

}
