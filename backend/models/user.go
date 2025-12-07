package models

import (
	"github.com/buhtiG27/ServerProgramming/backend/utils/token"

	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

// TODO:実際のUsersテーブルに沿った実装をする
// Usersのテーブル定義
type User struct {
	gorm.Model
	Username string `gorm:"primaryKey;not null; unique" json:"username"`
	Password string `gorm:"not null;" json:"password"`
}

// Userオブジェクトをデータベースに保存する
func (u *User) Save() (*User, error) {
	err := DB.Create(u).Error
	if err != nil {
		return nil, err
	}
	return u, nil
}

// Userオブジェクトが保存される前に実行する
func (u *User) BeforeSave(*gorm.DB) error {
	// パスワードをハッシュ化する
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	u.Password = string(hashedPassword)

	return nil
}

// パスワードを空文字にして出力準備をする
func (u *User) PrepareOutput() *User {
	u.Password = ""
	return u
}

// ユーザ名とパスワードを照合してトークンを返す
func GenerateToken(username string, password string) (string, error) {
	var user User

	// ユーザ名を検索する
	err := DB.Where("username = ?", username).First(&user).Error
	if err != nil {
		return "", err
	}

	// パスワードをハッシュ化して検証する
	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))
	if err != nil {
		return "", err
	}

	// トークンを生成する
	token, err := token.GenerateToken(user.ID)
	if err != nil {
		return "", err
	}

	return token, nil
}
