package com.koreait.dooboo.product.command;


import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.dooboo.communityboard.dto.ListPagingDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingInfo;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductDTO;

@Service("productCommand")
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
	
	// 판매할 상품을 등록한다 
	public void sellProduct(ProductDTO productDTO , MultipartHttpServletRequest multipartRequest) {
		// productDTO 에는 가격 , 제목 , 내용 , location 저장되있음 
		// multipartRequest 에는 파일이 들어있음
		
		// multipartRequest 로부터 세션을 구한다.
		HttpSession session = multipartRequest.getSession();
		
		// 판매글을 작성한 사람 = loginUser
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		long memberNo = loginUser.getMemberNo();
		// 작성자 설정
		productDTO.setRegNo(memberNo);
		// DB 에 업데이트
		
		productDAO.insertProduct(productDTO);
		updateProductImageFiles(productDTO, multipartRequest);
	}
	
	// 상품 판매시 업로드한 이미지 파일을 처리한다
	public void updateProductImageFiles(ProductDTO productDTO , MultipartHttpServletRequest multipartRequest) {
		System.out.println("업로드 할게요");
		// 업로드한 파일들
		List<MultipartFile> files = multipartRequest.getFiles("images");
		
		// Session
		HttpSession session = multipartRequest.getSession();
		// 작성자
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		long regNo = loginUser.getMemberNo();
		
	/*	for (MultipartFile multipartFile : files) {
			
			if(!multipartFile.isEmpty() && multipartFile != null) {
				// 올린 파일의 이름
				String fileName = multipartFile.getOriginalFilename();
				
				// 서버에 저장할 파일명
				
				// 확장자
				String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
				String withoutExtensionFileName = fileName.substring(0 , fileName.lastIndexOf("."));
				
				// 서버에 올릴 파일이름 : 파일명_올린시간.확장자
				String filePath = withoutExtensionFileName + "_" + System.currentTimeMillis() + "." + extension;
				
				// 첨부파일을 서버에 저장한다.
				String realPath = multipartRequest.getServletContext().getRealPath("resources/archive");
				
				// Archive 디렉터리를 만든다 , 없다면 생성한다.				
				File archive = new File(realPath);
				
				if(!archive.exists()) {
					archive.mkdirs();
				}
				
				// 디렉터리에 첨부파일을 저장한다.
				
				File uploadFile = new File(archive , filePath);
				
				try {
					multipartFile.transferTo(uploadFile);
				} catch (Exception e) {
					// TODO: handle exception
				}
				
				// DB에 넣는 파일명을 인코딩 한다.
				try {
					filePath = URLEncoder.encode(filePath, "utf-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				// DB 에 저장.
				ProductImageDTO productImageDTO = new ProductImageDTO();
				productImageDTO.setRegNo(regNo);
				productImageDTO.setFilePath(filePath);
				productImageDTO.setFileName(fileName);
				//productDAO.uploadImageFile(productImageDTO);				
			}
		}*/
	}
	
/*	// 판매등록한 상품을 삭제한다.
	public void deleteProduct(HttpServletRequest request , HttpServletResponse response) {
		
		long productNo = Long.parseLong(request.getParameter("productNo"));
		
		// product 테이블 삭제
		int deleteProductResult = productDAO.deleteProduct(productNo);
		
		List<ProductImageDTO> productImageList = productDAO.selectProductImageByProductNo(productNo);
		
		if(productImageList.size() != 0) { // 저장된 이미지가 있다면,
			
			for (ProductImageDTO productImageDTO : productImageList) {
				
				String realPath = request.getServletContext().getRealPath("resources/archive");
				File file = new File(realPath , productImageDTO.getFilePath());
				System.out.println(file.getName() + "파일을 삭제합니다.");
				file.delete();
			}
			
			// 모든 파일을 삭제하고 DB 업데이트
			productDAO.deleteProductImage(productNo);
			
		}
		
		
	}*/
}
