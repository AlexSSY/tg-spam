class Account < ApplicationRecord
  belongs_to :user
  serialize :session_data, JSON
end
