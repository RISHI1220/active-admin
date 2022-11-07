class Post < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true
  validates :body, presence: true
  scope :published, -> { where.not(:published_at => nil)}
  scope :unpublished, -> { where(:published_at => nil)}
end
