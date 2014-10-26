class UserListController < UITableViewController
  include NavHelpers

  attr_accessor :delegate
  attr_accessor :data, :query
  USER_CELL_ID = "UserCell"
  
  def init
    super
    @query ||= {} 
    self.title = "Borrowers"
    @data_service = ActiveAsks.new
    @data = []
    self
  end

  def viewDidLoad
    super

    NSNotificationCenter.defaultCenter.addObserver(self,
      selector:'users_fetched:',
      name: ActiveAsks::USERS_FETCHED,
      object:nil)

    @data_service ||= ActiveAsks.new
    @data = @data_service.get_users

    self.view.separatorColor = 0xffe8da.uicolor
    self.view.backgroundColor = :white.uicolor
    @refreshControl = UIRefreshControl.alloc.init
    @refreshControl.tintColor = 0xE79E8F.uicolor
    @refreshControl.addTarget self, action: :reload, forControlEvents:UIControlEventValueChanged
    self.refreshControl = @refreshControl
    add_main_button
  end

  def reload
    @data = @data_service.get_users
    @refreshControl.endRefreshing
  end

  def users_fetched(notification)
    @data = @data_service.users
    NSLog("TableView.users_fetched found data size=#{@data.size} \n ^^^^^^^^^^^^^^^^^^^^^^^ \n")
    self.tableView.reloadData
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier = USER_CELL_ID

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:reuseIdentifier)
    end
    # cell data
    NSLog("tableView.cell found indexPath=#{indexPath} #{indexPath.row} #{indexPath.section} ")
    cell_info = @data[indexPath.row]
    NSLog("tableView.cell found cell_info=#{cell_info}  ")
    
    cell.text = "#{cell_info}  included"
    
    cell.textLabel.color = 0x222222.uicolor
    cell.textLabel.backgroundColor = :clear.uicolor
    cell.textLabel.highlightedTextColor = 0xffffff.uicolor
    cell.contentView.backgroundColor = :clear.uicolor

    selectedBackgroundView = UIView.alloc.initWithFrame(cell.frame)
    selectedBackgroundView.backgroundColor = "#ccc".uicolor
    cell.selectedBackgroundView = selectedBackgroundView
    cell
  end
  
  def open_url(sender)
    #url.nsurl.open
  end
  
  def build_button(title, icon_img, url, index=0)
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(title, forState: UIControlStateNormal)
    button.setTitleColor :light_gray.uicolor, forState: UIControlStateNormal
    button.setTitleColor :white.uicolor, forState: UIControlStateHighlighted
    button.setFont UIFont.fontWithName('Helvetica Neue', size: 22)
    button.setContentHorizontalAlignment UIControlContentHorizontalAlignmentLeft
    button.setImage icon_img.uiimage, forState: UIControlStateNormal
    button.setImage icon_img.uiimage.darken, forState: UIControlStateHighlighted
    button.frame = [[(index ? index*95 : 0), 10], [108, 55]]
    button.addTarget(self, action: "open_url:", forControlEvents: UIControlEventTouchUpInside)
    button
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.size
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    switch_to_app(indexPath)
  end

  def switch_to_app(indexPath)
      letter =  @data[indexPath.row]
      NSLog "Tapped #{letter}"
      alert = UIAlertView.alloc.init
      alert.message = "#{letter} tapped!"
      alert.addButtonWithTitle "OK"
      alert.show
  end
  

end

