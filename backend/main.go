package main

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/controllers"
	"github.com/buhtiG27/ServerProgramming/backend/middlewares"
	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

func main() {
	models.ConnectDataBase()

	router := gin.Default()

	api := router.Group("/api")

	// サーバの生存確認用
	api.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"ok": true,
		})
	})
	// データベースの生存確認用
	api.GET("/ready", func(c *gin.Context) {
		if models.DB == nil {
			c.AbortWithStatusJSON(http.StatusServiceUnavailable, gin.H{
				"error": "db not initialized",
			})
			return
		}
		if err := models.DB.Exec("SELECT 1").Error; err != nil {
			c.AbortWithStatusJSON(http.StatusServiceUnavailable, gin.H{
				"error": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, gin.H{
			"ok": true,
		})
	})

	api.POST("/register", controllers.Register)
	api.POST("/login", controllers.Login)

	protected := api.Group("/")
	// JWT認証ミドルウェアを適用
	protected.Use(middlewares.JwtAuthMiddleware())
	{
		// 認証されたユーザ情報を取得するルートを定義
		protected.GET("/user", controllers.CurrentUser)

		// 投稿
		protected.POST("/post", controllers.Post)
	}
	api.GET("/get_posts", controllers.GetPosts)

	router.Run(":8080")
}
