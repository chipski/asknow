class Ask
  include ParseModel::Model
  
  fields :title, :ask_type, :message, :requestor, :borrower, :approval_status, :approved_at, :requested_at
  
  def self.who_am_i
    PFUser.currentUser ? PFUser.currentUser.username : "me"
  end
  
  def self.all
    Ask.query.whereKey("requestor", equalTo:Ask.who_am_i).find
  end

  def self.all
    Ask.query.whereKey("requestor", equalTo:Ask.who_am_i).find
  end
  
  def label_text
    "#{ask_type} for #{borrower}"
  end
  
  def status_button
    
  end

  
  def overdue?
    self.requested_at && (NSDate.new > self.requested_at + 4.hours) && !done
  end
        
  def new?
    objectId.nil?
  end
        
  def valid?
    !ask_type.nil?
  end
  
  def done
    self.approved_at && (NSDate.new > self.approved_at + 1.hours)
  end
  
end