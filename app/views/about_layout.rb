class AboutLayout < MK::Layout

  def layout
    root :main do
      @back_web_view = add UIWebView, :back_web_view do
        backgroundColor = UIColor.clearColor
        sf_bridge = "https://31.media.tumblr.com/442a2e4ae3f16f06fdaf5a0a22740e4f/tumblr_n0qr99E4RE1qh588ko1_500.gif"
        fly_over = "http://gifs.com/A0t"
        loadRequest sf_bridge.nsurl.nsurlrequest
        userInteractionEnabled true
        scalesPageToFit true
        frame [[0, 0], ['100%', '100%']]
      end
    end
  end
  

  def main_style
    background_color "#acacac".uicolor
  end

  def will_appear
    # just before the view appears
  end

  def on_appear
    # just after the view appears
    
  end

  def will_disappear
    # just before the view disappears
  end

  def on_disappear
    # just after the view disappears
  end
end