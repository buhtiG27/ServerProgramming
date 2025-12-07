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

	public := router.Group("/api")

	public.POST("/register", controllers.Register)
	public.POST("/login", controllers.Login)

	protected := router.Group("/api/admin")
	// JWT認証ミドルウェアを適用
	protected.Use(middlewares.JwtAuthMiddleware())
	// 認証されたユーザ情報を取得するルートを定義
	protected.GET("/user", controllers.CurrentUser)

	router.Run(":8080")
}
