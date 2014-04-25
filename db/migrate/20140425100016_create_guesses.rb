class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :round_id, :card_id
      t.boolean :correct?
      t.timestamps
    end
  end
end
