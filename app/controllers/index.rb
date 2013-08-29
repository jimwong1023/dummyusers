get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/' do
  if user = User.authenticate(params[:user])
    session[:user_id] = user.id # User.find_by_email(params[:email]).id 
    redirect "/secrete_page"
  else
    redirect '/'
  end
end

before '/secrete_page' do
  if session[:user_id].nil?
    redirect '/'
  end
end

get '/secrete_page' do
  # if session[:user_id].nil?
  #   redirect '/'
  # else
    @user = User.find(session[:user_id])
    erb :user_page
  # end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/create_user' do

  erb :create_user
end

post '/create_user' do
  user = User.new(params[:user])
  
  if user.save
    session[:user_id] = user.id
    redirect '/secrete_page'
  else
    @errors = user.errors.messages
    erb :create_user
  end
end