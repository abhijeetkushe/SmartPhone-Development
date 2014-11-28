package com.smartphone.pschyo.model;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "question")
public class Question extends AbstractDTO {
	private String question;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private double score1;
	private double score2;
	private double score3;
	private double score4;
	
	public String getQuestion() {
		return question;
	}
	@XmlElement
	public void setQuestion(String question) {
		this.question = question;
	}
	
	public String getOption1() {
		return option1;
	}
	@XmlElement
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	@XmlElement
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	
	public String getOption3() {
		return option3;
	}
	@XmlElement
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	@XmlElement
	public void setOption4(String option4) {
		this.option4 = option4;
	}

	
	public double getScore1() {
		return score1;
	}
	@XmlElement
	public void setScore1(double score1) {
		this.score1 = score1;
	}
	public double getScore2() {
		return score2;
	}
	@XmlElement
	public void setScore2(double score2) {
		this.score2 = score2;
	}
	public double getScore3() {
		return score3;
	}
	@XmlElement
	public void setScore3(double score3) {
		this.score3 = score3;
	}
	public double getScore4() {
		return score4;
	}
	@XmlElement
	public void setScore4(double score4) {
		this.score4 = score4;
	}
	
	
}
