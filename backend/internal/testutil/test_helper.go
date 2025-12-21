package testutil

import (
	"os"
	"testing"

	"github.com/buhtiG27/ServerProgramming/backend/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func ConnectTestDB(t *testing.T) *gorm.DB {
	t.Helper()
	t.Setenv("API_SECRET", "test-secret") // 例
	t.Setenv("TOKEN_HOUR_LIFESPAN", "1")  // 例：60分（←ここがAtoi対象っぽい）

	dsn := os.Getenv("TEST_DB_DSN")
	if dsn == "" {
		t.Fatal("TEST_DB_DSN is empty")
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatal(err)
	}

	models.DB = db

	// ★ここ追加：テーブル生成
	if err := db.AutoMigrate(
		&models.Belonging{},
		&models.User{},
		&models.Post{},
		&models.Practice{},
		&models.Subject{},
		&models.Timetable{},
	); err != nil {
		t.Fatal(err)
	}

	return db
}

func TruncateAll(t *testing.T, db *gorm.DB) {
	t.Helper()
	// テーブル名はGORMデフォルト(plural)想定
	err := db.Exec(`
    TRUNCATE TABLE
      posts,
      practices,
      subjects,
      timetables,
      users,
      belongings
    RESTART IDENTITY CASCADE;
  `).Error
	if err != nil {
		t.Fatal(err)
	}
}
