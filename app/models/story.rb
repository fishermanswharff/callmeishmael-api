class Story < ActiveRecord::Base
  has_many :buttons
  has_many :phones, through: :buttons
  enum type: [:fixed, :venue, :surprise]
end