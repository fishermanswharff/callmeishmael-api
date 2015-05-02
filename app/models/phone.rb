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
    stories = Story.find_by_sql("SELECT stories.url, buttons.assignment FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{self.id} ORDER BY buttons.assignment;")
    stories.map { |s| s.url }.to_json
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

# Category.includes(articles: [{ comments: :guest }, :tags]).find(1)

# This will find the category with id 1 and eager load all of the
# associated articles, the associated articles' tags and comments,
# and every comment's guest association.