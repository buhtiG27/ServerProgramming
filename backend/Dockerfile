FROM public.ecr.aws/docker/library/golang:1.25-alpine AS build
WORKDIR /app

RUN apk add --no-cache git ca-certificates tzdata
# （必要なら）
RUN update-ca-certificates

COPY go.mod go.sum ./
# RUN go env && cat /etc/resolv.conf && go mod download -x
RUN go mod download

COPY . .
RUN go build -o server .

FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/server /app/server
EXPOSE 8080
CMD ["/app/server"]
