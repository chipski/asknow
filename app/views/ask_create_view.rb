class AskCreateView < UIView

  attr_accessor :target
  attr_accessor :delegate
  
  def initialize(parent_view)
    initWithFrame(parent_view.bounds).tap do
      self.backgroundColor = :clear.uicolor # "#2e344a".uicolor

      top_action_view = UIImageView.alloc.initWithFrame(CGRectMake(0,0, UIScreen.mainScreen.bounds.size.width, 200))
      top_action_view.image = "approval_responses.png".uiimage
      addSubview top_action_view

      addSubview(build_button("Request More Money", "more_money:", "#FE642E", 0))
      addSubview(build_button("Request More Time", "more_time:", "#642EFE", 1))
      addSubview(build_button("Request Call Now", "call_now:", "#04B404", 2))

    end
  end
  
  
  def build_button(title, action, backcolor="#b6b6b6", index=0)
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.titleLabel.textAlignment = NSTextAlignmentCenter
    button.setContentHorizontalAlignment UIControlContentHorizontalAlignmentCenter
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping
    button.setTitle(title, forState: UIControlStateNormal)
    button.setTitleColor "#ccc".uicolor, forState: UIControlStateNormal
    button.setTitleColor :white.uicolor, forState: UIControlStateHighlighted
    button.setFont UIFont.fontWithName('Helvetica Neue', size: 32)
    button.setTintColor  backcolor.uicolor
    button.backgroundColor = backcolor.uicolor
    button.setShowsTouchWhenHighlighted true
    button_height = 64
    button_top = (UIScreen.mainScreen.bounds.size.height-(button_height*3))
    button.frame = [[0, (button_height*index)+button_top], [UIScreen.mainScreen.bounds.size.width, button_height]]
    button.addTarget(target, action: action, forControlEvents: UIControlEventTouchUpInside)
    NSLog("AskTypeView.build_button action=#{action}")
    button
  end


end