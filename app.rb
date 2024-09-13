# frozen_string_literal: true

require 'sinatra'
require 'pg'
require 'cgi'

helpers do
  def h(text)
    CGI.escapeHTML(text.to_s)
  end
end

def conn
  @conn ||= PG.connect(dbname: 'memo_app_db')
end

configure do
  result = conn.exec("SELECT * FROM information_schema.tables WHERE table_name = 'memos'")
  conn.exec('CREATE TABLE memos (id serial, title varchar(255), content text)') if result.values.empty?
end

def read_memos
  conn.exec('SELECT * FROM memos')
end

def read_memo(id)
  result = conn.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result.first
end

def post_memo(title, content)
  conn.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [title, content])
end

def edit_memo(title, content, id)
  conn.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])
end

def delete_memo(id)
  conn.exec_params('DELETE FROM memos WHERE id = $1;', [id])
end

get '/memos' do
  @memos = read_memos
  @title = 'メモ一覧'
  erb :index
end

get '/memos/new' do
  @title = 'メモ作成'
  erb :new
end

post '/memos' do
  title = params[:title]
  content = params[:content]
  post_memo(title, content)
  redirect '/memos'
end

get '/memos/:id' do
  @memo = read_memo(params[:id])
  @title = @memo['title']
  @content = @memo['content']
  erb :show
end

get '/memos/:id/edit' do
  @memo = read_memo(params[:id])
  halt(404, 'メモが見つかりません') unless @memo
  @title = @memo['title']
  @content = @memo['content']
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]
  edit_memo(title, content, params[:id])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete_memo(params[:id])
  redirect '/memos'
end
