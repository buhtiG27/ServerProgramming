package controllers

import (
	"net/http"
	"strconv"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type LikeInput struct {
	PostID uint `json:"post_id" binding:"required"`
}

func DoLike(c *gin.Context) {
	var input LikeInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	accountID := c.GetUint("userID")

	like := &models.Like{
		AccountID: accountID,
		PostID:    input.PostID,
	}
	like, err := like.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"likeInfo": like,
	})
}

func GetLikeCount(c *gin.Context) {

	postID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	var count int64
	if err := models.DB.Model(&models.Like{}).Where("post_id = ?", postID).Count(&count).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"like_count": count,
		"post_id":    postID,
	})
}
