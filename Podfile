source 'https://cdn.cocoapods.org/'

platform :ios, '14.1'

inhibit_all_warnings!
use_frameworks! :linkage => :static

def pods
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'Cartography', '4.0.0'
  pod 'Kingfisher', '6.3.0'
  pod 'R.swift', '5.4.0'
  pod 'RealmSwift', '10.7.6'
  pod 'RxRealm', '5.0.1'
  pod 'Eureka', '5.3.3'
end

def macOSTools
  pod 'SwiftLint'
end

target 'BreakingBad' do
  pods
  macOSTools
end

post_install do |installer|

  # This fixes Xcode 12 warnings
  puts 'Settings iOS deployment target to iOS 14.1 for all Pods...'
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.1'
    end
  end

end
