class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: { message: 'Name can not be blank' }
  validates :postCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'postCounter must be integer and >=0' }
  def three_most_recent_post
    posts.order(created_at: :desc).limit(3)
  end
end
