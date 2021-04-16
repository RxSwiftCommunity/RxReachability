#
# Be sure to run `pod lib lint RxReachability.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxReachability'
  s.version          = '1.2.1'
  s.summary          = 'RxSwift bindings for Reachability'

  s.description      = <<-DESC
  RxReachability adds easy to use RxSwift bindings for [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift).
  You can react to network reachability changes and even retry observables when network comes back up.
                        DESC

  s.homepage          = 'https://github.com/RxSwiftCommunity/RxReachability'
  s.documentation_url = 'https://community.rxswift.org/RxReachability/'
  s.license           = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 
                        'Joseph Mattiello'  => 'git@joemattiello.com',
                        'Ivan Bruel'        => 'ivan.bruel@gmail.com',
                        'Bruno Oliveira'    => 'bm.oliveira.dev@gmail.com',
                        'RxSwiftCommunity'  => 'https://github.com/RxSwiftCommunity' 
                      }
  s.source            = { :git => 'https://github.com/RxSwiftCommunity/RxReachability.git', :tag => s.version.to_s }
  s.social_media_url  = 'https://rxswift.slack.com'
  s.source_files      = 'Sources/RxReachability/**/*'
  
  s.ios.deployment_target   = '11.0'
  s.osx.deployment_target   = '10.10'
  s.tvos.deployment_target  = '11.0'

  s.swift_version    = '5.2'

  s.dependency 'ReachabilitySwift', '>= 5.0', '< 6.0'
  s.dependency 'RxSwift', '~> 6'
  s.dependency 'RxCocoa', '~> 6'

  s.test_spec do |test_spec|
    test_spec.test_type = :unit
    test_spec.requires_app_host = false

    # test_spec.app_host_name = 'RxReachability/RxReachability-Example'
    # test_spec.dependency 'RxReachability/RxReachability-Example'

    test_spec.source_files = 'Tests/RxReachabilityTests/**/*.swift'
    test_spec.dependency 'RxBlocking', '~> 6'
  end

  s.app_spec 'RxReachability-Example' do |app_spec|
    app_spec.source_files = 'RxReachabilityTests-Example/RxReachabilityTests/**/*.swift'
    app_spec.ios.deployment_target = '11.0'
    app_spec.osx.deployment_target = '10.10'
    app_spec.tvos.deployment_target = '11.0'

    app_spec.info_plist = {
      'CFBundleIdentifier' => 'org.cocoapods.demo.RxReachability',
      'UISupportedInterfaceOrientations' => [
        'UIInterfaceOrientationPortrait',
      ],
      'UILaunchStoryboardName' => 'LaunchScreen',
      'UIMainStoryboardFile' => 'Main',
    }
  end
end
