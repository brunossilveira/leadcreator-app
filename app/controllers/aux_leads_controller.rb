class AuxLeadsController < ApplicationController
  before_action :authenticate_user!

  def new
    @lead = AuxLead.new
  end

  def create
    @lead = AuxLead.new(params[:aux_lead])

    if @lead.valid?
      lead = Lead.new(current_user.credential.useful_attributes.symbolize_keys)
      success = lead.create(@lead.attributes)

      if success
        flash[:success] = 'Lead created'
        redirect_to root_path
      else
        flash[:error] = 'Something went wrong.'
        render :new
      end
    else
      flash[:error] = 'Verify the attributes'
      render :new
    end
  end

  rescue_from Restforce::UnauthorizedError do |exception|
    flash[:error] = 'Your authentication token has expired. Click in Update Credentials to get a new one.'
    redirect_to edit_credentials_path
  end

  rescue_from URI::BadURIError do |exception|
    flash[:error] = 'Wrong URI. Verify your Instance URL.'
    redirect_to root_path
  end
end
