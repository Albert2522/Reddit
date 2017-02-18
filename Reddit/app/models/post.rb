class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :sub

  belongs_to :author


  has_many :post_subs

  has_many :subs, through: :post_subs
end
