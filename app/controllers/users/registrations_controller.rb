class Users::RegistrationsController < Devise::RegistrationsController
  def create
    #Extend Devise gem default behavior so that
    #Users signing up with Pro account, plan_id 2
    #Save with a stripe subscription function
    #Otherwise Devise signs up like normal
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end