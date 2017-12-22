class Invite < ApplicationRecord
  belongs_to :list
  belongs_to :user, optional: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create


  def self.valid_email?(email)
    valid = '[A-Za-z\d._+-]+'
      (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
  end

  def self.duplicate_invite?(list, email)
    self.exists?(list_id: list.id, email: email, status: "open")
  end

  def self.already_member?(list, email)
    list.users.exists?(email: email)
  end



end
