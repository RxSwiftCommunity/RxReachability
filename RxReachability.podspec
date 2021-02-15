#
# Be sure to run `pod lib lint RxReachability.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

require 'cocoapods'

# This class helps not break older versions of cocoapods users
# while supporting features of newer clients
# If someone knows how to create ruby gems, please make this a gem!
class PodHelper
  @pod_version = Gem::Version.new(Pod::VERSION)
  @version_1_7_0 = Gem::Version.new('1.7.0')
  @version_1_8_0 = Gem::Version.new('1.8a')
  @at_least_1_8 = (@pod_version <=> @version_1_8_0).positive?
  @at_least_1_7 = (@pod_version <=> @version_1_7_0).positive?

  @using_bundler = ENV['BUNDLER_VERSION'].present? || false

  attr_reader :use_binaries, :at_least_1_7, :at_least_1_8

  def initialize(use_binaries)
    # Instance variables
  end

  def self.supports_project_name
    @at_least_1_8
  end

  def self.supports_test_spec
    @at_least_1_7
  end

  def self.supports_app_spec
    @at_least_1_8
  end

  def self.supports_info_plist
    @at_least_1_8
  end

  def self.print_versions
    puts "pod_version: #{@pod_version} at_least_1_8: #{@at_least_1_8} at_least_1_7: #{@at_least_1_7}  supports_project_name #{@supports_project_name}"
  end

  def self.precheck
    return if @using_bundler

    puts "\nPlease re-run using:".red
    puts "  bundle exec pod install\n\n".green
    exit(1)
  end
end


Pod::Spec.new do |s|
  s.name             = 'RxReachability'
  s.version          = '1.2.0'
  s.summary          = 'RxSwift bindings for Reachability'

  s.description      = <<-DESC
  RxReachability adds easy to use RxSwift bindings for [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift).
  You can react to network reachability changes and even retry observables when network comes back up.
                        DESC

  s.homepage          = 'https://github.com/RxSwiftCommunity/RxReachability'
  s.license           = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 
                        'Joseph Mattiello'  => 'git@joemattiello.com',
                        'Ivan Bruel'        => 'ivan.bruel@gmail.com',
                        'Bruno Oliveira'    => 'bm.oliveira.dev@gmail.com',
                        'Joe Mattiello'    => 'git@joemattiello.com',
                        'RxSwiftCommunity'  => 'https://github.com/RxSwiftCommunity' 
                      }

  s.source            = { :git => 'https://github.com/RxSwiftCommunity/RxReachability.git', :tag => s.version.to_s }
  s.social_media_url  = 'https://rxswift.slack.com'
  s.source_files      = 'Sources/RxReachability/**/*'
  
  s.ios.deployment_target   = '10.0'
  s.osx.deployment_target   = '10.10'
  s.tvos.deployment_target  = '10.0'

  s.swift_version    = '5.2'

  s.dependency 'ReachabilitySwift', '>= 5.0', '< 6.0'
  s.dependency 'RxSwift', '~> 6'
  s.dependency 'RxCocoa', '~> 6'

  if PodHelper.supports_app_spec
    s.app_spec 'RxReachabilityExample' do |app_spec|
      app_spec.osx.deployment_target  = '10.10'
      app_spec.ios.deployment_target  = '8.0'
      app_spec.tvos.deployment_target = '10.0'
  
      app_spec.dependency 'ReachabilitySwift', '>= 5.0', '< 6.0'
      app_spec.dependency 'RxSwift', '~> 6'
      app_spec.dependency 'RxCocoa', '~> 6'

      app_spec.source_files = "RxReachability-Example/RxReachability/**/*.swift"

      app_spec.resources = [
        'RxReachability-Example/RxReachability' + '**/*.{xib,storyboard,js,otf,lproj,xcassets}',
      ]

      app_spec.pod_target_xcconfig = {
        'PRODUCT_MODULE_NAME' => 'RxReachabilityExample',
        'PRODUCT_BUNDLE_IDENTIFIER' => 'org.cocoapods.demo.RxReachability',
        'PRODUCT_NAME' => 'RxReachabilityExample',
      }
  
        app_spec.info_plist = {
          'UISupportedInterfaceOrientations' => %w[
            UIInterfaceOrientationPortrait
          ],
          'NSAppTransportSecurity' => {
            'NSAllowsArbitraryLoads' => true
          },
          'UILaunchStoryboardName' => 'LaunchScreen',
        }
      end
    end

  if PodHelper.supports_test_spec
    s.test_spec 'RxReachabilityTests' do |test_spec|
      test_spec.requires_app_host = false
      test_spec.osx.deployment_target  = '10.10'
      test_spec.ios.deployment_target  = '8.0'
      test_spec.tvos.deployment_target = '10.0'
  
      test_spec.source_files = "Tests/**/*.swift"
      test_spec.exclude_files = "Tests/LinuxMain.swift"

      test_spec.dependency 'ReachabilitySwift', '>= 5.0', '< 6.0'
      test_spec.dependency 'RxSwift', '~> 6'
      test_spec.dependency 'RxBlocking'

      if PodHelper.supports_info_plist
        test_spec.requires_app_host = false
        test_spec.test_type = :unit
      end

      test_spec.scheme = {
        :launch_arguments => %w[XCTest],
        :environment_variables => { 'XCTest' => 'true' }
      }
    end
  end
end
