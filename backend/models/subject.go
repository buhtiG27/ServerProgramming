package models

import "gorm.io/gorm"

type Subject struct {
	gorm.Model
	SubjectName string `gorm:"not null;" json:"subject_name"`
	Description string `json:"description"`
	ClassRoom   string `json:"class_room"`
	Teacher     string `json:"teacher"`
	Koma        int    `gorm:"not null;" json:"koma"`
	Units       int    `json:"units"`
	Period      string `json:"period"`
	Weekday     string `gorm:"not null;" json:"weekday"`
	Time        string `gorm:"not null;" json:"time"`
}

func (s *Subject) Save() (*Subject, error) {
	err := DB.Create(s).Error
	if err != nil {
		return nil, err
	}
	return s, nil
}
