class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        #creator can manage list/chores/invites
        #list admin can manage chores
        can :manage, List, creator_id: user.id
        can :read, List do |list|
          list.users.include?(user)
        end
        can :join, :all
        can :leave_list, List do |list|
          list.users.include?(user)
        end
        can :complete, Chore do |chore|
          user.chores.include?(chore)
        end
        can :read, Chore do |chore|
          user.chores.include?(chore)
        end
        can :manage, Chore, :list => { :creator_id => user.id }
        can :manage, Invite, :list => { :creator_id => user.id }
        can :edit, List do |list|
          List.check_admin?(list, user)
        end
        can :manage, Chore do |chore|
          List.check_admin?(List.find_by(id: chore.list_id), user)
        end

      end


    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
