package com.koreait.dooboo.communityboard.dto;
import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;

@Repository
public class CommunityBoardDTO extends ListPagingDTO{
	
/*	 @SuppressWarnings("unused")
	private static final long serialVersionUID = 362498820763181265L; */

    // 게시판번호 1부터 시작
    private long boardNo;

    // 게시판 rownum
    private long rnum;
    
    // 글제목 
    private String title;

    // 내용 
    private String content;

    // 조회수 
    private int hit;

    // 등록자 
    private int regNo;

    // 수정자 
    private int modNo;

    // 등록일 
    private Date regDate;

    // 수정일 
    private Date modDate;
    
    // 삭제여부
    private String delYn;
    
    // 닉네임
    private String nickname;
    
    // 첨부파일 
    private List<ProductimageDTO> productImageList; 
    
    public List<ProductimageDTO> getProductImageList() {
		return productImageList;
	}


	public void setProductImageList(List<ProductimageDTO> productImageList) {
		this.productImageList = productImageList;
	}

	// 첨부파일 
    private List<FileUpload> fileUploadList; 
    

	public List<FileUpload> getFileUploadList() {
		return fileUploadList;
	}


	public void setFileUploadList(List<FileUpload> fileUploadList) {
		this.fileUploadList = fileUploadList;
	}


	public CommunityBoardDTO() {}
    
    
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

    public long getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(long boardNo) {
        this.boardNo = boardNo;
    }

    public long getRnum() {
		return rnum;
	}

	public void setRnum(long rnum) {
		this.rnum = rnum;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public int getRegNo() {
        return regNo;
    }

    public void setRegNo(int regNo) {
        this.regNo = regNo;
    }

    public int getModNo() {
        return modNo;
    }

    public void setModNo(int modNo) {
        this.modNo = modNo;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getModDate() {
        return modDate;
    }

    public void setModDate(Date modDate) {
        this.modDate = modDate;
    }

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
}