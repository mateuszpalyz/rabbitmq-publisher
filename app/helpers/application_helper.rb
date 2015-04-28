module ApplicationHelper

  def boolean_icon(value)
    value ? '<i class="glyphicon glyphicon-ok"></i>'.html_safe : '<i class="glyphicon glyphicon-remove"></i>'.html_safe
  end
end
