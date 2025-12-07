package middlewares

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/utils/token"
	"github.com/gin-gonic/gin"
)

// JwtAuthMiddleware はJWT認証を行うミドルウェアを返す
func JwtAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		err := token.TokenValid(c)

		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
			c.Abort()
			return
		}

		c.Next()
	}
}
