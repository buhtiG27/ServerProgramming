# バックエンドAPIの仕様とservletの方針

## 概要

* Base URL: `/api`
* Content-Type: `application/json`
* 認証方式: JWT（Authorizationヘッダで送る想定）
* 認証必須API: `/api` 配下で protected group に入っているもの

### Authorization ヘッダ

```
Authorization: Bearer <JWT>
```

（middlewareは `token.TokenValid(c)` / `ExtractTokenId(c)` を使っているので、そこで読める形式にServlet側を合わせる）

---

## 2.1 認証なし

### POST `/api/register`

ユーザ登録

Request(JSON)

```json
{
  "account_id": "s1234567",
  "password": "password123",
  "email": "xxx@ms.dendai.ac.jp",
  "display_name": "Haru",
  "description": "hi",
  "year_of_enrollment": 2023,
  "grade": 2,
  "department_code": "CS",
  "classification": 1,
  "icon_path": "",
  "header_path": ""
}
```

* emailは許可ドメイン（例：`@ms.dendai.ac.jp`）のみ

Response(200)

```json
{ "data": { "id": 1, "account_id": "...", "...": "..." } }
```

（passwordは除外される）

Errors

* 400: バリデーション不正 / ドメイン不許可 / DB登録失敗

---

### POST `/api/login`

ログイン（JWT発行）

Request(JSON)

```json
{ "account_id": "s1234567", "password": "password123" }
```

Response(200)

```json
{
  "token": "<JWT>",
  "user": { "id": 1, "account_id": "...", "...": "..." }
}
```

Errors

* 401: 認証失敗

---

### GET `/api/posts`

新着投稿（質問のみ）一覧＋ページング

Query

* `limit` (int, required)
* `offset` (int, required)

Example
`GET /api/posts?limit=20&offset=0`

Response(200)

```json
{
  "posts": [
    {
      "id": 10,
      "practice_id": 3,
      "is_question": true,
      "parent_id": null,
      "contents_text": "text",
      "created_at": "2025-12-14T...",
      "image_path": "",
      "creator": {
        "id": 1,
        "account_id": "s123",
        "display_name": "Haru",
        "description": "...",
        "icon_path": "",
        "header_path": ""
      }
    }
  ]
}
```

（creatorはPublicUserのみが返る）

---

## 2.2 認証あり（JWT必須）

### GET `/api/user`

ログインユーザ情報

Headers: Authorization required

Response(200)

```json
{ "data": { "id": 1, "account_id": "...", "...": "..." } }
```

---

### POST `/api/post`

投稿作成

Request(JSON)

```json
{
  "practice_id": 3,
  "is_question": true,
  "parent_id": 0,
  "contents_text": "hello",
  "image_path": ""
}
```

* `is_question=false` のときは `parent_id` 必須（返信投稿）
* creatorはJWTのユーザ（bodyで渡さない）

Response(200)

```json
{ "data": { "...": "..." } }
```

---

### GET `/api/posts/:id/replies`

返信一覧（ページング）

Query

* `limit` (int, required)
* `offset` (int, required)

Example
`GET /api/posts/10/replies?limit=20&offset=0`

Response(200)

```json
{ "replies": [ /* PostResponse[] */ ] }
```

（creatorはPublicUser）

---

### POST `/api/subjects`

科目登録

Request(JSON)

```json
{
  "subject_name": "DB",
  "description": "",
  "class_room": "A101",
  "teacher": "X",
  "koma": 1,
  "units": 2,
  "period": "2025",
  "weekday": "Mon",
  "time": "1"
}
```

Response(200)

```json
{ "subject_data": { ... } }
```

---

### GET `/api/subjects`

科目検索（クエリ必須）

Query

* `weekday` (required)
* `time` (required)

Example
`GET /api/subjects?weekday=Mon&time=1`

Response(200)

```json
{ "subjects": [ ... ] }
```

---

### POST `/api/set_practice`

課題登録

Request(JSON)

```json
{
  "subject_id": 10,
  "practice_name": "課題1",
  "place": "WebClass",
  "description": "",
  "deadline": "2025-12-20T00:00:00Z"
}
```

Response(200)

```json
{ "practice": { ... } }
```

---

### GET `/api/subjects/:id/practices`

科目に紐づく課題一覧

Example
`GET /api/subjects/10/practices`

Response(200)

```json
{ "practices": [ ... ] }
```

---

### GET `/api/practices/:id`

課題詳細 + その課題の質問一覧（parent_id is null）

Example
`GET /api/practices/3`

Response(200)

```json
{
  "practice": { ... },
  "posts": [ /* PostResponse[] */ ]
}
```

---

### POST `/api/timetables`

時間割登録

Request(JSON)

```json
{ "subject_id": 10 }
```

Response(200)

```json
{ "data": { ... } }
```

---

### GET `/api/timetables`

時間割取得

Response(200)

```json
{ "timetables": [ ... ] }
```

---

## 3) Servlet側の実装方針（チーム共有向け）

### 3.1 役割分担（おすすめ）

* **Servlet/JSP（画面サーバ）**

  * セッション管理（ログイン状態）
  * 画面遷移（login.jsp → home.jsp 等）
  * バリデーション（ユーザ入力の最低限）
  * Go API を呼び出して結果を JSP に渡す

* **Go（APIサーバ）**

  * 認証（JWT）
  * DB操作（CRUD）
  * 権限判定（必要になったら）
  * JSONレスポンスの提供

### 3.2 ログイン状態の持ち方

おすすめは **ServletセッションにJWTを保存**。

* ログイン成功 → `session.setAttribute("jwt", token)`
* API呼び出し時 → `Authorization: Bearer <jwt>` を付与

> CookieにJWT直入れもできるけど、CSRFとかの話が出てくるから、まずはセッション保存がラクだぜ。

### 3.3 API呼び出しの共通化（めちゃ大事）

各Servletで `HttpURLConnection` 直書きすると地獄になるから、チームで共通クラス1個作るのが安定。

* `ApiClient`

  * `get(path, queryMap, sessionJwt)`
  * `post(path, jsonBody, sessionJwt)`
  * レスポンスコードとbody文字列を返す
  * 401なら「ログイン画面へリダイレクト」統一

### 3.4 画面別の呼び出しフロー例

#### ログイン画面（login.jsp → LoginServlet）

1. `/api/login` にPOST
2. tokenをsessionへ保存
3. `/api/user` 叩いてユーザ名取る（任意）
4. homeへリダイレクト

#### 科目検索画面

* `GET /api/subjects?weekday=...&time=...`
  結果をJSPで一覧表示

#### 課題詳細画面（Practice詳細 + 投稿一覧）

* `GET /api/practices/:id` 一発で practice + posts が返る
  → JSP側は posts をそのまま描画して「返信を見る」ボタンで `/posts/:id/replies` 呼ぶ

#### 投稿一覧の小出し（もっと見る）

* 初回：`GET /api/posts?limit=20&offset=0`
* 追加：`offset += 20` で再取得
  JSPならページ遷移型でもいいし、JSで非同期ロードでもOK（まずはページ遷移型が簡単）
