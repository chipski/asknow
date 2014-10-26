class AskCreateView < UIView

  attr_accessor :target
  attr_accessor :delegate
  
  def initialize(parent_view)
    initWithFrame(parent_view.bounds).tap do
      self.backgroundColor =  "#2e344a".uicolor #:clear.uicolor
                
      set_ask_type("more_money")
      #set_ask_type("extend_time")
      #set_ask_type("call")

      addSubview(build_button("Send Request", "send_request:", "#04B404", 4))
    end
  end
  
  def set_ask_type(ask_type)
    @ask_type = ask_type
    if ask_type == "more_money"
      time_slider(false)
      message_field
      #addSubview(build_button("Send Request", "send_request:", "#04B404", 4))
    elsif ask_type == "extend_time"
      time_slider
      message_field
      #addSubview(build_button("Send Request", "send_request:", "#04B404", 4))
    else
      show_number
    end
    NSLog("AskCreateView.set_ask_type #{ask_type}")
  end
  
  def send_request(sender)
    NSLog("AskCreateView.send_request clicked msg=#{@text_field.text.to_s}")
  end
 
  def show_number
    label = UILabel.alloc.init
    label.frame = [[20, 90], [UIScreen.mainScreen.bounds.size.width-40, 50]]
    label.text = " Call Branch Manager"
    label.font = UIFont.fontWithName('Helvetica Neue', size: 20)
    label.textColor = "#ccc".uicolor
    addSubview label
    #frame = CGRectMake(x, y, width, height)
    frame = CGRectMake(20, 180, Device.screen.width-40, 60)
    button = build_button2(frame, :phone, "Call +22-34-2345-23")
    button.addTarget( self,action: 'toggle_camera:', forControlEvents: UIControlEventTouchDown )
    addSubview(button)
  end
  
  def call_manager
    
  end

  def time_slider(time=true)
    label = UILabel.alloc.init
    label.frame = [[20, 90], [UIScreen.mainScreen.bounds.size.width-40, 30]]
    if time
      label.text = "1  -   Pick number of weeks    - 20"
    else
      label.text = "100  -   Pick loan increase    - 500"
    end
    label.textAlignment = :center.uialignment
    label.textColor = "#ccc".uicolor
    addSubview label
    @time_slider = UISlider.alloc.initWithFrame([[20, (64*2)], [UIScreen.mainScreen.bounds.size.width-40, 30]])
    @time_slider.maximumValue = 20
    @time_slider.value = @time_slider.maximumValue/2
    @time_slider.setMinimumTrackImage "full2.png".uiimage, forState: UIControlStateNormal
    @time_slider.setMaximumTrackImage "empty.png".uiimage, forState: UIControlStateNormal
    addSubview @time_slider
  end
  
  def message_field
    @text_field = UITextField.alloc.initWithFrame [[20, (64*3)], [UIScreen.mainScreen.bounds.size.width-40, 48]]
    @text_field.placeholder = "Message to loan officer"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.font = UIFont.fontWithName('Helvetica Neue', size: 28)
    #@text_field.keyboardType = UIKeyboardTypeEmailAddress
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    addSubview @text_field
  end
  
  def build_button2(frame, glyph, text="")
    # 
    MotionAwesome.button( glyph, size: 40, text:text ) do |button|
      button.titleLabel.textColor = "#b6b6b6".uicolor(0.7)
      button.titleLabel.font      = UIFont.fontWithName( 'Helvetica Neue', size:24 )
      button.frame = frame
      button.setShowsTouchWhenHighlighted true
      button
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
    button_height = (UIScreen.mainScreen.bounds.size.height-44)/3
    button.frame = [[0, (Device.screen.height-Device.screen.height/2.5)-68], [UIScreen.mainScreen.bounds.size.width, 68]]
    button.addTarget(target, action: action, forControlEvents: UIControlEventTouchUpInside)
    NSLog("AskTypeView.build_button action=#{action}")
    button
  end


end