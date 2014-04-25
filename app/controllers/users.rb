get '/users/login' do
  erb :'/users/account_login'
end

post '/users/login' do



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
end
