class Chore < ApplicationRecord
  belongs_to :list
  validates :name, presence: true


#### THESE NEED A NEW HOME ###########
  HOME_DATA = {
    :chore_keys =>
      ["name", "frequency", "time_of_day", "status", "past_due"],
    :chores => [
      ["Make bed", "daily", "morning", "not done", false],
      ["Do the dishes", "daily", nil, "not done", false],
      ["Take out the trash", "daily", nil, "not done", false],
      ["Wipe down stove & countertops", "daily", "evening", "not done", false],
      ["Wipe down bathroom counters", "daily", nil, "not done", false],
      ["10 minute tidy living room", "daily", "evening", "not done", false],
      ["Sort mail", "daily", nil, "not done", false],
      ["Water plants", "daily", nil, "not done", false],
      ["Vacuum high-traffic areas", "daily", nil, "not done", false],
      ["10 minute tidy bedrooms", "daily", "evening", "not done", false],
      ["Tidy desk areas", "weekly", nil, "not done", false],
      ["Complete a load of laundry", "weekly", nil, "not done", false],
      ["Pay bills", "weekly", nil, "not done", false],
      ["Vacuum or sweep all floors", "biweekly", nil, "not done", false],
      ["Mop hard floors", "weekly", nil, "not done", false],
      ["Wipe down light switches and door handles", "weekly", nil, "not done", false],
      ["Dust all surfaces", "weekly", nil, "not done", false],
      ["Thoroughly clean all bathrooms", "weekly", nil, "not done", false],
      ["Clean out expired fridge items", "weekly", nil, "not done", false],
      ["Wipe down kitchen cabinets and appliances", "weekly", nil, "not done", false],
      ["Wash all bedding", "monthly", nil, "not done", false],
      ["Clean oven", "monthly", nil, "not done", false],
      ["Wipe down baseboards/mouldings/doors", "monthly", nil, "not done", false],
      ["Wash ceiling light fixtures, wipe fan blades", "monthly", nil, "not done", false],
      ["Dust, vacuum or wash window coverings", "monthly", nil, "not done", false],

    ]

  }

  CAR_DATA = {
    :chore_keys =>
      ["name", "frequency", "time_of_day", "status", "past_due"],
    :chores => [
      ["Test", "daily", nil, "not done", false],
      ["Test", "weekly", nil, "not done", false],
      ["Test", "monthly", nil, "not done", false],
    ]

  }

  TECH_DATA = {
    :chore_keys =>
      ["name", "frequency", "time_of_day", "status", "past_due"],
    :chores => [
      ["Test", "daily", nil, "not done", false],
      ["Test", "weekly", nil, "not done", false],
      ["Test", "monthly", nil, "not done", false],
    ]

  }

  CUSTOM_DATA = {
    :chore_keys =>
      ["name", "frequency", "time_of_day", "status", "past_due"],
    :chores => [
      ["Test", "daily", nil, "not done", false],
      ["Test", "weekly", nil, "not done", false],
      ["Test", "monthly", nil, "not done", false],
    ]

  }


#Create the time a "completed" chore will show back up on the list
  def self.set_reset(now, frequency, time_of_day)
    subtract_time = now - now.strftime("%H").to_i.hours - now.strftime("%M").to_i.minutes - now.strftime("%S").to_i.seconds
    if frequency == "daily"
      if time_of_day == "morning"
        reset_time = subtract_time + 12.hours
      else
        reset_time = subtract_time + 1.days
      end
    elsif frequency == "weekly"
      reset_time = subtract_time + 7.days
    else
      reset_time = subtract_time + 1.months
    end
  end


  def self.complete_chore(chore)
    status = "done"
    reset_time = set_reset(Time.now, chore.frequency, chore.time_of_day)
    chore.update(reset_time: reset_time, status: status)
  end

  def self.check_past_due(all_chores)
    all_chores.each do |chore|
      if Time.now > chore.reset_time  && chore.status == "not done"
        chore.update(past_due: true)
      end
    end
  end

  def set_chore_status(all_chores)
    now = Time.now
    all_chores.each do |chore|
      if chore.status == "done" && chore.reset_time <= now
        new_reset = set_reset(Time.now, chore.frequency, chore.time_of_day) 
        chore.update(reset_time: new_reset, status: "not done")
      end
    end
  end

  def calculate_chore_goal(frequency, count)
    #PLACEHOLDER -- calculate how many weekly/monthly chores must be completed daily to stay on track
  end



end