package model;

import java.io.Serializable;

public class Member implements Serializable {
	private static final long serialVersionUID = 1L;
	private String address;
	private String password;
	private String username;
	private String grade;
	private String classification;

	public Member() {
		this.address = "";
        this.password = "";
        this.username = "";
        this.grade = "";
        this.classification = "";
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getClassification() {
        return classification;
    }
    public void setClassification(String classification) {
        this.classification = classification;
    }
}