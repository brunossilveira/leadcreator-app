class Credential < ActiveRecord::Base
  belongs_to :user

  validates :instance_url, :client_id, :client_secret, :presence => true

  def useful_attributes
    self.attributes.except('id', 'user_id', 'created_at', 'updated_at')
  end
end
