require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'
require 'sinatra/activerecord'
require './models'
#require 'lazy_high_charts'


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
   #検索結果の条件分岐が必要
   count: 20,
   appid: "kXisFQFdrehKUVwvMd3x"
  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
    @articles = json["@graph"][0]["items"]
#binding.pry
  erb :search
 end






post '/new' do
  @categories = Category.all
  #postにはいらない
  # @posts = current_user.posts.create
  @posts = Post.create(
    title: params[:title],
    comment: params[:comment],
    creator: params[:creator],
    publisher: params[:publisher],
    publicname: params[:publicname],
    volume: params[:volume],
    number: params[:number],
    startingpage: params[:startingpage],
    endingpage: params[:endingpage],
    date: params[:date],
    category_id: params[:category],
    user_id: current_user.id
  )
  #postを作成したとに下の記述で取得しないと/newから/bookingに変遷しない
  @posts = current_user.posts
  #@posts = Post.order('id desc').all
  erb :booking
 end

 get '/category/:id' do
  @categories = Category.all
  @category = Category.find(params[:id])
  @category_name = @category.name
  #@posts = current_user.posts.where()
  @posts = @category.posts
  #todo:全て取得ではなく、current_user内で@category.postsを取得するにはどうするか
  erb :booking
 end

 #current_user.posts.where(category_id == 1)みたいに取り出せない？

 # 本棚
 get '/booking' do
  @categories = Category.all
  @posts = current_user.posts
  #@posts = Post.order('id desc').all

  #binding.pry
  #current_user.postsにする
 erb :booking
 end

 #/newでエラー起きるから設けたが原理はわからない
 post '/booking' do
  @categories = Category.all
  @posts = current_user.posts
  erb :booking
 end





 get '/edit/:id' do
  @categories = Category.all
  @posts = Post.find(params[:id])
  #@posts.update({category_id: params[:category]})
 erb :edit
 end

post '/posts/:id' do
  post = Post.find(params[:id])
  post.category_id = params[:category]
  post.save
  redirect '/booking'
end


get '/posts/:id' do
   post = Post.find(params[:id])
   redirect '/booking'
end

get '/edit/:id/hensyu' do
  @categories = Category.all
  @post = Post.find(params[:id])
  erb :edit
end


 get '/database' do
   @tags = current_user.tags
  erb :database
 end

get '/createbookshelf' do
  erb :createbookshelf
 end

 post '/renew' do
    @tags = Tag.create(
    bookshelfname: params[:bookshelfname],
    user_id: current_user.id
  )
  @tags = current_user.tags

  erb :database
 end


#todo:booklistに登録した論文を表示
 get '/booklist/:id/add' do
    @tags = current_user.tags

  erb :booklist
 end



#todo:論文を表示し、本棚に論文を追加する行為(formでPOSTする)
get '/bookadd' do
@posts = current_user.posts
  erb :bookadd
end

post '/addbook' do
 erb :database
end