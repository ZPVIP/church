class PagesController < ApplicationController
  def welcome
    @contacts = Contact.all
  end
end
