class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id
  after_save :update_post_counter

  validates :title, presence: { message: 'Title can not be blank' },
                    length: { maximum: 250,
                              too_long: 'Title can only accept a maximum of 250 characters' }
  validates :comments_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'commentsCounter must be integer and >=0' }
  validates :likes_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'likesCounter must be integer and >=0' }
  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_post_counter
    author.update(post_counter: author.posts.all.length)
  end
end
