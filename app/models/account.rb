class Account < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  normalizes :phone, with: ->(phone) { (phone.to_i).abs.to_s }

  after_save :generate_avatar, if: -> { full_name_changed? }

  def full_name
    "Richard Morozko"
  end

  def generate_avatar
    return unless full_name.present?

    tempfile = AvatarGenerator.generate(full_name)
    avatar.attach(
      io: tempfile,
      filename: "#{id}-avatar.png",
      content_type: "image/png"
    )
    tempfile.close
    tempfile.unlink
  end
end
