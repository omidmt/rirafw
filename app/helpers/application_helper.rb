module ApplicationHelper

  def title
    base_title = ""

    if @title.nil?
        base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def formatDate( date )
    if !date.nil?
      date.strftime("%A, %d %B, %Y")
    else
      ""
    end

  end

end
