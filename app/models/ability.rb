class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ## 指定超级用户
    if user.id == 1
      can :manage, :all
    else
      user.permissions.each do |p|
        begin
          action = p.action.to_sym
          subject = begin
            # RESTful Controllers
            p.subject.camelize.constantize
          rescue
            # Non RESTful Controllers
            p.subject.underscore.to_sym
          end
          can action, subject
        rescue => e
          Rails.logger.info "#{e}"
          Rails.logger.info "#{subject}"
        end
      end
    end
  end
end
