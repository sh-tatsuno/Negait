class Support < ActiveRecord::Base
  belongs_to :post
  has_many :talks
end
