enable :sessions

#security filter
before '/users/secure/*' do
  if !session[:user_id]
    redirect '/'
  end
end

##LOG OUT##

  # cancels session
  get '/users/secure/logout' do
    session[:user_id] = nil
    redirect '/'
  end

##LOGIN##

    # directs to login page
    get '/users/login' do
      erb :'/users/account_login'
    end

    # authenticates user login
    # sets session
    post '/users/login' do
      user = User.find_by_username(params[:username])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/secure/#{user.id}/profile"
      else
        redirect '/'
      end
    end

    # directs logged in user to profile
    get '/users/secure/:id/profile' do
      @user = User.find(session[:user_id])
      erb :'/users/profile'
    end

##ACCOUNT CREATION##

    # directs to account creation page
    get '/users/create_account' do
      erb :'/users/create_account'
    end

    # creates account
    # adds account to database
    # redirects to login
    post '/users/create_account' do
      user = User.new(username: params[:username],
               email: params[:email],
               password: params[:password],
               password_confirmation: params[:password_confirmation])
      user.save

      redirect to :'/users/login'
    end
