package com.smartphone.pschyo.model;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement(name = "SmartPhoneResponse")
public class XmlCountResponse extends AbstractDTO{
	private ArrayList<CategoryCount> categoryCountList=new ArrayList<CategoryCount>();

	public ArrayList<CategoryCount> getCategoryCountList() {
		return categoryCountList;
	}
	@XmlElementWrapper
	@XmlElement(name="categoryCount")
	public void setCategoryCountList(ArrayList<CategoryCount> categoryCountList) {
		this.categoryCountList = categoryCountList;
	}



	
	
}
