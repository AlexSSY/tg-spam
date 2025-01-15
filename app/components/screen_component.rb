# frozen_string_literal: true

class ScreenComponent < ApplicationComponent
  def initialize(title)
    @title = title
  end

  attr_reader :title

  def call
    content_tag :div, class: "h-screen flex items-center justify-center" do
      content_tag :div, class: "w-full mx-6" do
        content_tag :div, class: "space-y-6" do
          concat content_tag(:p, title, class: "text-2xl text-center")
          concat content
        end
      end
    end
  end
end
