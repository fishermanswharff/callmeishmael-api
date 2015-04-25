class Button < ActiveRecord::Base
  belongs_to :phone
  belongs_to :story, counter_cache: :placements
end