module Constants
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
      ["Vacuum or sweep all floors", "weekly", nil, "not done", false],
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
      ["Pick up all loose trash/garbage", "daily", nil, "not done", false],
      ["Empty out door pockets", "daily", nil, "not done", false],
      ["Empty out cupholders", "daily", nil, "not done", false],
      ["Empty garbage bag", "weekly", nil, "not done", false],
      ["Deep clean cupholders", "monthly", nil, "not done", false],
      ["Wipe down dashboard", "weekly", nil, "not done", false],
      ["Wipe down steering wheel and gearshift", "weekly", nil, "not done", false],
      ["Deep clean door pockets", "monthly", nil, "not done", false],
      ["Spray air conditioner treatment into air vents below windshield", "monthly", nil, "not done", false],
      ["Clean seats (wipe down leather/vacuum upholstery)", "monthly", nil, "not done", false],
      ["Vacuum footwells and floormats", "monthly", nil, "not done", false],
      ["Deep clean crevices around buttons and switches", "monthly", nil, "not done", false],
      ["Wipe down all windows with glass cleaner", "weekly", nil, "not done", false],
      ["Clean out trunk", "weekly", nil, "not done", false],
    ]

  }

  TECH_DATA = {
    :chore_keys =>
      ["name", "frequency", "time_of_day", "status", "past_due"],
    :chores => [
      ["Delete 10 items of junk mail", "daily", nil, "not done", false],
      ["Unsubscribe from 2 email lists", "daily", nil, "not done", false],
      ["Complete any necessary app/software updates", "weekly", nil, "not done", false],
      ["Wipe down keyboard & mouse", "weekly", nil, "not done", false],
      ["Deep clean keyboard and mouse", "monthly", nil, "not done", false],
      ["Tidy computer/laptop desktop", "daily", nil, "not done", false],
      ["Delete your downloads folder", "weekly", nil, "not done", false],
      ["Delete 10 obsolete bookmarks", "weekly", nil, "not done", false],
      ["Sort 10 userful bookmarks", "weekly", nil, "not done", false],
      ["Optimize computer/laptop with a cleaner software", "monthly", nil, "not done", false],
      ["Respond to all emails", "daily", nil, "not done", false],
      ["Unsubscribe from 5 facebook pages", "weekly", nil, "not done", false],
      ["Clean out dust bunnies from computer", "monthly", nil, "not done", false],
      ["Delete 20 unwanted photos from your phone", "weekly", nil, "not done", false],

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
end