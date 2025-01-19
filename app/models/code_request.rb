class CodeRequest < ApplicationRecord
  validates_presence_of :phone
  normalizes :phone, with: ->(phone) { (phone.to_i).abs.to_s }
  validate :ensure_account_is_free

  private

  def ensure_account_is_free
    if Account.where(user_id: Current.user.id, phone: phone).exists?
      errors.add(:phone, "You already connect this account.")
    end

    if Account.where(phone: phone).exists?
      errors.add(:phone, "This account already connected.")
    end
  end
end
