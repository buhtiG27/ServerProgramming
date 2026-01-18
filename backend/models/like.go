package models

import "gorm.io/gorm"

type Like struct {
	gorm.Model
	AccountID uint `gorm:"not null;index:idx_like_account_post,unique;" json:"account_id"`
	Account   User `gorm:"not null;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	PostID    uint `gorm:"not null;index:idx_like_account_post,unique" json:"post_id"`
	Post      Post `gorm:"not null;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
}

func (l *Like) Save() (*Like, error) {
	err := DB.Create(l).Error
	if err != nil {
		return nil, err
	}
	return l, nil
}
