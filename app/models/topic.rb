class Topic < ApplicationRecord

  has_many :joins,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TopicJoin

  has_many :urls,
    through: :joins,
    source: :url

  def popular_links
    self.urls.sort_by{ |a,b| b.num_clicks <=> a.num_clicks }
  end
end
