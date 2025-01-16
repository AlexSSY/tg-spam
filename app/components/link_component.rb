# frozen_string_literal: true

class LinkComponent < ApplicationComponent
  def initialize(text, path)
    @text = text
    @path = path
  end

  attr_accessor :text, :path

  def call
    content_tag :a, text, href: path, class: "text-indigo-500"
  end
end
