package controllers

import (
	"net/http"
	"strconv"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

type FlagInput struct {
	PostID uint `json:"post_id" binding:"required"`
}

func RegisterFlag(c *gin.Context) {
	var input FlagInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	accountID := c.GetUint("userID")

	flag := &models.Flag{
		AccountID: accountID,
		PostID:    input.PostID,
	}
	flag, err := flag.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"flag_info": flag,
		"post_id":   input.PostID,
	})
}

func GetFlags(c *gin.Context) {
	accountID := c.GetUint("userID")

	var flags []models.Flag
	if err := models.DB.Where(&models.Flag{AccountID: accountID}).Preload("Post").Order("created_at DESC").Find(&flags).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"flags": flags,
	})
}

func UnregisterFlag(c *gin.Context) {
	flagID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	var deletingFlag models.Flag
	if err := models.DB.First(&deletingFlag, flagID).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := models.DB.Unscoped().Delete(&deletingFlag).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"flag delete": "ok",
	})
}
