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

    private String subjectWeekday;
    private int subjectWeekdayNum;
    private String subjectTime;

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

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
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

    public int getSubjectWeekdayNum() {
        return subjectWeekdayNum;
    }

    public String getSubjectWeekday() {
        return subjectWeekday;
    }

    public void setSubjectWeekday(String subjectWeekday) {
        this.subjectWeekday = subjectWeekday;
        this.subjectWeekdayNum = convertWeekday(subjectWeekday);

    }

    private int convertWeekday(String weekday) {
        return switch (weekday) {
            case "Mon" -> 0;
            case "Tue" -> 1;
            case "Wed" -> 2;
            case "Thu" -> 3;
            case "Fri" -> 4;
            default -> -1;
        };
    }

    public String getSubjectTime() {
        return subjectTime;
    }

    public void setSubjectTime(String subjectTime) {
        this.subjectTime = subjectTime;
    }

}