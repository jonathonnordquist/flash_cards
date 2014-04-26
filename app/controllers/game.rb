enable 'sessions'

post '/game/select' do
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
    p "running"
    p "have some params #{params}"
    p Guess.where(round_id: params[:round_id], correct: nil)
  Guess.where(round_id: params[:round_id], correct: nil).each do |x|
    guesses << x
  end
  if guesses.count > 0
    p "This is current guesses remaining #{guesses.count}"
    @current_round = params[:round_id]
    @new_card = Card.find_by_id(guesses.shuffle[0].card_id)
    erb :question
  else
    "go to endgame"
  end
end

post '/results/:id' do
  p "results pramas #{params}"
  @card_obj = Card.find(params[:id])
  @current_round = params[:round_id]
  if params[:current_answer] == @card_obj.answer
    @result = true
  else
    @result = false
  end
  current_guess = Guess.where(card_id: params[:id], round_id: params[:round_id])
  current_guess.first.update_attributes(correct: @result)
  erb :result
  # redirect to "/game/result/#{@card_obj.id}"
end

# get '/game/result/:id' do
#   @card_obj = Card.find(params[:id])
#   @current_guess = Guess.find(params[:id])
#   if @current_guess.correct == true
#     @reply = "Guess is correct!"
#   else
#     @reply = "Sorry, wrong answer."
#   end
#   erb :result
# end

