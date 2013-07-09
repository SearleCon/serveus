# == Schema Information
#
# Table name: interaction_baskets
#
#  id             :integer          not null, primary key
#  interaction_id :integer
#  user_id        :integer
#  assigned       :boolean          default(FALSE)
#

class Basket < ActiveRecord::Base
  belongs_to :user, touch: true
  has_many :interactions
end
