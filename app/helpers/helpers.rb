def get_cards
  guesses = []
  Guess.where(round_id: session[:current_round], correct: nil).each do |x|
    guesses << x
  end
  new_card = Card.find_by_id(guesses.shuffle[0].card_id)
  return new_card
end

