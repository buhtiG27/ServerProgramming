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
	AccountID        string     `gorm:"not null;uniqueIndex" json:"account_id"`
	Password         string     `gorm:"not null;" json:"password"`
	Email            string     `gorm:"not null;" json:"email"`
	DisplayName      string     `gorm:"not null;" json:"display_name"`
	Description      *string    `json:"description"`
	YearOfEnrollment *int       `json:"year_of_enrollment"`
	Grade            *int       `json:"grade"`
	BelongingID      *uint      `json:"belonging_id"`
	Belonging        *Belonging `gorm:"foreignKey:BelongingID;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"belonging"`
	IconPath         *string    `json:"icon_path"`
	HeaderPath       *string    `json:"header_path"`
	Restriction      bool
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
func Authenticate(userID string, password string) (*User, error) {
	var user User

	// ユーザ名を検索する
	err := DB.Where("account_id = ?", userID).First(&user).Error
	if err != nil {
		return nil, err
	}

	// パスワードをハッシュ化して検証する
	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))
	if err != nil {
		return nil, err
	}

	return &user, nil
}

func GenerateTokenFromUser(user *User) (string, error) {
	// トークンを生成する
	token, err := token.GenerateToken(user.ID)
	if err != nil {
		return "", err
	}

	return token, nil
}

type PublicUser struct {
	ID          uint   `json:"id"`
	UserID      string `json:"user_id"`
	DisplayName string `json:"display_name"`
	Description string `json:"description"`
	IconPath    string `json:"icon_path"`
	HeaderPath  string `json:"header_path"`
}

func (u *User) ToPublic() *PublicUser {
	return &PublicUser{
		ID:          u.ID,
		UserID:      u.AccountID,
		DisplayName: u.DisplayName,
		Description: *u.Description,
		IconPath:    *u.IconPath,
		HeaderPath:  *u.HeaderPath,
	}
}
