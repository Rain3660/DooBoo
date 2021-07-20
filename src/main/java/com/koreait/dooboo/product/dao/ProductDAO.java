package com.koreait.dooboo.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.productimage.dto.ProductImageDTO;

@Mapper
public interface ProductDAO {
	// 상품을 판매등록 한다.
	public int sellProduct(ProductDTO productDTO);
	
	// 판매등록할 때 업로드한 파일을 처리한다.
	public int uploadImageFile(ProductImageDTO productImageDTO);
	
	// 판매등록한 상품을 삭제한다.
	public int deleteProduct(long productNo);

	// 판매등록한 상품을 삭제할때 상품의 이미지가 있다면 삭제한다.
	public int deleteProductImage(long productNo);
	
	// 판매등록한 상품의 이미지 정보를 가져온다.
	public List<ProductImageDTO> selectProductImageByProductNo(long productNo);
}
