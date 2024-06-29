#!/bin/sh
docker compose up -d

docker compose exec app sh /app/scripts/db.sh

# seed作成
docker cp ./db/seed/seed.sql mysql:/tmp/seed.sql
# TODO: 自動で反映されるようにする
# docker compose exec -T db mysql < ./db/seed/seed.sql
# docker compose exec -T db sh -c 'mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /tmp/seed.sql'

echo '下記の手順を実行'
echo 'docker compose exec db /bin/bash'
echo 'mysql -u ユーザー名 -p < /tmp/seed.sql'
