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
		log.Fatalf("Error loading .env file")
	}

	dbUser := os.Getenv("USER_NAME")
	dbPass := os.Getenv("USER_PASS")
	dbName := os.Getenv("DB_NAME")
	dbHost := os.Getenv("HOSTNAME")
	dbPort := os.Getenv("DB_PORT")

	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=Asia/Tokyo", dbHost, dbUser, dbPass, dbName, dbPort)

	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Could not connect to the database", err)
	}

	if err := DB.AutoMigrate(&User{}); err != nil {
		log.Fatalf("failed to migrate: %v", err)
	}
	if err := DB.AutoMigrate(&Post{}); err != nil {
		log.Fatalf("failed to migrate: %v", err)
	}
	fmt.Println("migrated")
}
