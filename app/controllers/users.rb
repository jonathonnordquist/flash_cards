enable :sessions

before '/users/secure/*' do
  p "Redirecting back"
  if !session[:user_id]
    redirect '/'
  end
end

get '/users/login' do
  erb :'/users/account_login'
end

post '/users/login' do
  user = User.find_by_username(params[:username])
  p user
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/users/secure/#{user.id}/profile"
  else
    redirect '/'
  end
end

post '/users/create_account' do
  user = User.new(username: params[:username],
           email: params[:email],
           password: params[:password],
           password_confirmation: params[:password_confirmation])
  user.save

  redirect to :'/users/login'
end

get '/users/create_account' do
  erb :'/users/create_account'
end

# before '/users/secure/*' do
#   p "Redirecting back"
#   if !session[:user_id]
#     redirect '/'
#   end
# end

get '/users/secure/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/secure/:id/profile' do

  @user = User.find(session[:user_id])
  erb :'/users/profile'
end

