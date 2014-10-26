class AskListController < UICollectionViewController
  include NavHelpers
  include AppStyles
  
  attr_accessor :asks, :query, :has_nav

  ASK_CELL_ID = "AskCell"
  CELL_WIDTH = 320

  # UICollectionViewController:  brings your models and views together, just like UITableViewController
  # UICollectionViewLayout: determines the placement of cells, supplementary views, and decoration views inside the collection view
  # UICollectionViewLayoutAttributes: manages the attributes for your collections views [here is where you can animate it, do things like overflow effect]
  # UICollectionViewCell: the cell is just a view

  def loadView
    super
  end

  def viewDidLoad
    super
    self.title = "Open Loan Requests"

    NSNotificationCenter.defaultCenter.addObserver(self,
      selector:'asks_fetched:',
      name: ActiveAsks::ASKS_FETCHED,
      object:nil)
      
    @query     = {q: "" }
    @query_url ="collection"
    @data_service = ActiveAsks.new
    @asks = @data_service.get_open_asks(@query)

    collectionView.tap do |cv|
      cv.registerClass(AskCell, forCellWithReuseIdentifier: ASK_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
    end
    
    collectionView.collectionViewLayout.tap do |layout|
      # layout.item_width = CELL_WIDTH
      # layout.column_count = self.collectionView.bounds.size.width / CELL_WIDTH
      #layout.section_inset = UIEdgeInsets.new(2, 2, 2, 2)
      #layout.section_inset = UIEdgeInsets.new
      #layout.delegate = self
    end
    add_main_button
    self.view.backgroundColor = nav_back_color
    @refreshControl = UIRefreshControl.alloc.init
    @refreshControl.tintColor = nav_back_color
    @refreshControl.addTarget self, action: :reload, forControlEvents:UIControlEventValueChanged
    self.collectionView.addSubview @refreshControl
    self.collectionView.alwaysBounceVertical = true
  end

  def reload
    @asks = @data_service.get_open_asks( @query)
  end
  
  def asks_fetched(notification)
    @asks = @data_service.asks
    collectionView.reloadData
    #@refreshControl.endRefreshing
  end


  def numberOfSectionsInCollectionView(view)
    1
  end
 
  def collectionView(view, numberOfItemsInSection: section)
    @asks.count
  end
    
  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(ASK_CELL_ID, forIndexPath: index_path).tap do |cell|
      if @asks[index_path.row]
        ask_info = @asks[index_path.row]
        NSLog("AskListView.loadcell ask_info= #{ask_info.inspect}")
        @placeholder ||= "placeholder.png".uiimage
        image_view = UIImageView.alloc.initWithFrame(cell.bounds)
        image_view = cell.image_view
        #image_view.setImageWithURL(img_url.nsurl, placeholderImage: @placeholder)
        #NSLog("AskListView.loadcell ask_type=#{@ask_info.ask_type} message=#{@ask_info.message}")
        #cell.image_view.image = image_view.image
      
        cell.label_string= ask_info.label_text
      end
    end
  end
  
  def collectionView(view, layout:layout, heightForItemAtIndexPath:path)
    # asks[path.item].size.height this could be done here with asks
    (layout.item_width * @asks[path.row]["height"]) / @asks[path.row]["width"]
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    NSLog("Selected at section: #{index_path.section}, row: #{index_path.row}")
    ask_popup(@asks[index_path.row])
    
  end

  def ask_popup(image_info)
    NSLog "AskList.ask_popup tapped"
    img_url = image_info['img_url']
    width   = image_info['width']
    height  = image_info['height']
    picture_frame = CGRectMake(0,0, width, height)
    
    back_controller = BackgroundController.alloc.init
    self.addChildViewController(back_controller)
    self.view.addSubview back_controller.view
    
    self.parentViewController.navigationBarHidden = true
    self.addChildViewController(image_controller)
    self.view.addSubview image_controller.view
    NSLog "AskList.ask_popup loaded"
    add_popup_buttons
    image_controller.add_share_buttons(image_info['name'])
  end
  
  def close_popup
    self.childViewControllers.each {|cont| cont.view.removeFromSuperview}
    NSLog "AskList.close_popup tapped"
    add_main_button
    self.parentViewController.navigationBarHidden = false
  end
  
  def save_to_photos
    NSLog "AskList.save_to_photos tapped"
    popup_controller = self.childViewControllers.last
    offset = popup_controller.scroll_view.contentOffset
    content_size  = popup_controller.scroll_view.contentSize
    NSLog("AskList.save_to_photos offset=#{offset.x} y=#{offset.x} content_size=#{content_size.width} height=#{content_size.height}")
    popup_image_controller = popup_controller.image_view
    popup_image_controller.frame = CGRectMake(0,0, content_size.width, content_size.height)
    #popup_image_controller.frame = CGRectMake(offset.x, offset.y, content_size.width, content_size.height)
    popup_image_controller.clipsToBounds = true
    popup_image = popup_image_controller.image
    NSLog("AskList.save_to_photos popup_image=#{popup_image}")
    UIImageWriteToSavedPhotosAlbum(popup_image, self, nil, nil) #"didWriteToSavedPhotosAlbum"    
  end
  
  def didWriteToSavedPhotosAlbum(sender)
    NSLog "AskList.didWriteToSavedPhotosAlbum called"
  end
  
  def set_image_with_url(controller, image_url, placeholder, frame)
    image_view = UIImageView.alloc.initWithFrame(frame)  #CGRectZero
    completed_block = Proc.new do |request, response, image|
      controller.set_image image
    end
    placeholder = UIImage.imageNamed placeholder
    controller.set_image placeholder
    image_view.setImageWithURLRequest(image_url.nsurl.nsurlrequest, placeholderImage: placeholder, success: completed_block, failure: nil)
  end
  
  def image_popup(image_info)
    NSLog "AskList.image_popup tapped"
    img_url = image_info['img_url']
    width   = image_info['width']
    height  = image_info['height']
    left = (width - UIScreen.mainScreen.bounds.size.width) / 2
    top =  (height - UIScreen.mainScreen.bounds.size.height) / 2
    NSLog("AskList.image_popup left=#{left} width=#{width} top=#{top}  height=#{height}")
    picture_frame = CGRectMake((left > 0) ? -left : 0, ((top > 0) ? -top : 0), width, height)
    #picture_frame = CGRectMake(0,0, width, height)

    @picture_view ||= UIImageView.alloc.initWithFrame(picture_frame)
    @picture_view.setImageWithURL(img_url.nsurl)
    
    @modal_view ||= UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.bounds) 
    @modal_view = ImageZoom.alloc.init
    
    @modal_view.delegate = self
    @modal_view.alpha = 1.0  # hide the view
    # UIControlEventTouchDragEnter UIControlEventTouchDragExit UIControlEventTouchDown
    #@modal_view.addTarget self, action: :close_popup, forControlEvents:UIControlEventTouchDown
    @modal_view.userInteractionEnabled = true    
    
    @modal_view.minimumZoomScale = 0.25 # @modal_view.frame.size.width / @picture_view.frame.size.width
    #@modal_view.zoomScale        = 0.1
    @modal_view.maximumZoomScale = 10.0    
    @modal_view.pagingEnabled = true
    @modal_view.scrollEnabled = true
    @modal_view.contentSize = @picture_view.size
    @modal_view.addSubview @picture_view
    
    self.view.addSubview @modal_view
    NSLog "AskList.image_popup loaded"
  end
  
  def viewForZoomingInScrollView(scroll_view)
    #super
    NSLog("AskList.viewForZoomingInScrollView loaded")
  end
  
  def scrollViewDidEndZooming(scroll_view, withView:picture_view, atScale: scale)
    NSLog("AskList.scrollViewDidEndZooming loaded")
  end
  

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape
  end
  
  def didRotateFromInterfaceOrientation(orientation)
    self.collectionView.collectionViewLayout.tap do |layout|
      is_landscape = (orientation == UIDeviceOrientationLandscapeRight) || (orientation == UIDeviceOrientationLandscapeLeft)
      
      layout.column_count = is_landscape ? 3 : 2
      layout.item_width   = self.collectionView.bounds.size.width / layout.column_count
 
    end
  end
  
end
