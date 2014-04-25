enable :sessions

get '/users/login' do
  erb :'/users/account_login'
end

post '/users/login' do
  user = User.find_by_username(params[:username])
  p user
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/users/#{user.id}/profile"
  else
    redirect '/'
  end
end

get '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:id/profile' do
  @user = User.find(session[:user_id])
  erb :'/users/profile'
end


get '/users/create_account' do
  erb :'/users/create_account'
end

post '/users/create_account' do
  user = User.new(username: params[:username],
           email: params[:email],
           password: params[:password],
           password_confirmation: params[:password_confirmation])
  user.save

  redirect to :'/users/login'
end
