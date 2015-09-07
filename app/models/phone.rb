# == Schema Information
#
# Table name: phones
#
#  id                :integer          not null, primary key
#  unique_identifier :text
#  token             :text             not null
#  status            :integer          default(0), not null
#  wifiSSID          :text
#  wifiPassword      :text
#  created_at        :datetime
#  updated_at        :datetime
#  venue_id          :integer
#

class Phone < ActiveRecord::Base
  before_create :set_token
  after_create :set_unique_id
  belongs_to :venue, counter_cache: :number_phones
  has_many :buttons
  has_many :stories, through: :buttons
  has_many :phonelogs
  enum status: [:active, :inactive, :retired, :fixable]

  validates_associated :venue
  validates_associated :buttons, if: :has_buttons?

  def set_unique_id
    if self.venue
      self.unique_identifier = "#{self.venue.id}-#{self.id}"
      self.save!
    end
  end

  def get_urls
    # ordered by assignment: #,*,0,1,2,…
    stories = Story.connection.select_all("SELECT buttons.assignment, stories.url FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{self.id} ORDER BY buttons.assignment;").rows.to_h
    array = []
    array[0] = stories['#']
    array[1] = stories['*']
    array[2] = stories['0']
    array[3] = stories['1']
    array[4] = stories['2']
    array[5] = stories['3']
    array[6] = stories['4']
    array[7] = stories['5']
    array[8] = stories['6']
    array[9] = stories['7']
    array[10] = stories['8']
    array[11] = stories['9']
    array[12] = stories['PR']
    array.to_json
  end

  def send_log_file(log)
    Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['S3_LOG_BUCKET_NAME'])
    s = "%10.9f" % Time.now.to_f
    resp = bucket.put_object({key: "venue_#{venue.id}/phone_#{self.id}/#{s}.txt", body: log})
    # LogMailer.log_email(bucket.url + '/' + resp.key).deliver_now
    { response: resp, bucket_url: bucket.url }
  end

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end

  private

  def has_buttons?
    self.buttons.length > 0
  end
end
