require 'json'
require 'omdb'
require 'httparty'

get '/' do
  # movie = open("http://www.omdbapi.com/?t=" + title + "&y=&plot=long")
  # data = JSON.parse
  # # title = params[:title]
  # p "*" * 70
  # p params
  # p "*" * 70
  # response = HTTParty.get("http://www.omdbapi.com/?t=" + title + "&y=&plot=long")
  # puts response.body
  erb :main
end


get '/logout' do
  logout!
  redirect '/'
end

# get '/search' do

#   # if Movie.all.include?('params[:title]')
#   #   movie =
#   # @title = params[:title].to_s
#   # @movie = get_data_from_db(@title)
#   # # @movie = Movie.find()
#   # content_type :json
#   # @movie = Movie.new(title: )
#   # # movie = ''
#   # omdb_movie = open("http://www.omdbapi.com/?t=" + params[:title] + "&y=&plot=long")
#   # p movie
# end

##############################################################


post '/signup' do
  user = User.new(full_name: params[:full_name], email: params[:email], password: params[:password])
  if user.save
    status 200
    login_as_user(user)
    redirect "profile/#{user.id}"
  else
    status 404
    "Sorry mistake happened during sign up"
  end
end


put '/signin' do
  user = User.where(email: params[:email]).first
  if user && user.password == params[:password]
    login_as_user(user)
    status 200
    redirect "/profile/#{user.id}"
  else
    status 404
    "Sorry error happened during sign in"
  end
end

##############################################################

get '/profile/:user_id' do
  @user = User.find(params[:user_id])
  erb :profile
end

get '/profile/:user_id/movie_list' do
  @user = User.find(session[:user_id])
  erb :movie_list
end

# post '/profile/:user_id' do
#   p "1" *100
#   @user = User.find(session[:user_id])
#   # @title = params[:title]
#   p params[:title]
#   # p @title
#   movie = @user.movies << Movie.create(title: params[:title])
#   p @user
#   p "hi" * 100
#   if movie.last.save #I think it made it work
#     p "saved" * 100
#     status 200
#     content_type :json
#     {title: movie.title}.to_json
#     # redirect "/profile/#{@user.id}/movie_list"
#   else
#     status 404
#     p "Erorr message"
#   end

post '/profile/:user_id' do
  @user = User.find(session[:user_id])
  @title = params[:title]
  content_type :json
  @movie = HTTParty.get("http://www.omdbapi.com/?t=#{URI.escape(@title)}")
  data_json = JSON(@movie)
  p data_json
end





# end
  # searched_movie = open("http://www.omdbapi.com/?t=" + @title + "&y=&plot=long")
  # # p searched_movie
  # data = JSON.parse(searched_movie)

  # #Omdb::Api.new.search(title: @title)
  # get_searched_movie = Omdb::Api.new.parse_movies("http://www.omdbapi.com/?t=" + title + "&y=&plot=long")
  # p "#" * 60
  # p get_searched_movie
  # p "#" * 60
  # @user.movies << Movie.create(get_searched_movie[:movies])

  # content_type :json
  # content = open("http://www.omdbapi.com/?t=" + title + "&y=&plot=long")
  # p "%" * 70
  # p content
  # p "%" * 70
  # data = JSON.parse(content)
  # p "$" * 70
  # p data
  # p "$" * 70







  # p movie

  # # OR


  # movie = Movie.where(???).first
  # movie ||= Movie.new(... movie ...)




      # t.string :full_name
      # t.string :email
      # t.string :password
      # t.date :birthday

