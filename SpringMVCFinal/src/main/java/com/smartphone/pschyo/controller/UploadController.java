package com.smartphone.pschyo.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Vector;

import net.ioncannon.model.LoginForm;
import net.ioncannon.model.UploadItem;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartphone.pschyo.model.CategoryCount;
import com.smartphone.pschyo.model.Question;
import com.smartphone.pschyo.model.ScoreValue;
import com.smartphone.pschyo.model.Test;
import com.smartphone.pschyo.model.XMLResponse;
import com.smartphone.pschyo.model.XmlCountResponse;
import com.smartphone.pschyo.persistence.SmartphoneDAOImpl;

@Controller
@RequestMapping(value = "/upload")
public class UploadController {

	public static final String XL_NAME = "Name";
	public static final String XL_TEST = "Test";
	public static final String XL_SCORE = "Score";
	public static final String XL_RESULT = "Result";
	
	@RequestMapping(value="/test/{name}", method = RequestMethod.GET)
	public @ResponseBody XMLResponse getTestsInXML(@PathVariable String name) {

		SmartphoneDAOImpl dao=new SmartphoneDAOImpl();
		try {
			ArrayList<Test> testList=null;
			if(name.equalsIgnoreCase("ALL"))
				testList=dao.getAllTestsForUser("SYSTEM",null);
			else
				testList=dao.getAllTestsForUser("SYSTEM",name);
			XMLResponse xmlResponse=new XMLResponse();
			xmlResponse.setTestList(testList);
			return xmlResponse;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value="/categorycount/{name}", method = RequestMethod.GET)
	public @ResponseBody XmlCountResponse getCategoryCountInXML(@PathVariable String name) {

		SmartphoneDAOImpl dao=new SmartphoneDAOImpl();
		try {
			ArrayList<CategoryCount> testList=null;
			testList=dao.getCatCount("SYSTEM");
			XmlCountResponse xmlResponse=new XmlCountResponse();
			xmlResponse.setCategoryCountList(testList);
			return xmlResponse;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	

	@RequestMapping(method = RequestMethod.GET)
	public String getUploadForm(Model model) {
		model.addAttribute(new UploadItem());
		return "upload/uploadForm";
	}
	
	@RequestMapping(value="/login",method = RequestMethod.GET)
	public String getLogin(Model model) {
		model.addAttribute(new UploadItem());
		return "login/login";
	}
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String submitLogin(UploadItem uploadItem, BindingResult result) {
		if (result.hasErrors()) {
			for (ObjectError error : result.getAllErrors()) {
				System.err.println("Error: " + error.getCode() + " - "
						+ error.getDefaultMessage());
			}
			return "redirect:/smartphone/upload";
		}


		return "redirect:/smartphone/upload";
	}

	@RequestMapping( method = RequestMethod.POST)
	public String create(UploadItem uploadItem, BindingResult result) {
		if (result.hasErrors()) {
			for (ObjectError error : result.getAllErrors()) {
				System.err.println("Error: " + error.getCode() + " - "
						+ error.getDefaultMessage());
			}
			return "upload/uploadForm";
		}

		// Some type of file processing...
		System.err.println("-------------------------------------------");
		System.err.println("Test upload: " + uploadItem.getName());
		System.err.println("Test upload: "
				+ uploadItem.getFileData().getOriginalFilename());
		System.err.println("-------------------------------------------");

		Test test = null;
		try {
			test = readExcelFile(uploadItem.getFileData().getInputStream());
			SmartphoneDAOImpl dao = new SmartphoneDAOImpl();
			dao.insertTest(test, "SYSTEM");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// Print the data read

		return "upload/uploadForm";
	}

	public Test readExcelFile(InputStream myInput) {

		Test pscyhoTest = new Test();
		try {

			POIFSFileSystem myFileSystem = new POIFSFileSystem(myInput);
			HSSFWorkbook myWorkBook = new HSSFWorkbook(myFileSystem);

			this.readName(myWorkBook, pscyhoTest);
			this.readTest(myWorkBook, pscyhoTest);
			this.readScore(myWorkBook, pscyhoTest);
			this.readResult(myWorkBook, pscyhoTest);
			System.out.println(pscyhoTest);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pscyhoTest;
	}

	private void readName(HSSFWorkbook myWorkBook, Test test) {
		HSSFSheet mySheet = myWorkBook.getSheet(XL_NAME);
		HSSFRow nameRow = mySheet.getRow(1);

		HSSFCell nameCell = nameRow.getCell(0);
		String name = nameCell.getRichStringCellValue().getString();
		test.setTestName(name);
		System.out.println("Name of the Test" + name);

		HSSFCell categoryCell = nameRow.getCell(1);
		String category = categoryCell.getRichStringCellValue().getString();
		test.setTestCategory(category);
		System.out.println("Category of the Test" + category);

	}

	private void readTest(HSSFWorkbook myWorkBook, Test test) {
		HSSFSheet mySheet = myWorkBook.getSheet(XL_TEST);
		Iterator<Row> rowIter = mySheet.rowIterator();
		int rowCount = 0;
		ArrayList<Question> questionList = new ArrayList<Question>();
		test.setQuestionList(questionList);
		while (rowIter.hasNext()) {
			if (rowCount == 0) {
				rowIter.next();
				rowCount++;
				continue;
			}

			Question query = new Question();
			HSSFRow questionRow = (HSSFRow) rowIter.next();
			HSSFCell questionCell = questionRow.getCell(0);
			String question = questionCell.getRichStringCellValue().getString();
			query.setQuestion(question);
			System.out.println("Question " + rowCount + " " + question);
			System.out.println("\t");

			HSSFCell option1Cell = questionRow.getCell(1);
			String option1 = option1Cell.getRichStringCellValue().getString();
			query.setOption1(option1);

			System.out
					.print("Option 1 for Question" + rowCount + " " + option1);

			HSSFCell option2Cell = questionRow.getCell(2);
			String option2 = option2Cell.getRichStringCellValue().getString();
			query.setOption2(option2);
			System.out.print("Option 2 Question" + rowCount + " " + option2);

			HSSFCell option3Cell = questionRow.getCell(3);
			String option3 = option3Cell.getRichStringCellValue().getString();
			query.setOption3(option3);

			System.out
					.print("Option 3 for Question" + rowCount + " " + option3);

			HSSFCell option4Cell = questionRow.getCell(4);
			String option4 = option4Cell.getRichStringCellValue().getString();
			query.setOption4(option4);
			System.out
					.print("Option 4 for Question" + rowCount + " " + option4);
			questionList.add(query);
			rowCount++;
		}

	}

	private void readScore(HSSFWorkbook myWorkBook, Test test) {
		HSSFSheet mySheet = myWorkBook.getSheet(XL_SCORE);
		Iterator<Row> rowIter = mySheet.rowIterator();
		int rowCount = 0;
		ArrayList<Question> questionList = test.getQuestionList();
		while (rowIter.hasNext()) {
			if (rowCount == 0) {
				rowIter.next();
				rowCount++;
				continue;
			}

			Question question = questionList.get(rowCount - 1);
			HSSFRow questionRow = (HSSFRow) rowIter.next();

			System.out.println("Question " + rowCount + " Score");
			System.out.println("\t");

			HSSFCell option1Cell = questionRow.getCell(0);
			double option1 = option1Cell.getNumericCellValue();
			System.out
					.print("Option 1 for Question" + rowCount + " " + option1);
			question.setScore1(option1);

			HSSFCell option2Cell = questionRow.getCell(1);
			double option2 = option2Cell.getNumericCellValue();
			System.out.print("Option 2 Question" + rowCount + " " + option2);
			question.setScore2(option2);

			HSSFCell option3Cell = questionRow.getCell(2);
			double option3 = option3Cell.getNumericCellValue();
			System.out
					.print("Option 3 for Question" + rowCount + " " + option3);
			question.setScore3(option3);

			HSSFCell option4Cell = questionRow.getCell(3);
			double option4 = option4Cell.getNumericCellValue();
			System.out
					.print("Option 4 for Question" + rowCount + " " + option4);
			question.setScore4(option4);
			rowCount++;
		}
	}

	private void readResult(HSSFWorkbook myWorkBook, Test test) {
		HSSFSheet mySheet = myWorkBook.getSheet(XL_RESULT);
		Iterator<Row> rowIter = mySheet.rowIterator();
		int rowCount = 0;
		
		ArrayList<ScoreValue> resultList=new ArrayList<ScoreValue>();
		test.setResultList(resultList);
		while (rowIter.hasNext()) {
			if (rowCount == 0) {
				rowIter.next();
				rowCount++;
				continue;
			}

			HSSFRow resultRow = (HSSFRow) rowIter.next();
			HSSFCell scoreCell = resultRow.getCell(0);
			double option1 = scoreCell.getNumericCellValue();
			HSSFCell resultCell = resultRow.getCell(1);
			String option2 = resultCell.getRichStringCellValue().getString();
			ScoreValue sv=new ScoreValue();
			sv.setScore(option1);
			sv.setResult(option2);
			resultList.add(sv);
			rowCount++;
		}
	}

	private void printCellDataToConsole(Vector dataHolder) {

		for (int i = 0; i < dataHolder.size(); i++) {
			Vector cellStoreVector = (Vector) dataHolder.elementAt(i);
			for (int j = 0; j < cellStoreVector.size(); j++) {
				HSSFCell myCell = (HSSFCell) cellStoreVector.elementAt(j);
				String stringCellValue = myCell.toString();
				System.out.print(stringCellValue + "\t");
			}
			System.out.println();
		}
	}

}
