class Invite < ApplicationRecord
  belongs_to :list
  belongs_to :user, optional: true


  def self.valid_email?(email)
    valid = '[A-Za-z\d._+-]+'
      (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
   end



end
