require 'spec_helper'

describe CredentialsController do

  context 'with credentials' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @credential = FactoryGirl.create(:credential)
      @user.credential = @credential
      @user.save!
      @client = OAuth2::Client.new(@credential.client_id, @credential.client_secret, site: @credential.instance_url,
                                   authorize_url: '/services/oauth2/authorize', token_url: '/services/oauth2/token')
      sign_in @user
    end

    it 'should redirect to right url' do
      url = @client.auth_code.authorize_url(redirect_uri: callback_url)
      get :authorize

      expect(response).to redirect_to url
    end

  end

end