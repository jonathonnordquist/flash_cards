get '/' do
  if session[:user_id]
    redirect "/users/secure/session[:user_id]/profile"
  else
    erb :index
  end
end
