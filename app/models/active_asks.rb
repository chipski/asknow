class ActiveAsks 
  attr :asks, :users
  attr :approvers
  
  ASKS_FETCHED     = 'ASKS_FETCHED_NOTIFICATION'
  ASKS_FETCH_ERROR = 'ASKS_FETCH_ERROR_NOTIFICATION'
  USERS_FETCHED     = 'USERS_FETCHED_NOTIFICATION'
  USERS_FETCH_ERROR = 'USERS_FETCH_ERROR_NOTIFICATION'
  
  BASE_URL = "https://www.approvenow.com/api/v1/"
  

  def initialize(params={})
    # @base_params = '?approval_status=requested&'
    # url = BASE_URL + @base_params  
    @asks = []
    @users = [{username: "Lucky Ossai", email: "lo@now.com"}, {username: "Justin King", email: "jk@now.com"}]
  end
    
  
  def get_open_asks(query={})
    @asks ||= []
    Ask.all.entries do |new_ask|
      NSLog("ActiveAsks.get_open_asks ask_info= #{new_ask.inspect}")
      @asks << new_ask
    end
    NSNotificationCenter.defaultCenter.postNotificationName(ASKS_FETCHED, object:nil)
    @asks
  end  

  def get_users(filter={})
    @users ||= []
    User.all_borrowers.entries do |pf_user|
      NSLog("ActiveAsks.get_open_asks ask_info= #{new_ask.inspect}")
      @users << {username: pf_user.objectForKey("username"), email: pf_user.objectForKey("email")}
    end
    NSNotificationCenter.defaultCenter.postNotificationName(USERS_FETCHED, object:nil)
    @users
  end  
    
end