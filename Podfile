# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

target 'MelodyMusic' do
  use_frameworks!
  
  #https://github.com/youngsoft/TangramKit
  pod 'TangramKit'
  
  #https://github.com/mac-cain13/R.swift
  pod 'R.swift'
  
  #https://github.com/yannickl/DynamicColor
  pod "DynamicColor"
  
  #https:https://github.com/QMUI/QMUIDemo_iOS
  #https://qmuiteam.com/ios/get-started
  pod "QMUIKit"
  
  #https://github.com/SDWebImage/SDWebImage
  pod 'SDWebImage'
  
#  #https:https://github.com/Moya/Moya
#  pod 'Moya'
  
  # https:https://github.com/Moya/Moya
  pod 'Moya/RxSwift'

  #https:https://github.com/RxSwiftCommunity/NSObject-Rx
  pod "NSObject+Rx"


  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
                 end
            end
     end
  end
  
end
