class List < ApplicationRecord
  has_many :lists_users, dependent: :destroy
  has_many :users, through: :lists_users
  has_many :chores
  has_many :invites

  accepts_nested_attributes_for :invites , reject_if: proc { |attributes| attributes['email'].blank? }

  scope :list_admin, -> (user_id) {
    joins(lists_users: :user).where(users: {id: user_id}).where(lists_users: {admin: true})
  }

  validates :name, presence: true
  validates :list_type, presence: true


#grab ids of admins from nested form
  def users_attributes=(users_attributes)
    admin_ids = []
    users_attributes.values.each do |user_attribute|
      if user_attribute.values[1] == "1"
        admin_ids << user_attribute.values[0].to_i
      end
    end
    join_entries = ListsUser.jointables(self.id)
    join_entries.each do |entry|
      if admin_ids.include?(entry.user_id)
        entry.update(admin: true)
      else
        entry.update(admin: false)
      end
    end
  end

  #check if a user is a designated admin of the list
  def self.check_admin?(list, user)
    ListsUser.find_by(list_id: list.id, user_id: user.id).admin
  end

  def self.is_creator?(list, user)
    list.creator_id == user.id
  end



  def self.grab_starter_chores(list_type)
    if list_type == "Home"
      Constants::HOME_DATA
    elsif list_type == "Car"
      Constants::CAR_DATA
    else
      Constants::TECH_DATA
    end
  end

  #create starter chores for a new list
  def self.create_starter_list(list)
    now = Time.now
    starter_chores = grab_starter_chores(list.list_type)
    starter_chores[:chores].each do |chore|
      new_chore = list.chores.new
      chore.each_with_index do |attribute, i|
        new_chore.send(starter_chores[:chore_keys][i]+"=", attribute)
        new_chore.save
      end
      reset_time = Chore.set_reset(now, new_chore.frequency) 
      set_past_due = Chore.set_past_due(now, new_chore.time_of_day, reset_time)
      new_chore.update(reset_time: reset_time, past_due_time: set_past_due)
    end
  end

  #check if user with invite email already exists in system and "give" them the invite
  def self.send_invites_on_list_create(list)
    list.invites.each do |invite|
      Invite.send_invite(invite)
    end
  end

end
