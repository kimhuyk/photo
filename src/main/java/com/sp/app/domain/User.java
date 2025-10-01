package com.sp.app.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Data
public class User {
	private long userSeq;
	private String userId;
	private String userName;
	private String userPwd;
	private String regDate;
	
	// user_history 나름 상세?
	private String birth;
	private String email;
	private String tel;

	
	
	// photo_File
	private long fileNum;
	private String savefileName;        
	private String originalfileName;   
	private String filePath;
	//private String regDate;
	private MultipartFile selectFile;
	public long getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(long userSeq) {
		this.userSeq = userSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public long getFileNum() {
		return fileNum;
	}
	public void setFileNum(long fileNum) {
		this.fileNum = fileNum;
	}
	public String getSavefileName() {
		return savefileName;
	}
	public void setSavefileName(String savefileName) {
		this.savefileName = savefileName;
	}
	public String getOriginalfileName() {
		return originalfileName;
	}
	public void setOriginalfileName(String originalfileName) {
		this.originalfileName = originalfileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	
	
}
