package models

import "gorm.io/gorm"

type Flag struct {
	gorm.Model
	AccountID uint `gorm:"not null;index:idx_flag_user_post,unique;" json:"account_id"`
	Account   User `gorm:"not null;constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`
	PostID    uint `gorm:"not null;index:idx_flag_user_post,unique;" json:"post_id"`
	Post      Post `gorm:"not null;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
}

func (f *Flag) Save() (*Flag, error) {
	err := DB.Create(f).Error
	if err != nil {
		return nil, err
	}
	return f, nil
}
