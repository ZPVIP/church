#encoding: utf-8
class ContactImporter < ActiveImporter::Base
  imports Contact
  #transactional # this feature is not problematic
  skip_rows_if { row['name'].blank? or not row['skip?'].blank? }
  
  
  @@gender_mapping = {"male"=>1, "1"=>1, "female"=>0, "0"=>0}

  @@findus_mapping = {"搜索引擎"=>0, "网站或论坛"=>1, "活动宣传"=>2, "团契朋友介绍"=>3, "其它"=>4}
  
  @@findus_mapping.default = 4
  
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

  column 'how to find us', :find_us do |v|
    if v.nil? then v else look_up_in @@findus_mapping, v end
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
    puts_err "Error at row[%d]" % @row_index
  end

  # update existing contact
  fetch_model do
    if not row['email'].blank?   
      g=Contact.find_or_initialize_by( email: row['email'] )
      if not g.new_record? and not(row['overwrite?']=="yes")
          abort_on_error "email conflict (to force update, set the colume 'overwrite?' to 'yes')"
      end
      g
    else
      Contact.new
    end
  end

  on :row_processing do
    model.user = params[:current_user]
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
  
  def look_up_in(mydict, key)
    key ||= ""
    g = mydict[key.strip.downcase]
    abort_on_error "unsupported value '%s'" % key if g.nil?
    g
  end
  
  def abort_on_error(msg)
    puts_err msg
    if transactional?
      puts_err "Error at row[%d]" % @row_index
      abort! msg
    else
      raise msg
    end
  end

  def puts_err (msg)
     @error_msg ||=""
     @error_msg+=msg+"\n"
  end
end
