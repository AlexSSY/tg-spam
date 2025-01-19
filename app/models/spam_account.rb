class SpamAccount < ApplicationRecord
  belongs_to :spam
  belongs_to :account
end
