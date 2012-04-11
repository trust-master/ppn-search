class Ability
  include CanCan::Ability

  def initialize(user)
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new

    can [:create, :destroy],       Session
    can [:create, :read, :update], PasswordReset
    can :read, Page

    if user.persisted? # authenticated user
      can :read,    :all

      cannot :read, Company, visible: false
      cannot :read, Company, active: false

      can :destroy, Session
      can :manage,  User, id: user.id

      if user.is_a?(CompanyAdmin)
        can :manage, Company, id: user.company_id
        can :manage, Discount, company_id: user.company_id
        can :manage, User, company_id: user.company_id, role: User::ROLES
      end

      if user.is_a?(Administrator)
        can :manage, :all
      end

    end
  end
end
