class ContactsController < ApplicationController
  # Get request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # Post request /contacts
  def create
    # mass assignment of form fields into contact object
    @contact = Contact.new(contact_params)
    # save the contact object to database
    if @contact.save
      # Store form fields via parameters
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into contact mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash
      # and redirect to the new action
      flash[:success] = "Message Sent."
      redirect_to new_contact_path notice
    else
      # If contact object doesn't save
      # Store errors in flash hash
      # and redirect to new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path notice
    end
  end
  
  private
    # To collect data in form week need to 
    # use strong parameters and whitelist the form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end
    