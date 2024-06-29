FROM golang:1.22.4-alpine

RUN apk add --no-cache git mysql-client bash

RUN go install -tags 'mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
RUN go install github.com/air-verse/air@latest

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .
COPY scripts/db.sh /app/scripts/db.sh
RUN chmod +x /app/scripts/db.sh

CMD ["air", "-c", ".air.toml"]
