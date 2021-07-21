package com.koreait.dooboo.communityboard.command;


import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.dooboo.communityboard.dao.CommunityBoardDAO;
import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingInfo;
import com.koreait.dooboo.product.dao.ProductDAO;
import com.koreait.dooboo.product.dto.ProductImageDTO;
import com.koreait.dooboo.util.FileUpload;
import com.koreait.dooboo.util.UtilsText;

@Service("boardCommand")
public class BoardCommand{
	
	@Autowired
	private CommunityBoardDAO communityBoardDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ListPagingDTO listpagingDTO;
	
	public boolean registerBoard(CommunityBoardDTO params) {
		int queryResult = 0;
		//일단 임시값
		params.setRegNo(1);
		params.setModNo(1);
		
		/*String fileName = UtilsText.concat(UtilsText.parseFileRename(), ".", uploadFile.getExt());
		String filePath = this.getFilePath("adminnotice");*/
		
		for(FileUpload fileUpload : params.getFileUploadList()) {
			ProductImageDTO productimageDTO = null;
			try {
				String fileName = UtilsText.concat(UtilsText.parseFileRename(), ".", fileUpload.getExt());
				String filePath = UtilsText.getFilePath("product");
				//파일생성
				fileUpload.transferTo(filePath, fileName, true);
				productimageDTO = new ProductImageDTO();
				Long boardNo = params.getBoardNo();
				productimageDTO.setProductNo(boardNo.intValue()); //일단 게시물 번호로~~
				productimageDTO.setFileName(fileUpload.getOrgFileName());
				productimageDTO.setFilePath(filePath+fileName);
				productimageDTO.setRegNo(1111);

			} catch (Exception e) {
				e.printStackTrace();
			}
			if(null != productimageDTO) {
				System.out.println(productimageDTO);
				productDAO.insertProductImage(productimageDTO);
			}
		}
		
		if (params.getBoardNo() == 0) {
			queryResult = communityBoardDAO.insertBoard(params);
		} else {
			queryResult = communityBoardDAO.updateBoard(params);
		}

		return (queryResult == 1) ? true : false;
	}

	public CommunityBoardDTO getBoardDetail(long idx) {
		updateHit(idx);
		return communityBoardDAO.selectBoardDetail(idx);
	}
	
	public void updateHit(long boardNo) {
		communityBoardDAO.updateHit(boardNo);
	}
	
	public boolean deleteBoard(long idx) {
		int queryResult = 0;
		queryResult = communityBoardDAO.deleteBoard(idx);
		return (queryResult == 1) ? true : false;
	}

	public Map<String,Object> getBoardList(CommunityBoardDTO boardDTO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		List<CommunityBoardDTO> boardList = Collections.emptyList();
		int boardTotalCount = communityBoardDAO.selectBoardTotalCount(boardDTO);
		
		ListPagingInfo listPagingInfo = new ListPagingInfo();
		listPagingInfo.setListPagingVo(listpagingDTO);
		listPagingInfo.setTotalRecordCount(boardTotalCount);
		resultMap.put("boardTotalCount", boardTotalCount);
		if (boardTotalCount > 0) {
			boardList = communityBoardDAO.selectBoardList(boardDTO);
			resultMap.put("boardList", boardList);
		}
		resultMap.put("listPagingInfo", listPagingInfo);

		return resultMap;
	}
	
	public boolean setDeleteFile(ProductImageDTO productImageDto) {
		int queryResult = 0;
		queryResult = communityBoardDAO.deleteFile(productImageDto);
		return (queryResult == 1) ? true : false;
	}	
	
}


