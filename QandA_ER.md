# ER 図

```mermaid
    erDiagram
        USERS {
            string id PK
            string password_hash
            string email
            string display_name
            string description
            int delinging_id FK "BELONGING.id"
            int year_of_enrollment
            int grade
            string icon_path
            string header_path
            boolean restriction
            date created_at
            date updated_at
        }

        LIKES {
            int id PK
            string user_id PK,FK "USER.id"
            int post_id PK,FK "POSTS.id"
            date created_at
            date updated_at
        }

        FLAGS {
            int id PK
            int user_id PK,FK "USERS.id"
            int post_id PK,FK "POSTS.id"
            date created_at
            date updated_at
        }

        BELONGING {
            int id PK
            string department_code "教員は教員用の特別な記号"
            int classification "大学生=1、大学院生=2、教員=3のいずれかをとる"
        }

        SUBJECTS {
            int id PK
            string subject_name
            string description
            string class_room
            string teacher
            int koma
            int units
            string period
            string day
            string time
            date created_at
            date updated_at
        }

        PRACTICES {
            int id PK
            int subject_id FK "SUBJECTS.id"
            string practice_name
            string place
            string description
            date deadline
            date created_at
            date updated_at
        }


        POSTS {
            int id PK
            int practice_id FK "PRACTICES.id"
            int QorA "Q=1 A=2"
            int parent_id FK "QorA=2の時のみ POSTS.id"
            string creator FK "USERS.id"
            string contents_text
            string image_path
            date created_at
            date updated_at
        }

        TIMETABLE {
            int id PK
            string user_id PK,FK "USERS.id"
            int subject_id PK,FK "SUBJECTS.id"
            date created_at
            date updated_at
        }

        TA {
            int id PK
            string user_id PK,FK "USERS.id"
            int subject_id PK, FK "SUBJECTS.id"
            date created_at
            date updated_at
        }

        USERS ||--o{ TIMETABLE : has
        USERS ||--o{ FLAGS : has
        USERS ||--o{ LIKES : has
        POSTS ||--o{ FLAGS : has
        POSTS ||--o{ LIKES : has
        TIMETABLE ||--|| SUBJECTS : has
        SUBJECTS ||--o{ PRACTICES : has
        PRACTICES ||--o{ POSTS : has
        USERS ||--o{ POSTS : writes
        USERS ||--|| BELONGING : has
        USERS ||--o{ TA : has
        SUBJECTS ||--|| TA : has
        POSTS ||--|| POSTS : has
```

<!--
        QUESTIONS ||--o{ ANSWERS : has
        USERS ||--o{ QUESTIONS : writes
        USERS ||--o{ ANSWERS : writes

        QUESTIONS {
            int 質問ID PK
            int 課題ID FK
            date 投稿日時
            string 作成者 FK
            string 質問名
            string DESCRIPTION
            int いいね数
        }

        ANSWERS {
            int 回答ID PK
            int 質問ID FK
            date 投稿日時
            string 回答内容
            int いいね数
        }
-->
