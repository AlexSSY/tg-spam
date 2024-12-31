module ApplicationHelper
  def component(name, *args, **kwargs, &block)
    render "#{name}_component".classify.constantize.new(*args, **kwargs), &block
  end
end
