class ContactGathering < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :contact
end
