require 'oauth2'

class CredentialsController < ApplicationController
  before_action :authenticate_user!
  before_action :auth_code, only: [:authorize, :callback]

  def edit
    current_user.build_credential if current_user.credential.nil?
    @credential = current_user.credential
  end

  def create
    @credential = current_user.build_credential
    @credential.attributes = credential_params

    if @credential.valid?
      @credential.save!
      redirect_to authorize_path
    else
      flash[:error] = 'Validation error.'
      render :edit
    end
  end

  def update
    @credential = current_user.credential
    @credential.attributes = credential_params

    if @credential.valid?
      @credential.save!
      redirect_to authorize_path
    else
      flash[:error] = 'Validation error.'
      render :edit
    end
  end


  def authorize
    # The authorization URL endpoint of the provider
    redirect_to @client.auth_code.authorize_url(redirect_uri: callback_url)
  end

  def callback
    token = @client.auth_code.get_token(params[:code], redirect_uri: callback_url).to_hash

    @credential.oauth_token = token[:access_token]
    @credential.save!

    flash[:sucess] = 'Authorization Sucsessful!'
    redirect_to root_path
  end

  private
  def credential_params
    params.require(:credential).permit(:instance_url, :client_id, :client_secret)
  end

  def auth_code
    @credential = current_user.credential
    @client = OAuth2::Client.new(@credential.client_id, @credential.client_secret, site: @credential.instance_url,
                                 authorize_url: '/services/oauth2/authorize', token_url: '/services/oauth2/token')

    @client.auth_code.authorize_url(redirect_uri: callback_url)
  end

end
