package models

import "gorm.io/gorm"

type Post struct {
	gorm.Model
	IsQuestion   bool  `gorm:"not null;" json:"is_question"`
	ParentID     *uint `json:"parent_id"`
	Parent       *Post `gorm:"foreignKey:ParentID"`
	CreatorID    uint
	Creator      User   `gorm:"not null;foreignKey:CreatorID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	ContentsText string `json:"contents_text"`
	ImagePath    string `json:"image_path"`
}

func (p *Post) Save() (*Post, error) {
	err := DB.Create(p).Error
	if err != nil {
		return nil, err
	}
	return p, nil
}
