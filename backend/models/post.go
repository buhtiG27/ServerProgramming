package models

import "gorm.io/gorm"

type Post struct {
	gorm.Model
	PracticeID   *uint     `json:"practice_id"`
	Practice     *Practice `gorm:"foreignKey:PracticeID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	IsQuestion   bool      `gorm:"not null;" json:"is_question"`
	ParentID     *uint     `json:"parent_id"`
	Parent       *Post     `gorm:"foreignKey:ParentID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL"`
	CreatorID    uint      `gorm:"not null;" json:"creator_id"`
	Creator      User      `gorm:"not null;foreignKey:CreatorID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
	ContentsText string    `json:"contents_text"`
	ImagePath    string    `json:"image_path"`
}

func (p *Post) Save() (*Post, error) {
	err := DB.Create(p).Error
	if err != nil {
		return nil, err
	}
	return p, nil
}
