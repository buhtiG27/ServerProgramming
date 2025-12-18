package model;

import java.io.Serializable;

public class Task implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int subjectId;
	private String subjectName;
	
	private String content;
	private String limmit;
	private String output;
	private String detail;

	public Task() {
        this.content = "";
        this.limmit = "";
        this.output = "";
        this.detail = "";
	}

	public int getId() { 
		return id; 
	}
	
	public void setId(int id) {
        this.id = id;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    public String getClassname() { 
    	return subjectName; 
    }
    public void setClassname(String subjectName) {
    	this.subjectName = subjectName; 
    }

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    public String getLimmit() {
        return limmit;
    }

    public void setLimmit(String limmit) {
        this.limmit = limmit;
    }
    public String getOutput() {
        return output;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
}