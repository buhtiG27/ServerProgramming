package main

import (
	"github.com/buhtiG27/ServerProgramming/backend/controllers"
	"github.com/buhtiG27/ServerProgramming/backend/middlewares"
	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

func main() {
	models.ConnectDataBase()

	router := gin.Default()

	api := router.Group("/api")

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
