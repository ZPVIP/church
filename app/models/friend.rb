class Friend < Contact
  validates_presence_of :name, :gender, :email
end
