package models

import "gorm.io/gorm"

type Belonging struct {
	gorm.Model
	DepartmentCode *string `json:"department_code"`
	Classification *uint   `json:"classification"`
}

func (b *Belonging) Save() (*Belonging, error) {
	err := DB.Create(b).Error
	if err != nil {
		return nil, err
	}
	return b, nil
}
