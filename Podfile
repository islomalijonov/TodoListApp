# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TodoListApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Moya', '~> 13.0'
  pod 'JGProgressHUD', '~> 2.1'
  pod 'SnapKit'
  pod 'SwiftMessages'
  pod 'IQKeyboardManagerSwift'
  pod 'RxSwift', '6.2.0'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
