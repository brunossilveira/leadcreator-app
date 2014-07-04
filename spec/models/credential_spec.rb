require 'spec_helper'

describe Credential do

  it { should respond_to :instance_url, :client_id, :client_secret, :oauth_token }

  it { should belong_to :user }

  it { should validate_presence_of :instance_url }
  it { should validate_presence_of :client_id }
  it { should validate_presence_of :client_secret }

  let(:credential) { FactoryGirl.build(:credential) }

  context '#useful_attributes' do
    it 'should not return user_id' do
      credential.useful_attributes['user_id'].should be_nil
    end
  end
end