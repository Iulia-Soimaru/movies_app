require 'json'

get '/' do
  erb :main
end

delete '/logout' do
  session.destroy
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
  @user = User.new(full_name: params[:full_name], email: params[:email], password: params[:password])
  if @user.save
    status 200
    session[:user_id] = @user.id
    redirect "profile/#{@user.id}"
  else
    status 404
    "Sorry mistake happened during sign up"
  end
end


put '/signin' do
  @sign_in_user = User.where(email: params[:email]).first
  if @sign_in_user && @sign_in_user.password == params[:password]
    session[:user_id] = @sign_in_user.id
    status 200
    redirect "/profile/#{@sign_in_user.id}"
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

      # t.string :full_name
      # t.string :email
      # t.string :password
      # t.date :birthday

