# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  has_many :incidents

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers:  [:google_oauth2]



  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      user = create do |new_user|
        new_user.provider = auth.provider
        new_user.uid = auth.uid
        new_user.email = auth.info.email
        new_user.password =  Devise.friendly_token[0,20]
      end
    end
    user
  end
end
