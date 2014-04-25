5.times do |x|
  Card.create(deck_id: 1, question: "Dummy question #{x}", answer: "answer")
end

Deck.create(name: "Dummy deck")
User.create(username: "spiffy", email: "spiffy@spiffy.com", password_hash: "unhashed")
