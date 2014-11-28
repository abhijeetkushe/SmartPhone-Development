package com.smartphone.pschyo.model;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "SmartPhoneResponse")
public class XMLResponse extends AbstractDTO {
	private ArrayList<Test> testList=new ArrayList<Test>();

	public ArrayList<Test> getTestList() {
		return testList;
	}
	@XmlElementWrapper
	@XmlElement(name="test")
	public void setTestList(ArrayList<Test> testList) {
		this.testList = testList;
	}
	

}
