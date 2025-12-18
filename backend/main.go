package main

import (
	"github.com/buhtiG27/ServerProgramming/backend/models"
)

func main() {
	models.ConnectDataBase()

	router := SetupRouter()

	router.Run(":8080")
}
