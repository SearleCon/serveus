# == Schema Information
#
# Table name: baskets
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  interactions_count :integer          default(0)
#

class Basket < ActiveRecord::Base
  belongs_to :user, touch: true
  has_many :interactions
end
