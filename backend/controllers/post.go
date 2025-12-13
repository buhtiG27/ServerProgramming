package controllers

import (
	"net/http"
	"time"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type CreatePostInput struct {
	PracticeID   uint   `json:"practice_id" binding:"required"`
	IsQuestion   bool   `json:"is_question" binding:"required"`
	ParentID     uint   `json:"parent_id"`
	ContentsText string `json:"contents_text" binding:"required"`
	ImagePath    string `json:"image_path"`
}

func Post(c *gin.Context) {
	var input CreatePostInput

	// リクエストのJSONデータをPostInput構造体にバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// コンテキストからユーザIDを抽出する
	creatorID := c.GetUint("userID")
	// log.Println("creatorID before insert:", creatorID)

	// 親ポストをデータベースから取得する
	var parentID *uint = nil
	if !input.IsQuestion {
		if input.ParentID == 0 {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "parent_id is required when is_question is false",
			})
			return
		}

		parentID = &input.ParentID

		var parent models.Post
		if err := models.DB.First(&parent, *parentID).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "parent post not found"})
			return
		}
	}

	// TODO:プラクティスが存在するかチェックする

	// ポストオブジェクトを作成し，データベースに保存する
	post := &models.Post{
		PracticeID:   &input.PracticeID,
		IsQuestion:   input.IsQuestion,
		ParentID:     parentID,
		CreatorID:    creatorID,
		ContentsText: input.ContentsText,
		ImagePath:    input.ImagePath,
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

type PostResponse struct {
	ID           uint               `json:"id"`
	PracticeID   *uint              `json:"practice_id"`
	IsQuestion   bool               `json:"is_question"`
	ParentID     *uint              `json:"parent_id"`
	ContentsText string             `json:"contents_text"`
	CreatedAt    time.Time          `json:"created_at"`
	Creator      *models.PublicUser `json:"creator"`
	ImagePath    string             `json:"image_path"`
}

func GetPostsTemplate(posts []models.Post) []PostResponse {
	resp := make([]PostResponse, 0, len(posts))
	for _, p := range posts {
		var creator *models.PublicUser
		if p.CreatorID != 0 {
			creator = p.Creator.ToPublic()
		}

		resp = append(resp, PostResponse{
			ID:           p.ID,
			PracticeID:   p.PracticeID,
			IsQuestion:   p.IsQuestion,
			ParentID:     p.ParentID,
			ContentsText: p.ContentsText,
			CreatedAt:    p.CreatedAt,
			Creator:      creator,
			ImagePath:    p.ImagePath,
		})
	}

	return resp
}

func GetPosts(c *gin.Context) {
	var posts []models.Post
	if err := models.DB.Where("parent_id IS NULL").Order("created_at desc").Preload("Creator").Find(&posts).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		return
	}

	resp := GetPostsTemplate(posts)

	c.JSON(http.StatusOK, gin.H{
		"posts": resp,
	})
}

type GetReplyInput struct {
	ParentID uint `json:"parent_id" binding:"required"`
}

// TODO:ParentIDをパスパラメータかクエリパラメータで受け取るようにしたい
func GetReply(c *gin.Context) {
	var input GetReplyInput

	// インプットのJSONをバインド
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	// データベースから返信を検索
	var replies []models.Post
	if err := models.DB.Where(&models.Post{ParentID: &input.ParentID}).Preload("Creator").Find(&replies).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	resp := GetPostsTemplate(replies)

	c.JSON(http.StatusOK, gin.H{
		"replies": resp,
	})
}
