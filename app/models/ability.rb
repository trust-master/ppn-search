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

    can [:create, :destroy],       Session        # log-out
    can [:create, :read, :update], PasswordReset
    can [:create, :read, :update], UserAuthToken
    can :read, Page

    if user.persisted? # authenticated user
      can :read, [CompanySearch]

      # hide hidden and inactive companies
      can :read, Company, visible: true, active: true

      case user
      when Administrator
        can :manage, :all
      when CompanyAdmin
        can :manage, Company, id: user.company_id
        can :manage, Discount, company_id: user.company_id
        can :manage, User, company_id: user.company_id, role: User::ROLES
      else
        can :manage,  User, id: user.id # self
      end

    end
  end
end
