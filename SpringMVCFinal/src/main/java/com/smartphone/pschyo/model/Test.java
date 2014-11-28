package com.smartphone.pschyo.model;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlAccessorOrder;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement(name = "test")
public class Test extends AbstractDTO {
	
	private long testID;
	private String testName;
	private String testCategory;
	private ArrayList<Question> questionList;
	private ArrayList<ScoreValue> resultList;

	public long getTestID() {
		return testID;
	}
	public void setTestID(long testID) {
		this.testID = testID;
	}
	
	public String getTestName() {
		return testName;
	}
	@XmlElement
	public void setTestName(String testName) {
		this.testName = testName;
	}
	public String getTestCategory() {
		return testCategory;
	}
	@XmlElement
	public void setTestCategory(String testCategory) {
		this.testCategory = testCategory;
	}
	
	public ArrayList<Question> getQuestionList() {
		return questionList;
	}
	@XmlElementWrapper
	@XmlElement(name="testquestion")
	public void setQuestionList(ArrayList<Question> questionList) {
		this.questionList = questionList;
	}
	public ArrayList<ScoreValue> getResultList() {
		return resultList;
	}
	@XmlElementWrapper
	@XmlElement(name="resultScore")
	public void setResultList(ArrayList<ScoreValue> resultList) {
		this.resultList = resultList;
	}
	
}
