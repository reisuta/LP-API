## 初期構築　
```
docker compose build --no-cache && ./compose-build-up.sh 
```

## Lint
```
golangci-lint run --fix  
```

## フォーマット
プロジェクト配下のコードをフォーマットする
```
go fmt ./...
```
