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

### 2.必要なGemをインストールする
以下をGemfileに追加する
```ruby
# frozen_string_literal: true

source 'https://rubygems.org'

gem 'sinatra'
gem 'json'
gem 'puma'
gem 'rubocop'
gem 'erb_lint', require: false

gem "rubocop-rails"
gem "rubocop-performance"
```

追加後、以下を実行する
```zsh
# Bundlerがインストールされていることを確認の上、実行
bundle install
```

### 3.アプリケーションを起動する
```zsh
ruby app.rb
```

### 4.アプリケーションにアクセスする
```zsh
# ブラウザを開き、以下URLにアクセスする
http://localhost:4567/memos
```
### 5.アプリケーションを終了する
ターミナルで`CTRL + C'を教えて終了
