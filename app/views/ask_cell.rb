class AskCell < UICollectionViewCell 
  include AppStyles
  
  attr_reader :reused
  attr_accessor :image_view
  
  def label_string=(string)
    @label.text = string unless @label.text == string      
  end
  
  def initWithFrame(frame)
    super.tap do
      @image_view = UIImageView.alloc.initWithFrame(self.contentView.bounds).tap do |image_view|
        image_view.image = "placeholder.png".uiimage
        image_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
        self.contentView.addSubview( image_view )
      end
      
      label_frame = CGRectMake(0, @image_view.size.height-70, @image_view.size.width-5, 80)
      @label = UILabel.alloc.initWithFrame(label_frame).tap do |label|
        #label.font = UIFont.fontWithName("Inconsolata", size:9)
        label.font = UIFont.fontWithName("Lato-bold", size:7)
        label.lineBreakMode = UILineBreakModeWordWrap
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignmentRight # NSTextAlignmentNatural NSTextAlignmentLeft
        label.textColor = "#ffffff".uicolor(0.5)
        label.backgroundColor = UIColor.clearColor
        self.contentView.addSubview(label)
      end
    end
  end

  def prepareForReuse
    @reused = true
  end

  def update(params)
    if url = params[:url]
      @image.url = url
    end
  end

end
