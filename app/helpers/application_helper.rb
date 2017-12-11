module ApplicationHelper

  def valid_email?(email)
    valid = '[A-Za-z\d._+-]+'
    (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
  end

end
