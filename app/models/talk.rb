class Talk < ActiveRecord::Base
  validates :talk, presence: true
  belongs_to :support
  belongs_to :user
end
