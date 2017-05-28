class ProfilesController < ApplicationController
  
  # GET to user/:user_id/profile/new
  def new
    # Render blank profile details here
    @profile = Profile.new
  end
   
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the User who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this User
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to root_path
    else
      render action: :new 
    end
  end
  
  
  private 
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end