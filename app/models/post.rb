class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    if query.present?
      where('title ILIKE ? OR content ILIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end