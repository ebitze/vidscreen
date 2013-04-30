# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: {maximum: 20 }
  
  VALID_EMAIL_REGEX = 
    /\A[\w\-]+([\.+][\w\-]+)*@(([a-z\d]+([\-.][a-z\d]+)*\.[a-z]+)|((\[)?\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(\])?))\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: {minimum: 9 }
  validates :password_confirmation, presence: true
end