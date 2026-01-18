package main

import (
	"net/http"

	"github.com/buhtiG27/ServerProgramming/backend/controllers"
	"github.com/buhtiG27/ServerProgramming/backend/middlewares"
	"github.com/buhtiG27/ServerProgramming/backend/models"
	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
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
		protected.POST("/posts", controllers.Post)

		// 投稿の返信一覧の取得
		protected.GET("/posts/:id/replies", controllers.GetReply)

		// 科目の登録
		protected.POST("/subjects", controllers.SetSubject)

		// 科目情報の取得
		protected.GET("/subjects", controllers.GetSubjects)

		// 課題の登録
		protected.POST("/practice/set", controllers.SetPractice)

		// 科目に紐づいた課題一覧の取得
		protected.GET("/subjects/:id/practices", controllers.GetPractices)

		// 特定の課題の取得
		protected.GET("/practices/:id", controllers.GetPractice)

		// 時間割の登録
		protected.POST("/timetables", controllers.SetTimetable)

		// 時間割の取得
		protected.GET("/timetables", controllers.GetTimetable)

		// 新着投稿の取得
		protected.GET("/posts", controllers.GetPosts)

		// ユーザの投稿一覧の取得
		protected.GET("/user/posts", controllers.GetUserPosts)

		// いいねをする
		protected.POST("/posts/like", controllers.DoLike)

		// いいね数と情報の取得
		protected.GET("/posts/:id/like", controllers.GetLikeCountAndInfo)

		// いいねの解除
		protected.DELETE("/posts/:id/like", controllers.DeleteLike)

		// フラグの登録
		protected.POST("/user/flags", controllers.RegisterFlag)

		// フラグの一覧取得
		protected.GET("/user/flags", controllers.GetFlags)

		// フラグされているか判定
		protected.GET("/posts/:id/flag", controllers.GetFlagInfo)

		// フラグの登録解除
		protected.DELETE("/user/flags/:id", controllers.UnregisterFlag)
	}
	return router
}
