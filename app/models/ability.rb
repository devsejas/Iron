class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
       
      user ||= User.new # guest user (not logged in)
      if user.rol.permision == 6
        # can :manage, User
        # can :manage, Item 
        # can :manage, Sale 
        # can :manage, Client
         can :manage, :all
       elsif user.rol.permision == 5
       elsif user.rol.permision == 4
       elsif user.rol.permision == 3
       elsif user.rol.permision == 2  
       alias_action :read, :update,  :to => :ru
       alias_action :read, :update, :create,  :to => :cru
       alias_action :read, :update, :create, :destroy,  :to => :crud
       can :read , Item
       can :create , Sale
       can :create , Client
       can :manage , SaleDetail
       can :manage , Stock
       can :ru , Modulo
       # can :cru , Client
       can :cru , Address
       can :crud , Departamento
       can :crud , Province
       can :crud , Zona
       can :crud , Avenida
       can :crud , Country
       can :crud , Contact
       can :create, Payment

       elsif user.rol.permision == 1
        can :update, User
        can :read, Item  
        cannot :manage , Sale
        cannot :manage , Client

      end
    can :manage, Sale do |sal|
      sal.user == user
      can :manage, Payment

    end
    can :manage, Client do |cli|
      cli.asig_a_user_id == user.id
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
