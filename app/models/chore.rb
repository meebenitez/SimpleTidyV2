class Chore < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validates :frequency, presence: true



#Create the time a "completed" chore will show back up on the list
  def self.set_reset(now, frequency)
    subtract_time = now - now.strftime("%H").to_i.hours - now.strftime("%M").to_i.minutes - now.strftime("%S").to_i.seconds
    if frequency == "daily"
      reset_time = subtract_time + 1.days
    elsif frequency == "weekly"
      reset_time = subtract_time + 7.days
    else
      reset_time = subtract_time + 1.months
    end
  end

  def self.set_past_due(now, time_of_day, reset_time)
    subtract_time = now - now.strftime("%H").to_i.hours - now.strftime("%M").to_i.minutes - now.strftime("%S").to_i.seconds
    if time_of_day == "morning"
      reset_time - 12.hours
    else
      reset_time
    end
  end


  def self.complete_chore(chore)
    now = Time.now
    status = "done"
    reset_time = set_reset(now, chore.frequency)
    past_due_time = set_past_due(now, chore.time_of_day, chore.reset_time)
    chore.update(reset_time: reset_time, status: status, past_due_time: past_due_time, past_due: false)
  end

  def self.check_past_due(all_chores)
    now = Time.now
    all_chores.where("past_due_time <= ?", now).where(status: "not done").update(past_due: true)  
  end

  def self.set_chore_status(all_chores)
    now = Time.now
    all_chores.each do |chore|
      if chore.status == "done" && chore.reset_time <= now
        new_reset = set_reset(now, chore.frequency) 
        chore.update(reset_time: new_reset, status: "not done")
      end
    end
  end

end