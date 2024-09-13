# Sinatra Memo App

こちらはSinatraで作成したメモアプリケーションです。

## セットアップ手順
### 1.リポジトリをクローンする
```zsh
#クローンする
git clone https://github.com/Tsuji17914/memo-app.git #HTTPS 
git clone git@github.com:Tsuji17914/memo-app.git #SSH

#クローンしたディレクトリに移動
cd memo-app
```
### 2.Gemをインストールする
```zsh
# Bundlerがインストールされていることを確認の上、実行
bundle install
```

### 3.PostgreSQLデータベースをセットアップする
```zsh
# PostgreSQL に接続
psql -U postgres

# データベースの作成
psql -c "CREATE DATABASE memo_app_db;"

# テーブルの作成
psql -d memo_app_db -f db/schema.sql
```

### 4.アプリケーションを起動する
```zsh
ruby app.rb
```

### 5.アプリケーションにアクセスする
```zsh
# ブラウザを開き、以下URLにアクセスする
http://localhost:4567/memos
```

### 6.アプリケーションを終了する
ターミナルで`CTRL + C'を教えて終了
