package models

import "gorm.io/gorm"

type Timetable struct {
	gorm.Model
	UserID    uint    `gorm:"not null;index:idx_user_subject,unique;" json:"user_id"`
	User      User    `gorm:"not null;foreignKey:UserID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
	SubjectID uint    `gorm:"not null;index:idx_user_subject,unique;" json:"subject_id"`
	Subject   Subject `gorm:"not null;foreignKey:SubjectID;constraint:OnUpdate:CASCADE,OnDelete:RESTROCT;"`
}

func (t *Timetable) Save() (*Timetable, error) {
	err := DB.Create(t).Error
	if err != nil {
		return nil, err
	}
	return t, nil
}
