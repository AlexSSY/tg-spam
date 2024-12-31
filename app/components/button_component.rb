# frozen_string_literal: true

class ButtonComponent < ApplicationComponent
  VARIANTS = %w[ primary secondary ].freeze

  def initialize(url, text, variant: "primary")
    @url, @text = url, text
    @variant = variant

    raise ArgumentError, "Invalid variant: #{variant}" unless VARIANTS.include?(variant)

    @variant_classes = {
      VARIANTS[0] => "bg-neutral-200 block py-3 px-6 rounded-full text-sm font-medium text-neutral-800",
      VARIANTS[1] => "bg-neutral-900 block py-3 px-6 rounded-full text-sm text-neutral-400"
    }
  end

  attr_reader :url, :text, :variant

  def call
    content_tag :a, class: classes, href: url do
      text
    end
  end

  private

  def classes
    @variant_classes[variant]
  end
end
