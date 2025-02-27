class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is_admin?
        can :manage, :all
      else
        can :read, :all
      end
    #
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

    alias_action :create, :read, :update, :destroy, :to => :crud

    can :crud, Post do |post|
      user == post.user
    end

    can :crud, Medium do |medium|
      user == medium.user
    end

    can :crud, Comment do |comment|
      user == comment.user
    end

    can :crud, User do |u|
      user == u
    end

    can :vote, Comment do |comment|
      comment.user != user
    end
    can :crud, Vote do |vote|
      vote.user == user
    end

    can :like, Post do |post|
      post.user != user
    end
    can :like, Medium do |medium|
      medium.user != user
    end
    can :crud, Like do |like|
      like.user == user
    end

    can :follow, User do |u|
      user != u
    end
    # cannot :follow, User do |u|
    #   user == u
    # end
    can :crud, Relationship do |relationship|
      user.active_relationships == user
    end

    can :reviewlist, Post do |post|
      post.user != user
    end
    can :reviewlist, Medium do |medium|
      medium.user != user
    end
    can :crud, Reviewlist do |reviewlist|
      reviewlist.user == user
    end

  end
end
