class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    app_frame = UIScreen.mainScreen.bounds
    @window = UIWindow.alloc.initWithFrame(app_frame)
    loadWithParse
    @window.rootViewController = MainController.alloc.init
    splash_view = UIImageView.alloc.initWithImage(UIImage.imageNamed(get_right_splash_image))
    @window.rootViewController.view.addSubview(splash_view)
    @window.rootViewController.view.bringSubviewToFront(splash_view)
    @window.makeKeyAndVisible
    fade_out_timer = 2.0
    UIView.transitionWithView(@window, duration:fade_out_timer, options:UIViewAnimationOptionTransitionNone, animations: lambda {splash_view.alpha = 0}, completion: lambda do |finished|
      splash_view.removeFromSuperview
      splash_view = nil
    end)
    
    
    true
  end
  
  def loadWithParse
    Parse.setApplicationId("5JdX56QbmPvh91zZaQOSXnpK1U0GbJKiv2ouEOOV", 
                          clientKey: "cH5Q6trd7TwPTgyCET0HRUq3VRAbn57RsZoe5U7m")
    #PFFacebookUtils.initializeFacebook
    #PFTwitterUtils.initializeWithConsumerKey("your api key",consumerSecret: "your api secret")
  end
  
  def get_right_splash_image
    case UIScreen.mainScreen.bounds.size.height
    when 568            
      "Default-retina4" # iPhone 4?
    when 667            # iPhone 6
      "Default-667h"
    when 736            # iPhone 6+
      "Default-736h"
    when 568
      "Default-568h"    # iPhone 5
    else
      "Default"
    end
  end
  
  
end
