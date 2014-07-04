require 'spec_helper'

describe AuxLeadsController do

  context '#create' do
    it 'should rescue from Restforce::UnauthorizedError' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
      controller.stub(:create).and_raise(Restforce::UnauthorizedError)
      post :create
      response.should redirect_to edit_credentials_path
      flash[:error].should eq('Your authentication token has expired. Click in Update Credentials to get a new one.')
    end

    it 'should rescue from URI::BadURIError' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
      controller.stub(:create).and_raise(URI::BadURIError)
      post :create
      response.should redirect_to root_path
      flash[:error].should eq('Wrong URI. Verify your Instance URL.')
    end

  end

end