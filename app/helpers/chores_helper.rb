module ChoresHelper

  def slice_count(list_count)
     if list_count.even?
       slice = list_count / 2
     else
       slice = (list_count + 1) / 2
     end
  end

  def create_chore_array(frequency, all_chores)
    sorted_chores = []
    all_chores.each do |chore|
      if chore.frequency == frequency && chore.status == "not done"
        if Time.now > chore.reset_time
          chore.past_due = true
        end
        sorted_chores << chore
      end
    end
    #binding.pry
    sorted_chores
  end

end
