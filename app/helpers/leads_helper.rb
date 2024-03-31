module LeadsHelper
  def display_followup_status(lead, followup_count)
    if lead.followup_count >= followup_count
      content_tag(:span, 'sent', class: 'bg-success px-2 py-1 text-white rounded-1')
    else
      link_to "Send #{num_to_text(followup_count)} follow-up", followup_lead_path(lead, followup_count:),
              class: 'text-success'
    end
  end

  private

  def num_to_text(num)
    case num
    when 1
      'first'
    when 2
      'second'
    when 3
      'third'
    when 4
      'fourth'
    end
  end
end
