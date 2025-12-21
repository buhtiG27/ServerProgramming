package main

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/buhtiG27/ServerProgramming/backend/internal/testutil"
)

func TestPostCreate(t *testing.T) {
	db := testutil.ConnectTestDB(t)
	testutil.TruncateAll(t, db)

	r := SetupRouter()

	// 1) register
	regBody := map[string]any{
		"account_id":   "test001",
		"password":     "password123", // min=8
		"email":        "test001@ms.dendai.ac.jp",
		"display_name": "test",
		// belonging必須っぽいならここも入れる（入れないで落ちたら追加でOK）
		"department_code": "X",
		"classification":  1,
	}
	regJSON, _ := json.Marshal(regBody)
	w := httptest.NewRecorder()
	req := httptest.NewRequest("POST", "/api/register", bytes.NewReader(regJSON))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	if w.Code != http.StatusOK {
		t.Fatalf("register: expected 200 got %d body=%s", w.Code, w.Body.String())
	}

	// 2) login -> token
	loginBody := map[string]any{
		"account_id": "test001",
		"password":   "password123",
	}
	loginJSON, _ := json.Marshal(loginBody)
	w = httptest.NewRecorder()
	req = httptest.NewRequest("POST", "/api/login", bytes.NewReader(loginJSON))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	if w.Code != http.StatusOK {
		t.Fatalf("login: expected 200 got %d body=%s", w.Code, w.Body.String())
	}

	var loginResp struct {
		Token string `json:"token"`
	}
	if err := json.Unmarshal(w.Body.Bytes(), &loginResp); err != nil {
		t.Fatalf("login json: %v body=%s", err, w.Body.String())
	}
	if loginResp.Token == "" {
		t.Fatalf("login: token empty body=%s", w.Body.String())
	}

	// 3) create post (questionにしとくと parent_id 地雷を避けやすい)
	postBody := map[string]any{
		"is_question":   true,
		"contents_text": "hello from test",
	}
	postJSON, _ := json.Marshal(postBody)
	w = httptest.NewRecorder()
	req = httptest.NewRequest("POST", "/api/posts", bytes.NewReader(postJSON))
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+loginResp.Token)
	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fatalf("post create: expected 200 got %d body=%s", w.Code, w.Body.String())
	}
}
