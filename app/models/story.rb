class Story < ActiveRecord::Base

  enum type: [:fixed, :venue, :surprise]
end