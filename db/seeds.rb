# 5.times do |x|
Card.create(deck_id: 1, question: "What is the capital of Columbia?", answer: "Bogota")
Card.create(deck_id: 1, question: "What is the capital of New Zealand?", answer: "Wellington")
Card.create(deck_id: 1, question: "What is the capital of Mongolia?", answer: "Ulan Bator")
Card.create(deck_id: 1, question: "What is the capital of South Africa?", answer: "Pretoria")
Card.create(deck_id: 1, question: "What is the capital of Peru?", answer: "Lima")
# end

Deck.create(name: "Dummy deck")
User.create(username: "spiffy", email: "spiffy@spiffy.com", password: "spiffy", password_confirmation: "spiffy")
