package model;

public class Subject {

    // ===== Go(JSON)準拠 =====
    private String subjectName;
    private String teacher;
    private String classRoom;
    private long id;

    /* ---------- Go(JSON) 用 ---------- */

    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getClassRoom() {
        return classRoom;
    }
    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }

    public String getTeacher() {
        return teacher;
    }
    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    /* ---------- 既存 JSP 互換 ---------- */

    // classname → subjectName
    public String getClassname() {
        return subjectName;
    }
    public void setClassname(String classname) {
        this.subjectName = classname;
    }

    // roomname → classRoom
    public String getRoomname() {
        return classRoom;
    }
    public void setRoomname(String roomname) {
        this.classRoom = roomname;
    }
    public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
}
