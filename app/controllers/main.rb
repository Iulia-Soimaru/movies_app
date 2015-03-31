require 'json'
require 'omdb'

get '/' do
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
  erb :movie_list
end

put '/profile/:user_id' do
  @user = User.find(session[:user_id])
  @title = params[:title]
  searched_movie = Omdb::Api.new.search(@title)
  @user.movies << Movie.create(searched_movie)




  # p movie

  # # OR

  # # content_type :json
  # # content = open("http://www.omdbapi.com/?t=" + title + "&y=&plot=long");
  # # data = JSON.parse(content)
  # # if data

  # movie = Movie.where(???).first
  # movie ||= Movie.new(... movie ...)


  redirect '/profile/:user_id/movie_list'
end


      # t.string :full_name
      # t.string :email
      # t.string :password
      # t.date :birthday

