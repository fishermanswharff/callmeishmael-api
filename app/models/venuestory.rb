class Venuestory < ActiveRecord::Base
  belongs_to :venue
  belongs_to :story
end