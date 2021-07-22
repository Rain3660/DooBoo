package com.koreait.dooboo.product.dao;

import java.util.List;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dto.ProductDTO;

public interface ProductDAO {
	public MapDTO getOneLocation(long mapNo); 
	public int insertSellProduct(ProductDTO productDTO);
	public ProductDTO getProductNo(long regNo);
	public ProductDTO selectOneProduct(long productNo);
	public int getLikesCount(long productNo);
}
