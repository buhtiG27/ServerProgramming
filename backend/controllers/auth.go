package controllers

import (
	"net/http"
	"strings"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/buhtiG27/ServerProgramming/backend/utils/token"
	"github.com/gin-gonic/gin"
)

// TODO:他のユーザ登録情報をどうするか検討して，変更する
type RegisterInput struct {
	UserID           string `json:"user_id" binding:"required"`
	Password         string `json:"password" binding:"required,min=8"`
	Email            string `json:"email" binding:"required,email"`
	DisplayName      string `json:"display_name" binding:"required"`
	Description      string `json:"description"`
	YearOfEnrollment int    `json:"year_of_enrollment"`
	Grade            int    `json:"grade"`
	DepartmentCode   string `json:"department_code"`
	Classification   uint   `json:"classification"`
	IconPath         string `json:"icon_path"`
	HeaderPath       string `json:"header_path"`
}

func Register(c *gin.Context) {
	var input RegisterInput

	// リクエストのJSONデータをRegisterInput構造体にバインドする
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// 許可するドメイン
	allowed := []string{"@ms.dendai.ac.jp"}

	ok := false
	for _, d := range allowed {
		if strings.HasSuffix(input.Email, d) {
			ok = true
			break
		}
	}
	if !ok {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "email domain is not allowed",
		})
		return
	}

	// 所属オブジェクトを作成し，データベースに保存する
	belonging := &models.Belonging{
		DepartmentCode: &input.DepartmentCode,
		Classification: &input.Classification,
	}
	belonging, err := belonging.Save()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}
	belongingID := belonging.ID

	// ユーザオブジェクトを作成し，データベースに保存する
	user := &models.User{
		UserID:           input.UserID,
		Password:         input.Password,
		Email:            input.Email,
		DisplayName:      input.DisplayName,
		Description:      &input.Description,
		YearOfEnrollment: &input.YearOfEnrollment,
		Grade:            &input.Grade,
		BelongingID:      &belongingID,
		IconPath:         &input.IconPath,
		HeaderPath:       &input.HeaderPath,
		Restriction:      false,
	}
	user, err = user.Save()
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
	UserID   string `json:"user_id" binding:"required"`
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
	user, err := models.Authenticate(input.UserID, input.Password)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	jwt, err := models.GenerateTokenFromUser(user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// 成功した場合，トークンをレスポンスとして返す
	c.JSON(http.StatusOK, gin.H{
		"token": jwt,
		"user":  user.PrepareOutput(),
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
