$env:TEST_DB_DSN="host=localhost user=qadmin password=dorwssapnimdaq dbname=serverprogramming_test port=5433 sslmode=disable TimeZone=Asia/Tokyo"
go test ./... -count=1