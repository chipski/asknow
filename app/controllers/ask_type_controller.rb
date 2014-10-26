class AskTypeController <  UIViewController
  attr_accessor :delegate, :borrower

  def init
    super
    
    self
  end
  
  def set_borrower(borrower)
    @borrower = borrower
    self.title = borrower[:username]
    NSLog("AskType.set_borrower #{borrower}")
  end

  def viewDidLoad
    super
    #self.title = "Ask Type"
    @ask_type_view = AskTypeView.new(view)
    @ask_type_view.target = self
    #@ask_type_view.delegate = self
    view.addSubview @ask_type_view
  end
  
  def more_time(sender)
    NSLog("AskView.more_time clicked")
    @ask_view_controller = AskViewController.alloc.init
    @ask_view_controller.set_borrower(borrower)
    @ask_view_controller.set_ask_type("extend_time")
    @ask_view_controller.view.frame = UIScreen.mainScreen.bounds
    self.navigationController.pushViewController(@ask_view_controller, animated:'YES') 
  end

  def more_money(sender)
    NSLog("AskView.more_money clicked")
    @ask_view_controller = AskViewController.alloc.init
    @ask_view_controller.set_borrower(borrower)
    @ask_view_controller.set_ask_type("more_money")
    @ask_view_controller.view.frame = UIScreen.mainScreen.bounds
    self.navigationController.pushViewController(@ask_view_controller, animated:'YES') 
  end

  def call_now(sender)
    NSLog("AskView.call_now clicked")
    @ask_view_controller = AskViewController.alloc.init
    @ask_view_controller.set_borrower(borrower)
    @ask_view_controller.set_ask_type("call_now")
    @ask_view_controller.view.frame = UIScreen.mainScreen.bounds
    self.navigationController.pushViewController(@ask_view_controller, animated:'YES') 
  end

end
