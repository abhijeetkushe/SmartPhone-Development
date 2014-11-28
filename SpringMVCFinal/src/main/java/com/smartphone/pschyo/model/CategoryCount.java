package com.smartphone.pschyo.model;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "categoryCount")
public class CategoryCount extends AbstractDTO {
	
	private String category;
	private int count;
	public String getCategory() {
		return category;
	}
	@XmlElement
	public void setCategory(String category) {
		this.category = category;
	}
	public int getCount() {
		return count;
	}
	@XmlElement
	public void setCount(int count) {
		this.count = count;
	}
	

}
