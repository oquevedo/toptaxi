class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.admin?
        can :manage, :all
    else
        # global abilities
        can [ :activate], User
        # can [:index, :show], Blog

        # only if the user is logged in
        if user.id!=nil
            # can only update if its his own
            can [:show,:edit, :update], User, id: user.id
            # can [:new, :edit, :create, :update, :destroy], Blog
            # can [:new, :create, :destroy], Comment

            if user.manage_user
                can [:new, :create, :index], User
            end
            if user.manage_campaign
                can [:new, :create, :index], Campaign
            end
        end
    end



    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
