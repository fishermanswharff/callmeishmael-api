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
    binding.pry
    # self.stories.each_with_object({}) { |i, o|
    #   button = i.buttons.map { |b| b if b.phone_id == self.id }.first
    #   o[i.button.assignment] = i.title
    # }.sort.to_h.to_json
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