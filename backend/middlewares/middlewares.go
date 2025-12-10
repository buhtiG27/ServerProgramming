package middlewares

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/buhtiG27/ServerProgramming/backend/utils/token"
	"github.com/gin-gonic/gin"
)

// JwtAuthMiddleware はJWT認証を行うミドルウェアを返す
func JwtAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		// トークンが有効化チェック
		err := token.TokenValid(c)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "invalid token"})
			c.Abort()
			return
		}

		// トークンからuserIdを取り出す
		userID, err := token.ExtractTokenId(c)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "could not extract user id"})
			c.Abort()
			return
		}

		// userIdからユーザ情報を取り出す
		var user models.User
		if err := models.DB.First(&user, userID).Error; err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "user not found"})
			c.Abort()
			return
		}

		c.Set("userID", userID)
		c.Set("currentUser", user.PrepareOutput())

		c.Next()
	}
}
