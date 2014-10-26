class AskViewController <  UIViewController
  attr_accessor :delegate
  attr_accessor :image_picker, :image_view, :ask_create_view
  
  def viewDidLoad
    super
    #self.title = "Loan Request"
    @ask_create_view = AskCreateView.new(view)
    #@ask_create_view.target = self
    @ask_create_view.delegate = self
    @photo_height = Device.screen.height/2.5
    view.addSubview @ask_create_view
    
    image_frame =CGRectMake(0,Device.screen.height-@photo_height, Device.screen.width, @photo_height)
    @image_view = UIImageView.alloc.initWithFrame(image_frame)
    @image_view.image = "approval_responses5.png".uiimage
    view.addSubview @image_view
    
    add_picture_button
    
  end
  
  def add_picture_button
    MotionAwesome.button( :camera, size: 40, text:%q{} ) do |button|
      button.titleLabel.textColor = "#b6b6b6".uicolor(0.7)
      button.titleLabel.font      = UIFont.fontWithName( 'Helvetica Neue', size:68 )
      button.frame = CGRectMake((Device.screen.width/2)-40,Device.screen.height-200,80,80)
      button.setShowsTouchWhenHighlighted true
      button.addTarget( self,action: "take_picture:",
                        forControlEvents: UIControlEventTouchDown )
      view.addSubview( button )
    end
  end
  
  

  def set_borrower(borrower)
    @borrower = borrower
    #self.title = borrower[:username]
    NSLog("AskView.set_borrower #{borrower}")
  end

  def set_ask_type(ask_type)
    @ask_type = ask_type
    #self.childViewControllers.last.set_ask_type(ask_type)
    #self.title = ask_type
    NSLog("AskView.set_borrower #{ask_type}")
  end
    
  def more_time(sender)
    NSLog("AskView.more_time clicked")
  end

  def more_money(sender)
    NSLog("AskView.more_money clicked")
  end

  def send_request(sender)
    NSLog("AskView.send_request clicked sender=#{sender}")
  end

  def take_picture(sender)
    unless UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)
      alert = UIAlertView.alloc.initWithTitle('Error',
                                              message: 'Camera Unavailable',
                                             delegate: self,
                                    cancelButtonTitle: 'Cancel',
                                    otherButtonTitles: nil)
      alert.show

      return
    end

    unless image_picker
      self.image_picker = UIImagePickerController.alloc.init.tap do |picker|
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceTypeCamera
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceTypeCamera)
        picker.allowsEditing = true
        picker.showsCameraControls = false
        picker.cameraOverlayView = overlay_for_image_picker(image_picker)
      end
    end
    image_picker.sourceType = UIImagePickerControllerSourceTypeCamera
    presentViewController(image_picker, animated: true, completion: nil)
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    image = info[UIImagePickerControllerOriginalImage]
    NSLog("AskView.finishedPickingMedia image=#{image}")
    begin
      UIImageWriteToSavedPhotosAlbum(image, nil, nil , nil)
    rescue Exception => e
      NSLog("Error writing to photos e=#{e}")
    end

    image_view.image = image
    image_view.contentMode = UIViewContentModeScaleAspectFill

    dismissViewControllerAnimated(true, completion: nil)
  end

  def imagePickerControllerDidCancel(picker)
    dismissViewControllerAnimated(true, completion: nil)
  end

  def overlay_for_image_picker(image_picker)
    UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |overlay|
      overlay.backgroundColor = UIColor.clearColor

      top  = Device.screen.height_for_orientation(:portrait) - 100
      left = Device.screen.width_for_orientation(:portrait) 

      frame = CGRectMake(5, 10, 120, 44)
      button = build_button(frame,:flash, "flash")
      button.addTarget( self,action: 'toggle_flash:', forControlEvents: UIControlEventTouchDown )
      overlay.addSubview(button)

      frame = CGRectMake(left - 170, 10, 160, 44)
      button = build_button(frame, :camera, "Front")
      button.addTarget( self,action: 'toggle_camera:', forControlEvents: UIControlEventTouchDown )
      overlay.addSubview(button)

      frame = CGRectMake((left / 2) - 60, top, 120, 64)
      button = build_button(frame, :circle_o, "Click!")
      button.addTarget( image_picker,action: 'takePicture:', forControlEvents: UIControlEventTouchDown )
      overlay.addSubview(button)
      
    end
  end
  
  def build_button(frame, glyph, text="")
    # frame = CGRectMake(x, y, width, height)
    MotionAwesome.button( glyph, size: 40, text:text ) do |button|
      button.titleLabel.textColor = "#b6b6b6".uicolor(0.7)
      button.titleLabel.font      = UIFont.fontWithName( 'Helvetica Neue', size:24 )
      button.frame = frame
      button.setShowsTouchWhenHighlighted true
      button
    end
  end
  
  def toggle_flash(sender)
    if flash_mode_off?
      image_picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn
      sender.setTitle('Flash On', forState: UIControlStateNormal)
    else
      image_picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff
      sender.setTitle('Flash Off', forState: UIControlStateNormal)
    end
  end

  def toggle_camera(sender)
    if using_rear_camera?
      image_picker.cameraDevice = UIImagePickerControllerCameraDeviceFront
      sender.setTitle('Front', forState: UIControlStateNormal)
    else
      image_picker.cameraDevice = UIImagePickerControllerCameraDeviceRear
      sender.setTitle('Rear', forState: UIControlStateNormal)
    end
  end

  def toggle_photos(sender)
    if using_photos?
      image_picker.sourceType = UIImagePickerControllerSourceTypeCamera
    elsif using_camera?
      image_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary
    else
      image_picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum
    end
  end
  
  def using_photos?
    image_picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary
  end

  def using_camera?
    image_picker.sourceType == UIImagePickerControllerSourceTypeCamera
  end  
  
  def using_rear_camera?
    image_picker.cameraDevice == UIImagePickerControllerCameraDeviceRear
  end

  def flash_mode_off?
    image_picker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff
  end

end
