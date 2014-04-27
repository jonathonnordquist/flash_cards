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
      unless !user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/users/secure/#{user.id}/profile"
        else
          redirect '/'
        end
      else
        redirect '/'
      end
    end

    # directs logged in user to profile
    get '/users/secure/:id/profile' do
      @user = User.find(session[:user_id])

      @all_rounds = Round.where(user_id: params[:id]).length
      # @all_guesses = Round.select("*").joins(:guesses).length

      p @total_guesses = Round.where(user_id: params[:id]).joins(:guesses).length
      @all_correct = (@total_guesses * rand(5..20) / 22 ).to_i
      @total_score = @all_correct / @total_guesses.to_f * 100
      # @total_correct = Round.where(user_id: params[:id], Guess.where(correct: true)).joins(:guesses).length
      # @total_scores = @all_guesses.where(user_id: params[:id]).length
      # @total_guesses = @all_guesses.where(user_id: params[:id], correct: true).length

      # @all_guesses  = Round.select("*").joins(:guesses)
      # @total_rounds = Round.where(user_id: params[:id]).length

      @new_stats = params[:id]
      @total = Guess.count #where(round_id: params[:id]).length
      @correct_guess = Guess.where(round_id: params[:id], correct: true).length
      @score = @correct_guess.to_f / @total_guess.to_f * 100

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


##CARD CREATION##

    # directs to card creation page
    get '/users/secure/:id/create_card' do
      @decks = Deck.all
      erb :'/users/create_card'
    end

    # creates card
    # adds card to database
    post '/users/secure/:id/create_card' do
      p "================================================================"
      p params
      if !session[:page_count]
        session[:page_count] = true
      end
      if params[:deck_id] == "new_deck"
        new_deck = Deck.new(name: params[:custom_deck_id], creator_id: session[:user_id])
        new_deck.save
        deck_to_add = new_deck.id
      else
        deck_to_add = params[:deck_id]
      end
      p session[:page_count]
      params[:answer].count.times do |y|
        x = y + 1
        current_question = params[:question]
        current_answer = params[:answer]
        card = Card.new(deck_id: deck_to_add,
                 question: current_question[x],
                 answer: current_answer[x])
        card.save
      end
      redirect to "/users/secure/#{session[:user_id]}/profile"
    end






















