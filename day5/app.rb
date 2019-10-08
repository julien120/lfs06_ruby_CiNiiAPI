require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'
require 'sinatra/activerecord'
require './models'


enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end
get '/' do
 erb :index
end

# #ログイン機能
post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/search'
end

# #新規登録機能
get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.create(
    name:params[:name],
    password:params[:password]
  )
  # if params[:file]
  #    image_upload(params[:file])
  # end
#   if @user.persisted?
#     session[:user] = @user.id
#   end
  redirect '/'
end

get '/signout'  do
   session[:user] = nil
   redirect '/'
 end

 #結果を表示
 get '/search' do
  #@categories = Category.all
keyword = params[:keyword]
 uri = URI("https://ci.nii.ac.jp/opensearch/search")
 uri.query = URI.encode_www_form({
   q: keyword,
   format: "json",
   appid: "kXisFQFdrehKUVwvMd3x"
  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  #Jsonの第１階層を取得すること
    @articles = json["items"]
  erb :search
 end
 #
#a
# #検索機能/一旦消す
 post '/search' do
@categories = Category.all
 keyword = params[:keyword]
 uri = URI("https://ci.nii.ac.jp/opensearch/search")
 uri.query = URI.encode_www_form({
   q: keyword,
   format: "json",
   count: 50,
   appid: "kXisFQFdrehKUVwvMd3x"
  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  #Jsonの第１階層を取得すること
    @articles = json["@graph"]
erb :search
 end


post '/new' do
  #@categories = Category.all
  @posts = Post.create(
    title: params[:title],
    #comment: params[:comment],
    category_id: params[:category]
    #user_id: current_user.id
  )
  erb :booking
 end

 get '/booking' do
  @posts = Post.order('id desc').all

 erb :booking
 end

 post '/booking' do
   @posts = Post.order('id desc').all
 end