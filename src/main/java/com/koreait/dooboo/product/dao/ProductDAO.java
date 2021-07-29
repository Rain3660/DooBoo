package com.koreait.dooboo.product.dao;

import java.util.List;

import com.koreait.dooboo.likeproduct.dto.LikeProductDTO;
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
	public int iLikeThisProduct(LikeProductDTO likeProductDTO);
	// 좋아요 취소
	public int iDontLikeThisProduct(LikeProductDTO likeProductDTO);
	// 좋아요 여부 판단 0 : 좋아요 안함 , 1 : 좋아요 함
	public int likeOrDislike(long memberNo , long productNo);
	// 좋아요 누른 상품 가져오기 4개 ㅠ
	public List<ProductVO> selectMyFavoriteProductList(long memberNo);
	// 내가 현재 판매중인 상품 가져오기 4개
	public List<ProductVO> selectMyOnSaleProductList(long memberNo);
	// 최근 본 상품 리스트 가져오기 4개
	public List<ProductVO> selectRecentlyViewProductList(List<Long> recentlyViewProductNo);
	
	// 우리동네에 해당하는 상품 갯수 출력하기
	public int getTotalMyRegionProductListCount(String city);
	// 검색어를 통해서 우리동네에 해당하는 상품 리스트 출력하기
	public List<ProductVO> getMyRegionProductList(PageVO pageVO);
	
}