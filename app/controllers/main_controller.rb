class MainController < UIViewController

  def init
    super
    @data = []
    self
  end

  def viewDidLoad
    super
    if PFUser && PFUser.currentUser
      #init_ask_list
      init_user_list
    else
      init_login
    end
  end

  def init_ask_list
    ask_list_controller = AskListController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.alloc.init)
    @ask_list_controller = UINavigationController.alloc.initWithRootViewController(ask_list_controller)
    @ask_list_controller.view.frame = UIScreen.mainScreen.bounds
    # @ask_list_controller.delegate = self
    self.addChildViewController @ask_list_controller
    self.view.addSubview @ask_list_controller.view
  end
  
  def init_user_list
    width =       UIScreen.mainScreen.bounds.size.width
    list_height = UIScreen.mainScreen.bounds.size.height-200
    top_frame = CGRectMake(0,0, width, 200)
    top_action_view = UIImageView.alloc.initWithFrame(top_frame)
    top_action_view.image = "approval_responses5.png".uiimage
    self.view.addSubview top_action_view
    add_actions_button
    
    @list_controller = UserListController.alloc.init
    # x, y, width, height
    @list_controller.view.frame = CGRectMake(0,200, width, list_height)
    # @list_controller.delegate = self
    self.addChildViewController @list_controller
    self.view.addSubview @list_controller.view
  end

  def show_top_ask_response
    NSLog("Main.show_top_ask_response") 
    @ask_view_controller = AskApproveController.alloc.init
    @ask_view_controller.set_ask_type("approver")
    @ask_view_controller.view.frame = UIScreen.mainScreen.bounds
    @ask_view_controller.delegate = self
    self.navigationController.pushViewController(@ask_view_controller, animated:'YES')
    # self.childViewControllers.each {|cont| cont.view.removeFromSuperview}
    # self.view.subviews.each{|view| view.removeFromSuperview}
    #self.presentViewController(@ask_view_controller, animated:true, completion:nil)
  end
  
  def completed_ask_response
    
  end
  
  def add_actions_button(num_waiting=1)
    MotionAwesome.button( :check_square, size: 48, text:"#{num_waiting}" ) do |button|
      button.titleLabel.textColor = "#b6b6b6".uicolor(0.8)
      button.titleLabel.font      = UIFont.fontWithName( 'Helvetica Neue', size:64 )
      button.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width/2)-90,70,180,64)
      button.setShowsTouchWhenHighlighted true
      button.addTarget( self, action: "show_top_ask_response",
                        forControlEvents: UIControlEventTouchDown )
      self.view.addSubview( button )
    end
    NSLog("Main.add_actions_button")    
  end

  def init_login
    @login_controller ||= PFLogInViewController.new
    @login_controller.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton |
                    PFLogInFieldsSignUpButton | PFLogInFieldsPasswordForgotten #| PFLogInFieldsFacebook
    @login_controller.delegate = self
    @login_controller.signUpController.delegate = self
    self.view.addSubview @login_controller.view
    self.presentModalViewController(@login_controller, animated:true)
  end
  
  def logInViewController(logIn, didLogInUser:user)
    @login_controller.dismissModalViewControllerAnimated(true)
    init_user_list
  end
  
  def switch_to_ask_list
    init_ask_list unless @ask_list_controller
    @ask_list_controller
  end

  def switch_to_login
    init_login unless @login_controller
    @login_controller
  end

  def logoutTapped
    PFUser.logOut
    appDelegate = UIApplication.sharedApplication.delegate
    appDelegate.presentMainViewController
  end
  
end
