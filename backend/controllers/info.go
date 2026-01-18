package controllers

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type TimetableInput struct {
	SubjectID uint `json:"subject_id" binding:"required"`
}

func SetTimetable(c *gin.Context) {
	var input TimetableInput

	// 受け取ったJSONをバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// リクエストしたユーザのユーザIDの取得
	userID := c.GetUint("userID")

	// TODO:存在しないSubjectのときのエラーハンドリング

	// タイムテーブルオブジェクトの作成 保存
	timetable := &models.Timetable{
		UserID:    userID,
		SubjectID: input.SubjectID,
	}
	timetable, err := timetable.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 成功した場合，時間割情報を返す
	c.JSON(http.StatusOK, gin.H{
		"data": timetable,
	})

}

func GetTimetable(c *gin.Context) {
	var timetables []models.Timetable

	// ユーザIDの取得
	userID := c.GetUint("userID")

	// データベースからそのユーザの時間割を全て取得する
	if err := models.DB.Where(&models.Timetable{UserID: userID}).Select("subject_id").Preload("Subject").Find(&timetables).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"timetables": timetables,
	})

}

func GetUserPosts(c *gin.Context) {

	// ユーザIDの取得
	accountID := c.GetUint("userID")

	var usersPost []models.Post
	// ユーザIDに基づいてユーザ情報をデータベースから取得する
	if err := models.DB.Where(&models.Post{CreatorID: accountID}).Preload("Practice").Preload("Parent").Find(&usersPost).Error; err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"usersPost": usersPost,
	})
}
