class Phone < ActiveRecord::Base
  before_create :set_token
  after_create :set_unique_id
  belongs_to :venue, counter_cache: :number_phones
  has_many :buttons
  has_many :stories, through: :buttons
  enum status: [:active, :inactive, :retired, :fixable]

  def set_unique_id
    if self.venue
      self.unique_identifier = "#{self.venue.id}-#{self.id}"
      self.save!
    end
  end

  def get_urls
    # ordered by assignment: #,*,0,1,2,…
    stories = Story.find_by_sql("SELECT stories.url, stories.id, buttons.assignment FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{self.id} ORDER BY buttons.assignment;")
    hash = stories.each_with_object({}) { |i,o|
      o[buttons.map { |b| b.assignment if b.story_id == i.id }.compact.first.to_s] = i.url
    }
    array = []
    array[0] = hash['#']
    array[1] = hash['*']
    array[2] = hash['0']
    array[3] = hash['1']
    array[4] = hash['2']
    array[5] = hash['3']
    array[6] = hash['4']
    array[7] = hash['5']
    array[8] = hash['6']
    array[9] = hash['7']
    array[10] = hash['8']
    array[11] = hash['9']
    array.to_json
  end

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end
