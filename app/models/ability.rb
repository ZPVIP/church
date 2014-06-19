class Ability
  include CanCan::Ability

  def initialize(user)

    if not user.blank?
      can :read, Friend
      can :create, Friend

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
            if action == :modify_service
              modify_service
            else
              can action, subject
            end
          rescue => e
            Rails.logger.info "#{e}"
            Rails.logger.info "#{subject}"
          end
        end
      end
    end
  end

  def modify_service
    can :read, Calendar
    can :destroy, Calendar
    can :create, Calendar
    can :services_edit, Calendar
    can :add_name, Calendar
    can :update_name, Calendar
  end

end
