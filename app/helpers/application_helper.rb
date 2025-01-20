module ApplicationHelper
  def component(name, *args, **kwargs, &block)
    render "#{name}_component".classify.constantize.new(*args, **kwargs), &block
  end

  def page_title(default = "")
    @page_title || default
  end

  def simple_form_button_class(extra_classes = "")
    "#{SimpleForm.button_class} #{extra_classes}".strip
  end

  def simple_form_input_class(extra_classes = "")
    "#{SimpleForm.input_class} #{extra_classes}".strip
  end
end
