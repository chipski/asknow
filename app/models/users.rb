class User
  include ParseModel::User
  
  #fields :name, :user_type, :username, :email

  def self.all_borrowers
    User.query.whereKey("user_type", equalTo:"borrower").find
  end

  def self.all_credit_officers
    User.query.whereKey("user_type", equalTo:"credit_officer").find
  end

  def self.all_branch_managers
    User.query.whereKey("user_type", equalTo:"branch_manager").find
  end

  def avatar_url
    avatar_url || "icons/avatar"
  end
  
  def user_type
    user_type || "borrower"
  end
  
  def is_credit_officer?
    user_type && (user_type == "credit_officer")
  end

  def is_branch_manager?
    user_type && (user_type == "branch_manager")
  end
  
  
end