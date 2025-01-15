module ApplicationHelper
  def component(name, *args, **kwargs, &block)
    render "#{name}_component".classify.constantize.new(*args, **kwargs), &block
  end

  def page_title(default = "Page")
    @page_title || default
  end
end
