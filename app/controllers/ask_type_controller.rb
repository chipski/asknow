class AskViewController <  UIViewController

  def init
    super
    @data = []
    self
  end

  def viewDidLoad
    super
    build_button("Request More Time", "more_time", "#642EFE", 0)
    build_button("Request More Money", "more_money", "#FE642E", 0)
    build_button("Request Call Now", "call_now", "#04B404", 0)
    
  end


  def build_button(title, action, backcolor="#b6b6b6", index=0)
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(title, forState: UIControlStateNormal)
    button.setTitleColor "#ccc".uicolor, forState: UIControlStateNormal
    button.setTitleColor :white.uicolor, forState: UIControlStateHighlighted
    button.setFont UIFont.fontWithName('Helvetica Neue', size: 48)
    button.setContentHorizontalAlignment UIControlContentHorizontalAlignmentLeft
    button.setShowsTouchWhenHighlighted true
    button_height = UIScreen.mainScreen.bounds.size.height/3
    button.frame = [[0, button_height*index], [UIScreen.mainScreen.bounds.size.width, button_height]]
    button.addTarget(self, action: "#{action}:", forControlEvents: UIControlEventTouchUpInside)
    button
  end

end
