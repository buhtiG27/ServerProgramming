package models

import (
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDataBase() {
	err := godotenv.Load()
	if err != nil {
		log.Println("No .env file found; using environment variables")
	}

	dbUser := os.Getenv("POSTGRES_USER")
	dbPass := os.Getenv("POSTGRES_PASSWORD")
	dbName := os.Getenv("POSTGRES_DB")
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")

	dsn := os.Getenv("TEST_DB_DSN")
	if dsn == "" {
		dsn = fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable", dbHost, dbUser, dbPass, dbName, dbPort)
	}

	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Println("Could not connect to the database. Application will start, but /api/ready will return 503.", err)
		return
	}

	if err := DB.AutoMigrate(
		&Belonging{},
		&Subject{},
		&User{},
		&Post{},
		&Practice{},
		&Timetable{},
	); err != nil {
		log.Printf("failed to migrate: %v", err)
	}
	fmt.Println("migrated")
}
