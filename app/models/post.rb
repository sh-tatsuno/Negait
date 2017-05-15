class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :detail, presence: true
  belongs_to :user
  has_many :supports

end
