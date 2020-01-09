#
# Be sure to run `pod lib lint Teller.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DNCoordinator'
  s.version          = '0.1.0'
  s.summary          = "An iOS navigation coordinator written in Swift"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  There are a lot of implementations floating around the iOS community of using Coordinators to remove the burden of navigation from UIViewControllers. The Coordinator pattern is so broad, however, that there a lot of different interpretions of how to implement it.

  This is my own take on the Coordinator pattern.
                       DESC

  s.homepage         = 'https://github.com/daveneff/Coordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dave Neff' => 'https://github.com/daveneff' }
  s.source           = { :git => 'https://github.com/daveneff/Coordinator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'Source/**/*'
  
  # s.resource_bundles = {
  #   'Teller' => ['Teller/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end