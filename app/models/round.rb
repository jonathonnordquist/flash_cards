class Round < ActiveRecord::Base
  belongs_to       :player, class_name: "User"
  has_many         :guesses
end
