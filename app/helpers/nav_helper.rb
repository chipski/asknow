module NavHelpers
  
  
  def add_main_button
    frame = CGRectMake(0,0,36,26)
    button = build_nav_button(frame, "icons/burger.png", "icons/burger.png")
    button.addTarget self, action: "switch_to_ask_list", forControlEvents: UIControlEventTouchDown
    barBackItem = UIBarButtonItem.alloc.initWithCustomView button
    #self.navigationItem.hidesBackButton = true
    self.navigationItem.rightBarButtonItem = barBackItem
  end
  
  def build_nav_button(frame, icon_url, click_icon_url)
    # frame = CGRectMake(x, y, width, height)
    button = UIButton.alloc.initWithFrame(frame)
    button.setImage(icon_url.uiimage,       forState: UIControlStateNormal)
    button.setImage(click_icon_url.uiimage, forState: UIControlStateHighlighted)
    button.setShowsTouchWhenHighlighted true
    button
  end

end