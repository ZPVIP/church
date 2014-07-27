class ContactImporter < ActiveImporter::Base
  imports Contact
  #transactional # this feature is not problematic
  skip_rows_if { row['name'].blank? or not row['skip?'].blank? }
  
  
  @@gender_mapping = {"male"=>1, "1"=>1, "female"=>0, "0"=>0}
  def error_msg
    @error_msg ||= ""
  end


  column 'phone', :telephone
  column 'mobile phone', :mobile
  column 'email', :email
  column 'wechat', :wechat
  column 'address', :address
  column 'birthday', :birthday
  column 'date of first come', :come
  column 'decision', :decision
  column 'decision_with', :decision_with
  column 'date of baptism', :baptism
  column 'date of leaving', :go
  #column 'created_at', :created_at
  column 'comment', :comment
  column 'job', :job
  column 'how to find us', :find_us
  column 'how to find us additional', :find_us_additional
  #column 'friend id', :friend_id
  column 'pray', :pray
  column 'native place', :native_place
  column 'spouse', :spouse
  column 'authenticated', :authenticated
  #column 'q', :q

  column 'name', :name do |contact_name|
    contact_name.strip
  end

  column 'gender', :gender  do |gender_name|
    look_up_in @@gender_mapping, gender_name
  end

  column 'participated group', :participated_group_ids do |group_name|
    query(Group, group_name)
  end

  column 'participated gathering', :participated_gathering_ids do |gathering_name|
    query(ContactGathering, gathering_name)
  end
  
  on :row_success do
  end

  on :row_error do |e|
    puts_err "Cannot import row[%d] due to %s" % [@row_index, e.message ]
  end

  # update existing contact
  fetch_model do
    if  row['email'].present? and not row['email'].empty?
      g=Contact.find_or_initialize_by( email: row['email'] )
      if not g.new_record? and not(row['overwrite?']=="yes")
          abort_on_error "unable to update existing contacts at row[%d]. To force update, set the colume 'overwrite?' to 'yes'." % @row_index
      end
      g
    else
      Contact.new
    end
  end

  on :row_processing do
    #model.user = params[:current_user]
    model.register_ip = params[:ip]
  end

private
  def query(repo, value_str, options={})
    if value_str.nil? or value_str.empty?
       return []
    end
    values = value_str.split(';')
    labelkey = options.fetch(:label, :name)
    valuekey = options.fetch(:value, :id)
    results = []
    values.each do |value|
        value.strip!
        g = repo.find_by(**{labelkey=>value})
        #Rails.logger.debug "found %s for %s" % [g,value]
        next if g.nil? 
        results << g.send(valuekey)
    end
    results
  end
  
  def abort_on_error(msg)
     puts_err msg
     abort! msg
  end

  def look_up_in(mydict, key)
    key ||= ""
    g = mydict[key.strip.downcase]
    abort_on_error "unsupported value %s at row[%d]" % [key, @row_index] if g.nil?
    g
  end

  def puts_err (msg)
     @error_msg ||=""
     @error_msg+=msg+"\n"
  end
end
