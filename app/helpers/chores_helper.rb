module ChoresHelper

  def slice_count(list_count)
    if list_count.even?
       slice = list_count / 3
     else
       slice = (list_count + 1) / 3
     end
  end

  #def create_chore_array_view(frequency, all_chores)
  #  sorted_chores = all_chores.where(frequency: frequency, status: "not done")
  #end

  def create_chore_array_view(all_chores)
    sorted_chores = all_chores.where(status: "not done")
  end

  def decide_button_class(past_due_status, frequency)
    if past_due_status == true
      "chore pastdue"
    elsif frequency == "daily"
      "chore daily"
    elsif frequency == "weekly"
      "chore weekly"
    else
      "chore monthly"
    end
  end


  def create_chore_array_edit(frequency, all_chores)
    sorted_chores = all_chores.where(frequency: frequency)
  end

  def calculate_monthly_goal(chore_count)
    goal = (chore_count/5.to_f).ceil
  end

  def calculate_weekly_goal(chore_count)
    goal = (chore_count/7.to_f).ceil
  end



end
