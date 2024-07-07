module BreadcrumbsHelper
  def add_breadcrumb(name, url = '')
    @breadcrumbs ||= []
    @breadcrumbs << { name: name, url: url }
  end

  def breadcrumbs
    @breadcrumbs || []
  end
end
