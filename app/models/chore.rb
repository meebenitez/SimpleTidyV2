class Chore < ApplicationRecord
  belongs_to :list
  validates :name, presence: true

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
      ["Tidy desk areas", "biweekly", nil, "not done", false],
      ["Complete a load of laundry", "biweekly", nil, "not done", false],
      ["Pay bills", "biweekly", nil, "not done", false],
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


#Create the time a "completed" chore will show back up on the list
  def self.set_reset(now, frequency)
    subtract_time = now - now.strftime("%H").to_i.hours - now.strftime("%M").to_i.minutes - now.strftime("%S").to_i.seconds
    if frequency == "daily"
      reset_time = subtract_time + 1.days
    elsif frequency == "biweekly"
      reset_time = subtract_time + 3.days
    elsif frequency == "weekly"
      reset_time = subtract_time + 1.weeks
    else
      reset_time = subtract_time + 1.months
    end
  end

  def complete_chore(chore)
    chore.status = "done"
  end

  def calculate_chore_goal(frequency, count)
    #PLACEHOLDER -- calculate how many weekly/monthly chores must be completed daily to stay on track
  end



end