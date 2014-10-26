module AppStyles

  def nav_back_color
    #UIColor.colorWithRed(0.64, green: 0.64, blue: 0.64, alpha: 0.50)
    "#e6e6e6".uicolor(0.3)
  end

  def apply_field_styles
    font UIFont.fontWithName('Helvetica Neue', size: 24)
    text_alignment NSTextAlignmentCenter
    text_color "#313131".uicolor 
    # color "#313131".uicolor 
    # opaque true
    background_color "#F9F9F9".uicolor 
  end
  
  def apply_button_styles
    font UIFont.fontWithName('Helvetica Neue', size: 24)
    title_color "#313131".uicolor 
    
    background_color "#cdcdcd".uicolor 
  end
end
