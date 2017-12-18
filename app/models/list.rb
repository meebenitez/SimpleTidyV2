class List < ApplicationRecord
  has_many :lists_users
  has_many :users, through: :lists_users
  has_many :chores
  has_many :invites

  accepts_nested_attributes_for :invites , reject_if: proc { |attributes| attributes['email'].blank? }
  #accepts_nested_attributes_for :users

  validates :name, presence: true
  
  #def admin_name=(id)
   # admin = User.find(id: id)
   # self.admin = admin
  #end



  def self.grab_starter_chores(list_type)
    if list_type == "Home"
        Chore::HOME_DATA
      elsif list_type == "Car"
        Chore::CAR_DATA
      else
        Chore::TECH_DATA
      end
  end


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

  def self.send_invites_on_list_create(list)
    list.invites.each do |invite|
      if user = User.find_by(email: invite.email)
        user.invites << invite
      end
    end
  end

end
