module ApplicationHelper
  # Displays object errors
  def form_errors_for(object=nil)
    render('helpers/form_errors', object: object) unless object.blank? || object.errors.count == 0
  end

  def show_date_params(date)
    return unless date.kind_of?(Date) || date.kind_of?(Time)
    { date: date.to_date.to_s }
  end
end
