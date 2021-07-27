package com.koreait.dooboo.product.dao;

import java.util.List;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.product.dto.ProductDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.vo.PageVO;
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
	public String getOneImage(long productNo);
	
	// 총 데이터 수 반환
	public int getTotalProductListCount(PageVO pageVO);
	// 검색 조건에 맞는 데이터 반환
	public List<ProductVO> getProductList(PageVO pageVO);
	// 상품번호에 해당하는 상품 상세정보 가져오기
	public ProductVO selectProductDetailByProductNo(long productNo);
	// 상품번호에 해당하는 상품 상세정보를 볼 때 그 판매자가 팔고 있는 상품 리스트 보기 , 등록순으로 4개만 가져오도록 한다.
	public List<ProductVO> getProductListOfSeller(long regNo);
	// 조회수 증가시키기
	public int updateHit(long productNo);
	// 좋아요
	public int iLikeThisProduct(long productNo , long regNo);
	
}