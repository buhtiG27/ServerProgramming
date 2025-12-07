package controllers

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/buhtiG27/ServerProgramming/backend/utils/token"
	"github.com/gin-gonic/gin"
)

type RegisterInput struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

func Register(c *gin.Context) {
	var input RegisterInput

	// リクエストのJSONデータをRegisterInput構造体にバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// ユーザオブジェクトを作成し，データベースに保存する
	user := &models.User{Username: input.Username, Password: input.Password}
	user, err := user.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// 成功した場合，ユーザ情報をレスポンスとして返す
	c.JSON(http.StatusOK, gin.H{
		"data": user.PrepareOutput(),
	})
}

type LoginInput struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

// ログイン情報から認証トークンを生成して返す
func Login(c *gin.Context) {
	var input LoginInput

	// リクエストのJSONデータをLoginInput構造体にバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// ユーザオブジェクトからトークンを生成する
	token, err := models.GenerateToken(input.Username, input.Password)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// 成功した場合，トークンをレスポンスとして返す
	c.JSON(http.StatusOK, gin.H{
		"token": token,
	})
}

// トークンからユーザ情報を返す
func CurrentUser(c *gin.Context) {
	// トークンからユーザIDを抽出する
	userId, err := token.ExtractTokenId(c)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	var user models.User
	// ユーザIDに基づいてユーザ情報をデータベースから取得する
	err = models.DB.First(&user, userId).Error
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"data": user.PrepareOutput(),
	})
}
