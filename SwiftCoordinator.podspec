Pod::Spec.new do |spec|
    spec.name                   = 'SwiftCoordinator'
    spec.version                = '0.1.0'
    spec.summary                = 'An implementation of the Coordinator pattern for iOS written in Swift 5.'
    spec.source                 = { :git => 'https://github.com/daveneff/Coordinator.git', :tag => spec.version }
    spec.license                = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                 = { 'Dave Neff' => 'https://github.com/daveneff' }
    spec.homepage               = 'https://github.com/daveneff/Coordinator'
    spec.swift_version          = '5.0'
    spec.ios.deployment_target  = '10.0'
    spec.source_files           = 'Source/**/*.swift'
    spec.framework              = 'UIKit'
end
