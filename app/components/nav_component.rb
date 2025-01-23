# frozen_string_literal: true

class NavComponent < ApplicationComponent
  def initialize(url, text)
    @url, @text = url, text
  end

  attr_reader :url, :text

  def call
    content_tag :a, text, href: url, class: css_class
  end

  private

  def css_class
    current_page = current_page?(url)
    "text-xs#{' underline font-bold' if current_page}"
  end
end
