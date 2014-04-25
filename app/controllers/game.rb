get '/game/select' do
  @all_decks = Deck.all
  erb :game_select

end

get '/game/question/:id' do
  erb :question
end

get '/game/result/:id' do
  erb :result
end

