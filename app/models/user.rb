class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, format: Devise.email_regexp, uniqueness: true
end
