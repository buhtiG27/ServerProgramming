package models

import (
	"time"

	"gorm.io/gorm"
)

type Practice struct {
	gorm.Model
	SubjectID    *uint     `json:"subject_id"`
	Subject      *Subject  `gorm:"foreignKey:SubjectID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	PracticeName string    `gorm:"not null;" json:"practice_name"`
	Place        string    `json:"place"`
	Description  string    `json:"description"`
	Deadline     time.Time `json:"deadline"`
}

func (p *Practice) Save() (*Practice, error) {
	err := DB.Create(p).Error
	if err != nil {
		return nil, err
	}

	return p, err
}
