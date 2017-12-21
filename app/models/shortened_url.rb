class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true, presence: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  has_many :distinct_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :joins,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :TopicJoin

    has_many :topics,
      through: :joins,
      source: :topic

  def self.create_shortened_url(long_url, user)
    ShortenedUrl.new(long_url: long_url, short_url: ShortenedUrl.random_code, user_id: user.id)
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64(12)

    while ShortenedUrl.find_by short_url: code
      code = SecureRandom.urlsafe_base64(12)
    end

    code
  end

  def num_clicks
    self.visitors.length
  end

  def num_uniques
    self.distinct_visitors.count
  end

  def num_recent_uniques
    self.distinct_visitors.where({created_at: 90.minutes.ago..Time.now}).count
  end

end
