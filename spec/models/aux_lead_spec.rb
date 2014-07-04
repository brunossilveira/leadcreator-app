require 'spec_helper'

describe AuxLead do

  it { should respond_to :name, :last_name, :email, :company, :job_title, :phone, :website }

  it { should validate_presence_of :last_name }
  it { should validate_presence_of :company }

  let(:lead) { FactoryGirl.build(:aux_lead) }

  context '#attributes' do
    it 'should return a hash' do
      expect(lead.attributes).to be_an_instance_of(Hash)
    end

    it 'should contain all attributes' do
      expect(lead.attributes).to include(:name, :last_name, :email, :company, :job_title, :phone, :website)
    end
  end

end