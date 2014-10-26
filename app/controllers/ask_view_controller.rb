class AskViewController <  UIViewController
  #attr_accessor :delegate
  
  def viewDidLoad
    super
    #self.title = "Loan Request"
    @ask_create_view = AskCreateView.new(view)
    @ask_create_view.target = self
    view.addSubview @ask_create_view
    
    # top_action_view = UIImageView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # top_action_view.image = "approval_responses.png".uiimage
    # view.addSubview top_action_view
    
    
  end

  def set_borrower(borrower)
    @borrower = borrower
    self.title = borrower[:username]
    NSLog("AskView.set_borrower #{borrower}")
  end
  
  def more_time(sender)
    NSLog("AskView.more_time clicked")
  end

  def more_money(sender)
    NSLog("AskView.more_money clicked")
  end

  def call_now(sender)
    NSLog("AskView.call_now clicked")
  end


end
