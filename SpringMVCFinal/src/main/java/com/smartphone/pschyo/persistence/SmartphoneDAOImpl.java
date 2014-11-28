package com.smartphone.pschyo.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.smartphone.pschyo.model.CategoryCount;
import com.smartphone.pschyo.model.Question;
import com.smartphone.pschyo.model.ScoreValue;
import com.smartphone.pschyo.model.Test;



public class SmartphoneDAOImpl {
	
	private static final String  URL="jdbc:oracle:thin:@Abhijeet-PC:1521/XE";
	private static final String USERNAME="smartphone";
	private static final String PASSWORD="smartphone";
	
	private static final String INSERTTEST_SQL="Insert Into test(testID,name,category ) values (?,?,?)";
	private static final String INSERTTEST_DTLS_SQL="Insert Into testdetails(testID,QUESTION,OPTION1,OPTION2,OPTION3,OPTION4,SCORE1,SCORE2,SCORE3,SCORE4,CREATEDBY,CREATEDDATE) "+
	"values (?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String INSERTTEST_KEY_SQL="Insert Into testkey(testID,score,result) values (?,?,?)";
	
	private static final String GETTEST_INFO="SELECT test.testID,name,category,QUESTION,OPTION1,OPTION2,OPTION3,OPTION4,SCORE1,SCORE2,SCORE3,SCORE4  FROM test, testdetails "+
	"WHERE test.testid=testdetails.testid  ORDER BY test.testID,testdetails.createddate ASC";
	
	private static final String GETTEST_CATEGORY="SELECT test.testID,name, category, QUESTION, OPTION1,OPTION2, OPTION3, OPTION4, SCORE1, SCORE2, SCORE3, SCORE4 FROM test, testdetails "+
	" WHERE test.testid=testdetails.testid AND UPPER(test.category)= ? ORDER BY test.testID,testdetails.createddate ASC";
	
	private static final String GETTEST_KEYINFO="SELECT score,result FROM testkey WHERE testID=?";
	
	private static final String GET_CAT_COUNT="SELECT category,count(*) FROM test GROUP BY category";
	private Connection getConnection() throws SQLException
	{
		try
		{
		 // Load the Oracle JDBC driver"
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection conn = DriverManager.getConnection(URL,USERNAME,PASSWORD);	
			return conn;
		} 
		catch(SQLException e)
		{
			e.printStackTrace();
			
			throw e;
		}
	}
	public ArrayList<CategoryCount> getCatCount(String userName) throws SQLException{
		ArrayList<CategoryCount> list=new ArrayList<CategoryCount>();
		Connection conn = this.getConnection();
		PreparedStatement st = conn.prepareStatement(GET_CAT_COUNT);
		ResultSet rs = st.executeQuery();
		while(rs.next())
		{
			CategoryCount count=new CategoryCount();
			count.setCategory(rs.getString(1).toUpperCase());
			count.setCount(rs.getInt(2));
			list.add(count);
		}
		st.close();
		conn.close();
		return list;
	}
	
	public ArrayList<Test> getAllTestsForUser(String userName,String category) throws SQLException{
		ArrayList<Test> list=new ArrayList<Test>();
		Connection conn = this.getConnection();
		String query=null;
		if(category!=null){
			query=GETTEST_CATEGORY;
		}else{
			query=GETTEST_INFO;
		}
		PreparedStatement st = conn.prepareStatement(query);
		if(category!=null){
			st.setString(1, category.toUpperCase());
		}
		ResultSet rs =st.executeQuery();
		
		long current=0;
		Test test=null;
		ArrayList<Question> questionList=null;
		while(rs.next()){
			long testID=rs.getLong(1);

			if(current!=testID){
				test=new Test();
				list.add(test);
				questionList=new ArrayList<Question>();
				test.setQuestionList(questionList);
				current=testID;
				test.setTestID(testID);
				test.setTestName(rs.getString(2));
				test.setTestCategory(rs.getString(3));
			}	
			Question question =new Question();
			questionList.add(question);
			question.setQuestion(rs.getString(4));
			question.setOption1(rs.getString(5));
			question.setOption2(rs.getString(6));
			question.setOption3(rs.getString(7));
			question.setOption4(rs.getString(8));
			question.setScore1(rs.getDouble(9));
			question.setScore2(rs.getDouble(10));
			question.setScore3(rs.getDouble(11));
			question.setScore4(rs.getDouble(12));			
		}
		rs.close();
		st.close();
		
		for(Test tempTest:list){
			
			st = conn.prepareStatement(GETTEST_KEYINFO);
			st.setLong(1,tempTest.getTestID());
			rs =st.executeQuery();
			ArrayList<ScoreValue> resultList=new ArrayList<ScoreValue>();
			tempTest.setResultList(resultList);
			while(rs.next()){
				ScoreValue sv=new ScoreValue();
				sv.setScore(rs.getDouble(1));
				sv.setResult(rs.getString(2));
				resultList.add(sv);
			}
			rs.close();
			st.close();
		}
		

		conn.close();
		return list;
	}
	
	public void insertTest(Test test,String person) throws SQLException{
			Connection conn = this.getConnection();
			Statement sta = conn.createStatement();
			ResultSet rs = sta.executeQuery("Select max(testID) maxCount From test");
			rs.next();
			long id = rs.getLong("maxCount");
			sta.close();
			
			test.setTestID(++id);
			PreparedStatement st = conn.prepareStatement(INSERTTEST_SQL);
			st.setLong(1,id);
			st.setString(2,test.getTestName());
			st.setString(3,test.getTestCategory());
			st.executeUpdate();
			st.close();
			
			st = conn.prepareStatement(INSERTTEST_DTLS_SQL);
			for(Question q:test.getQuestionList()){
				st.setLong(1,id);
				st.setString(2,q.getQuestion());
				st.setString(3,q.getOption1());
				st.setString(4,q.getOption2());
				st.setString(5,q.getOption3());
				st.setString(6,q.getOption4());	
				st.setDouble(7,q.getScore1());	
				st.setDouble(8,q.getScore2());	
				st.setDouble(9,q.getScore3());	
				st.setDouble(10,q.getScore4());	
				st.setString(11,person);	
				st.setTimestamp(12, new Timestamp(new java.util.Date().getTime()));
				//st.setDate(12, new Date());
				st.addBatch();
			}
			
			st.executeBatch();
			st.close();
			
			
			st = conn.prepareStatement(INSERTTEST_KEY_SQL);
			for(ScoreValue sv:test.getResultList()){
				st.setLong(1,id);
				st.setDouble(2,sv.getScore());
				st.setString(3,sv.getResult());
				st.addBatch();
			}
						
			st.executeBatch();
			st.close();
			conn.close();
	}

	
	
}
