class AuxLead
  include ActiveModel::Model

  attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website
  validates :last_name, :company, presence: true


  def attributes
    {:name => self.name, :last_name => self.last_name, :email => self.email, :company => self.company, :job_title => self.job_title, :phone => self.phone, :website => self.website}
  end
end