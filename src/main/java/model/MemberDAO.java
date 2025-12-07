package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	final private static String dbname = "tutorial";   // Postgre SQL DB name
	final private static String user = "dbpuser";     // Postgre SQL user name
	final private static String password = "hogehoge"; // Postgre SQL password
//	final private static String sqlHostname = "pgs";
	final private static String sqlHostname = "localhost";
	final private static String url = "jdbc:postgresql://" + sqlHostname + "/" + dbname;
	final private static String driverClassName = "org.postgresql.Driver";

	public boolean check(Member member) throws SQLException {
	    boolean result = false;
	    String sql = "select * from users where username=? and password=?";

	    try {
	        Class.forName(driverClassName);
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	        return false;
	    }

	    // try-with-resourcesを使用してConnection, PreparedStatement, ResultSetを自動で閉じる
	    try (Connection connection = DriverManager.getConnection(url, user, password);
	         PreparedStatement pstmt = connection.prepareStatement(sql)) {

	        pstmt.setString(1, member.getUsername());
	        pstmt.setString(2, member.getPassword());

	        try (ResultSet resultSet = pstmt.executeQuery()) {
	            if (resultSet.next()) result = true;
	        } // resultSet.close()はここで自動実行

	    } catch (SQLException e) {
	        // SQLExceptionは呼び出し元にスローされるが、念のためprintStackTraceも
	        e.printStackTrace();
	        throw e; 
	    }
	    return result;
	}
	public boolean insert(Member m) throws SQLException {
	    String sql = "INSERT INTO users (address, password, username, grade, classification) VALUES (?,?,?,?,?)";

	    try (Connection conn = DriverManager.getConnection(url, user, password);
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, m.getAddress());
	        pstmt.setString(2, m.getPassword());
	        pstmt.setString(3, m.getUsername());
	        pstmt.setString(4, m.getGrade());
	        pstmt.setString(5, m.getClassification());

	        pstmt.executeUpdate();
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
}