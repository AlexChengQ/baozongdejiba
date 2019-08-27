package com.bylz.quantumCloud.model;

import java.io.Serializable;

public class AppBanner implements Serializable{
	private int questionid;
	private int blockid;
	private String answer;
	private int questiontype;
	private int examid;
	private String content;
	private String answerdetail;
	
	//用于进行数量统计
	private int num;
	

	public int getQuestionid() {
		return questionid;
	}
	public void setQuestionid(int questionid) {
		this.questionid = questionid;
	}
	public int getBlockid() {
		return blockid;
	}
	public void setBlockid(int blockid) {
		this.blockid = blockid;
	}
	public int getQuestiontype() {
		return questiontype;
	}
	public void setQuestiontype(int questiontype) {
		this.questiontype = questiontype;
	}
	public int getExamid() {
		return examid;
	}
	public void setExamid(int examid) {
		this.examid = examid;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getAnswerdetail() {
		return answerdetail;
	}
	public void setAnswerdetail(String answerdetail) {
		this.answerdetail = answerdetail;
	}
	
	
}
