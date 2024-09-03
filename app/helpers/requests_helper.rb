module RequestsHelper
  def status_badge(request)
    case request.status
    when 'live'
      content_tag(:span, 'Live', class: 'inline-flex items-center rounded-md bg-green-50 px-2 py-1 text-xs font-medium text-green-600 ring-1 ring-inset ring-green-500/10')
    when 'shipping'
      content_tag(:span, 'Shipping', class: 'inline-flex items-center rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-600 ring-1 ring-inset ring-blue-500/10')
    when 'completed'
      content_tag(:span, 'Completed', class: 'inline-flex items-center rounded-md bg-red-50 px-2 py-1 text-xs font-medium text-red-600 ring-1 ring-inset ring-red-500/10')
    else
      content_tag(:span, 'Live', class: 'inline-flex items-center rounded-md bg-green-50 px-2 py-1 text-xs font-medium text-green-600 ring-1 ring-inset ring-green-500/10')
    end
  end
end