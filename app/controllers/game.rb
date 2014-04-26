enable 'sessions'

get '/game/select' do
  @all_decks = Deck.all
  @new_game = Round.create
  erb :select
end

get '/game/start/:id' do
  round = Round.new(user_id: session[:user_id])
  round.save
  new_deck = Card.find_all_by_deck_id(params[:id])
  @card_obj = new_deck
  # grab deck data where deck id = @card_obj.deck_id
  # and populate guess table
  new_deck.each do |card|
    Guess.create(round_id: round.id, card_id: card.id)
  end
  @current_round = round.id
  erb :start_page
end

post '/game/question' do

  guesses = []
  Guess.where(round_id: params[:round_id], correct: nil).each do |x|
    guesses << x
  end

  @new_card = Card.find_by_id(guesses.shuffle[0].card_id)

  erb :question
end

post '/results/:id' do
  @card_obj = Card.find(params[:id])
  # if answer == @card_obj.answer
  #   @result = true
  # else
  #   @result = false
  # end
  # Guess.create(correct?: @result)
  # redirect to '/game/question/:id'
  redirect to "/game/result/#{@card_obj.id}"
end

get '/game/result/:id' do
  @card_obj = Card.find(params[:id])
  erb :result
end

