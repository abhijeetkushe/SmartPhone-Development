package com.smartphone.pschyo.model;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "scoreresult")
public class ScoreValue extends AbstractDTO {
	
	private double score;
	private String result;
	public double getScore() {
		return score;
	}
	@XmlElement
	public void setScore(double score) {
		this.score = score;
	}
	public String getResult() {
		return result;
	}
	@XmlElement
	public void setResult(String result) {
		this.result = result;
	}
	
	

}
