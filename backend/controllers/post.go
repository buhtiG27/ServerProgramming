package controllers

import (
	"log"
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type CreatePostInput struct {
	IsQuestion   bool   `gorm:"not null;" json:"is_question" binding:"required"`
	ParentID     uint   `json:"parent_id"`
	ContentsText string `gorm:"not null;" json:"contents_text" binding:"required"`
	Image_path   string
}

func Post(c *gin.Context) {
	var input CreatePostInput

	// リクエストのJSONデータをPostInput構造体にバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// コンテキストからユーザIDを抽出する
	// v, ok := c.Get("userID")
	// log.Println("v before insert:", v)
	// if !ok {
	// 	c.JSON(http.StatusUnauthorized, gin.H{"error": "user id not found"})
	// 	return
	// }
	// creatorID := v.(uint)
	creatorID := c.GetUint("userID")
	log.Println("creatorID before insert:", creatorID)

	// 親ポストをデータベースから取得する
	var parentID *uint = nil
	if !input.IsQuestion {
		parentID = &input.ParentID
		if err := models.DB.First(&models.Post{}, parentID).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "parent post not found"})
		}
	}

	// ポストオブジェクトを作成し，データベースに保存する
	post := &models.Post{
		IsQuestion:   input.IsQuestion,
		ParentID:     parentID,
		CreatorID:    creatorID,
		ContentsText: input.ContentsText,
	}
	post, err := post.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// 成功した場合，ポスト情報をレスポンスとして返す
	c.JSON(http.StatusOK, gin.H{
		"data": post,
	})
}

func GetPosts(c *gin.Context) {
	var posts []models.Post
	if err := models.DB.Where("parent_id IS NULL").Order("created_at desc").Preload("Creator").Find(&posts).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"posts": posts,
	})
}
