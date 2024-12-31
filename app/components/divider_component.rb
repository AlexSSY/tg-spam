# frozen_string_literal: true

class DividerComponent < ApplicationComponent
  def initialize(text = nil)
    @text = text
  end

  attr_reader :text

  def call
    if text.present?
      content_tag :div, class: "flex px-3 items-center" do
        concat(line_element)
        concat(text_element)
        concat(line_element)
      end
    else
      content_tag :div, nil, class: "border-b border-neutral-700 px-3"
    end
  end

  private

  def line_element
    content_tag :div, nil, class: "border-b flex-grow border-neutral-700"
  end

  def text_element
    content_tag :span, text, class: "text-neutral-500 px-2"
  end
end
