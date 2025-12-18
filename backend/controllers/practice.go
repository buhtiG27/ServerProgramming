package controllers

import (
	"net/http"
	"strconv"
	"time"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type SetPracticeInput struct {
	SubjectID    uint      `json:"subject_id" binding:"required"`
	PracticeName string    `json:"practice_name" binding:"required"`
	Place        string    `json:"place"`
	Description  string    `json:"description"`
	Deadline     time.Time `json:"deadline"`
}

func SetPractice(c *gin.Context) {
	var input SetPracticeInput

	// 受け取ったJSONをバインド
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// TODO:Subjectの存在チェック

	// Practiceオブジェクトを作成し登録
	practice := &models.Practice{
		SubjectID:    &input.SubjectID,
		PracticeName: input.PracticeName,
		Place:        input.Place,
		Description:  input.Description,
		Deadline:     input.Deadline,
	}
	practice, err := practice.Save()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 成功時のデータの返却
	c.JSON(http.StatusOK, gin.H{
		"practice": practice,
	})
}

// 科目が持つすべての課題を表示
// 科目IDをパスパラメータで受け取る
func GetPractices(c *gin.Context) {
	subjectID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 科目IDでデータベースから検索
	var practices []models.Practice
	if err := models.DB.Where("subject_id = ?", subjectID).Preload("Subject").Find(&practices).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 成功時のデータの返却
	c.JSON(http.StatusOK, gin.H{
		"practices": practices,
	})
}

// IDから一つの課題情報を表示
// /practice/:id
// 課題に紐づいた投稿一覧の取得も一緒にする
func GetPractice(c *gin.Context) {
	// パスパラメータを取得
	practiceID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// 課題IDでデータベースから検索
	var practice models.Practice
	if err := models.DB.Preload("Subject").First(&practice, practiceID).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	var posts []models.Post
	if err := models.DB.Where("practice_id = ?", practiceID).Where("parent_id IS NULL").Preload("Creator").Find(&posts).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	postsResp := GetPostsTemplate(posts)

	// 成功時のデータの返却
	c.JSON(http.StatusOK, gin.H{
		"practice": practice,
		"posts":    postsResp,
	})
}
