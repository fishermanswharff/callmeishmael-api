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
    buttons.map.with_index { |b,i| "#{b.assignment} with #{stories[i].url}" }.to_json
    # binding.pry
    # stories.to_json
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
