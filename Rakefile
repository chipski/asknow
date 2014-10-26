# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
require 'motion-cocoapods'
require 'bubble-wrap/all'
#require 'bubble-wrap/core'
#require 'bubble-wrap/camera'
require 'ParseModel'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'asknow'
  app.deployment_target = "7.0"
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right]
  app.identifier = 'com.approvenow.asknow' 
  app.version = "1"
  app.short_version = "0.1.1"
  app.codesign_certificate = "iPhone Developer: Chip Vanek (9AE6ZEAACG)"
  app.provisioning_profile = "/Users/chip/Library/MobileDevice/Provisioning Profiles/803a1ce3-a5eb-45e1-9a8f-b2109bdba5fc.mobileprovision"
  
  app.development do
    # This entitlement is required during development but must not be used for release.
    app.entitlements['get-task-allow'] = true
    #app.codesign_for_development = true
  end

  app.frameworks += [
    "Accounts",
    'CFNetwork',
    # 'CoreGraphics',
    # 'CoreLocation',
    # 'CoreMotion',
    'MobileCoreServices',
    'QuartzCore',
    'Security',
    # "Social", 
    'SystemConfiguration'
  ]
  app.libs += [
    '/usr/lib/libz.dylib',
    '/usr/lib/libsqlite3.dylib']
  
  app.fonts = ['fontawesome-webfont.ttf']
  app.info_plist['UIStatusBarHidden'] = true
  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
  
  app.vendor_project('vendor/Bolts.framework', :static, :force_load => true, :products => ['Bolts'], :headers_dir => 'Headers')
    
  app.vendor_project('vendor/Parse.framework', :static, :force_load => true, :products => ['Parse'],
    :headers_dir => 'Headers')
      
  app.pods do
    #pod 'AFNetworking'
    #pod 'Reachability' # ,:head
    # pod 'SIAlertView'
    # pod 'SVProgressHUD'
    #pod 'Facebook-iOS-SDK', '~> 3.19'
    #pod 'Parse'  #Parse (1.4.1)  # still not working
  end

end
