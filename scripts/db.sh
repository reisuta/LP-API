#!/bin/sh

# TODO: こちらだと接続できないので一旦goの方で初期化する
# # データベースが起動するまで待つ
# retries=10
# count=0

# until mysql -u${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} -e "SELECT 1" > /dev/null 2>&1; do
#   count=$((count+1))
#   if [ $count -ge $retries ]; then
#     echo "Failed to connect to MySQL after ${retries} attempts."
#     exit 1
#   fi
#   echo "Waiting for MySQL... (${count}/${retries})"
#   sleep 3
# done

# # データベースを作成する
# echo "Creating database if it does not exist..."
# mysql -u${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

# 起動を少し待ってからmigrate
sleep 10
# マイグレーションを実行
echo "Running migrations..."
migrate -path /app/db/migrations -database "mysql://${DB_USER}:${DB_PASSWORD}@tcp(${DB_HOST}:${DB_PORT})/${DB_NAME}" up

