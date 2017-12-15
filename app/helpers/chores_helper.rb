module ChoresHelper

  def slice_count(list_count)
     if list_count.even?
       slice = list_count / 2
     else
       slice = (list_count + 1) / 2
     end
  end



  def create_chore_array_view(frequency, all_chores)
    sorted_chores = []
    all_chores.each do |chore|
      if chore.frequency == frequency && chore.status == "not done"
        sorted_chores << chore
      end
    end
    sorted_chores
  end


  def create_chore_array_edit(frequency, all_chores)
    sorted_chores = []
    all_chores.each do |chore|
      if chore.frequency == frequency
        sorted_chores << chore
      end
    end
    sorted_chores
  end

  def update_chore_goals(goal)
    #PLACEHOLDER -- dynamically change goal message
  end



end
