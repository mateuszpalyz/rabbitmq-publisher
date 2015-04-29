module ApplicationHelper

  def ack_status_icon(value)
    begin
      value ? '<i class="glyphicon glyphicon-ok"></i>' : '<i class="glyphicon glyphicon-remove"></i>'
    end.html_safe
  end
end
