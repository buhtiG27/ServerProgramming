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

		// 投稿の返信一覧の取得
		protected.GET("/posts/:id/replies", controllers.GetReply)

		// 科目の登録
		protected.POST("/subjects", controllers.SetSubject)

		// 科目情報の取得
		protected.GET("/subjects", controllers.GetSubjects)

		// 課題の登録
		protected.POST("/set_practice", controllers.SetPractice)

		// 科目に紐づいた課題一覧の取得
		protected.GET("/subjects/:id/practices", controllers.GetPractices)

		// 特定の課題の取得
		protected.GET("/practices/:id", controllers.GetPractice)

		// 時間割の登録
		protected.POST("/timetables", controllers.SetTimetable)

		// 時間割の取得
		protected.GET("/timetables", controllers.GetTimetable)

	}
	// 新着投稿の取得
	api.GET("/posts", controllers.GetPosts)

	router.Run(":8080")
}
