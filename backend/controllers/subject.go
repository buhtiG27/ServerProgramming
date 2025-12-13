package controllers

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type SubjectSetInput struct {
	SubjectName string `json:"subject_name" binding:"required"`
	Description string `json:"description"`
	ClassRoom   string `json:"class_room"`
	Teacher     string `json:"teacher"`
	Koma        int    `json:"koma" binding:"required"`
	Units       int    `json:"units"`
	Period      string `json:"period"`
	Weekday     string `json:"weekday" binding:"required"`
	Time        string `json:"time" binding:"required"`
}

func SetSubject(c *gin.Context) {
	var input SubjectSetInput

	// JSONをバインド
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 科目オブジェクトを作成し，登録する
	subject := &models.Subject{
		SubjectName: input.SubjectName,
		Description: input.Description,
		ClassRoom:   input.ClassRoom,
		Teacher:     input.Teacher,
		Koma:        input.Koma,
		Units:       input.Units,
		Period:      input.Period,
		Weekday:     input.Weekday,
		Time:        input.Time,
	}
	subject, err := subject.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 成功時，科目データを返す
	c.JSON(http.StatusOK, gin.H{
		"subject_data": subject,
	})
}

type GetSubjectsInput struct {
	Weekday string `json:"weekday" binding:"required"`
	Time    string `json:"time" binding:"required"`
}

func GetSubjects(c *gin.Context) {
	var input GetSubjectsInput
	var subjects []models.Subject

	// インプットのJSONをバインド
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// データベースから科目一覧を取得
	if err := models.DB.Where("weekday = ?", input.Weekday).Where("time = ?", input.Time).Find(&subjects).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 成功時のデータの返却
	c.JSON(http.StatusOK, gin.H{
		"subjects": subjects,
	})
}
