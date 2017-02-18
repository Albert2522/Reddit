module ApplicationHelper

  def auth_token
    text = '<input type="hidden" name="authenticity_token" value=#{form_authenticity_token}>'
    text.html_safe
  end
end
