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
  @user = User.find(session[:user_id])
  # @another_user = User.find(params[:user_id])
  erb :profile
end

get '/profile/:user_id/movie_list' do
  @user = User.find(session[:user_id])
  erb :movie_list
end

post '/:movie_id/rating' do
  p params
  p "hi" * 100
  @user = User.find(session[:user_id])
  p @user
  if @user.movies.where(id: params[:movie_id]).first.ratings.first != nil
    status 200
    @rating = Rating.create(user_id: @user.id, movie_id: params[:movie_id], rate_value:  params[:rate_value])
    p @rating
    content_type :json
  else
    status 404
    p "This movie has been already rated"
  end
  p "*" * 100
  p @rating
  {rate_value: @rating.rate_value}.to_json
end



 # @user = User.find(session[:user_id])
  # # @movie = Movie.where(id: params[:movie_id]).first.ratings.first
  # p "*" * 100
  # p @user
  # p "*" * 100
  # p params
  # # @rating = @user.movies.where(id: params[:movie_id]).first.ratings.first
  # movie = Movie.find(params[:movie_id])
  # p movie

  # p "*" * 100
  # p movie.ratings.count
  # p movie.ratings.create(my_rate: params[:my_rate])
  # p movie.ratings.count
  # p "*" * 100
  # p @rating
  # # p "#" * 100
  # # p @movie
  # content_type :json
  # # {my_rating: movie.my_rate}.to_json



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
  p "#" * 100
  if Movie.where(title: @movie["Title"]).first
    @movie = Movie.where(title: @movie["Title"]).first
    p "Movie already exists"
  else
    @user.movies << Movie.create(title: @movie["Title"], year: @movie["Year"], runtime: @movie["Runtime"], genre: @movie["Genre"], director: @movie["Director"], writer: @movie["Writer"], actors: @movie["Actors"], plot: @movie["Plot"], language: @movie["Language"], country: @movie["Country"], awards: @movie["Awards"], imdbRating: @movie["imdbRating"], poster: @movie["Poster"])
  end

   # t.string :title
   #    t.integer :year
   #    t.string :runtime
   #    t.string :genre
   #    t.string :director
   #    t.string :writer
   #    t.string :actors
   #    t.string :actors
   #    t.string :plot
   #    t.string :language
   #    t.string :country
   #    t.string :awards
   #    t.string :poster
   #    t.string :imdbRating
  # data_json = J@movie)
  # p data_json
end

get '/search' do
  @user = User.where(full_name: params[:name]).first
  if !@user
    status 404
    "Not found this user, try again"
  else
    redirect "/profile/#{@user.id}"
  end
end

post '/profile/:user_id/add' do
  @current_user = User.find(session[:user_id])
  @user = User.find(params[:user_id])
  @current_user.preys << @user
  content_type :json
  {person_name: @user.full_name }.to_json
  # redirect "/profile/#{@user.id}"
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

