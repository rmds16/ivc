module ApplicationHelper
  # Displays object errors
  def form_errors_for(object=nil)
    render('helpers/form_errors', object: object) unless object.blank? || object.errors.count == 0
  end
end
