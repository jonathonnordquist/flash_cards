class User < ActiveRecord::Base
  include BCrypt

  has_secure_password

  has_many      :games, class_name: "Round"
  has_many      :guesses, through: :rounds

  validates     :username, presence: true, uniqueness: true
  validates     :email, presence: true, uniqueness: true
  # validates     :password, presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  # validate      :check_valid_email

  # def check_valid_email
  #   if self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  #     true
  #   else
  #     errors.add(:email, "Please enter a valid email address.")
  #   end
  # end
end
