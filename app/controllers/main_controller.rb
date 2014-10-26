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
    @list_controller = UINavigationController.alloc.initWithRootViewController(UserListController.alloc.init)
    @list_controller.view.frame = UIScreen.mainScreen.bounds
    # @list_controller.delegate = self
    self.addChildViewController @list_controller
    self.view.addSubview @list_controller.view
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
    init_ask_list
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
