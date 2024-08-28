# frozen_string_literal: true

require 'sinatra'
require 'json'

DATA_FILE = 'memos.json'

def load_memos
  File.exist?(DATA_FILE)
  JSON.parse(File.read(DATA_FILE))
end

def save_memos(memos)
  File.write(DATA_FILE, JSON.generate(memos))
end

get '/memos' do
  @memos = load_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memos = load_memos
  new_memo = {
    'id' => (memos.empty? ? 1 : memos.last['id'] + 1),
    'title' => params[:title],
    'content' => params[:content]
  }
  memos << new_memo
  save_memos(memos)
  redirect '/memos'
end

get '/memos/:id' do
  @memo = load_memos.find { |memo| memo['id'] == params[:id].to_i }
  erb :show
end

get '/memos/:id/edit' do
  @memo = load_memos.find { |memo| memo['id'] == params[:id].to_i }
  halt(404, 'メモが見つかりません') unless @memo
  erb :edit
end

patch '/memos/:id' do
  memos = load_memos
  find_memo = memos.find { |memo| memo['id'] == params[:id].to_i }
  find_memo['title'] = params[:title]
  find_memo['content'] = params[:content]
  save_memos(memos)
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id/delete' do
  memos = load_memos
  memos.reject! { |memo| memo['id'] == params[:id].to_i }
  save_memos(memos)
  redirect '/memos'
end
