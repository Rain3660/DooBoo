package com.koreait.dooboo.util;

import java.io.File;

import org.apache.commons.io.FilenameUtils;

import org.springframework.web.multipart.MultipartFile;

import org.apache.commons.io.FileUtils;

public class FileUpload {

	private MultipartFile multiPartFile;
	private String fileName;
	private int index;

	public boolean isFileItem() {
		return getSize() > 0;
	}

	public FileUpload(MultipartFile mif) {
		this.multiPartFile = mif;
	}

	public MultipartFile getMultiPartFile() {
		return multiPartFile;
	}

	public String getParameterName() {
		return multiPartFile.getName();
	}

	public String getOrgFileName() {
		String fileName = multiPartFile.getOriginalFilename();
		fileName = FilenameUtils.getName(fileName);

		return fileName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public long getSize() {
		return multiPartFile.getSize();
	}

	public String getContentType() {
		return multiPartFile.getContentType();
	}

	public String getExt() {
		String orgFileName = getOrgFileName();

		if (orgFileName != null) {
			if (orgFileName.endsWith(".tar.gz")) {
				return "tar.gz";
			} else if (orgFileName.endsWith(".tar.bz2")) {
				return "tar.bz2";
			} else {
				orgFileName = orgFileName.toLowerCase();
			}
		}

		return FilenameUtils.getExtension(orgFileName);
	}

	public void transferTo(File path) throws Exception {
		multiPartFile.transferTo(path);
	}

	public void transferTo(String path, String fileName) throws Exception {
		transferTo(path, fileName, true);
	}

	public void transferTo(String path, String fileName, boolean mkdir) throws Exception {
		if (mkdir) {
			File pathFile = FileUtils.getFile(path);
			if (!pathFile.isDirectory()) {
				pathFile.mkdirs();
			}
		}

		FileUtils.copyInputStreamToFile(multiPartFile.getInputStream(),
				FileUtils.getFile(concat(path, File.separator, FilenameUtils.getName(fileName))));
	}
	
	public static String concat(String... arrStr) {
		StringBuilder sb = new StringBuilder();
		for (String concatStr : arrStr) {
			sb.append(concatStr);
		}
		return sb.toString();
	}	
}
