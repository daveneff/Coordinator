//  AboutCoordinator.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit
import SafariServices

// MARK: - Coordinator

final class AboutCoordinator: NSObject, NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController = AboutViewController()
    
    private let dataService = DataService.shared

    init(navigator: NavigatorType) {
        self.navigator = navigator
    }
    
    func start() {
        rootViewController.delegate = self
    }
    
}

// MARK: - About View Controller Delegate

extension AboutCoordinator: AboutViewControllerDelegate {
    
    func aboutViewControllerDidTapReset(_ controller: AboutViewController) {
        dataService.set(isFirstTimeUser: true)
        dataService.set(viewControllerViewedCount: 0)
        
        controller.showAlert(title: "Success",
                             message: "DataService was reset. If you close and re-open the app, you'll be a first-time user again.",
                             actionTitle: "OK")
    }
    
    func aboutViewControlleDidTapViewOnGithub(_ controller: AboutViewController) {
        guard let url = URL(string: "https://github.com/daveneff/Coordinator") else {
            controller.showAlert(title: "Invalid URL", message: "Sorry, that URL is invalid.", actionTitle: "OK")
            return
        }
        
        let controller = SFSafariViewController(url: url)
        controller.delegate = self
        rootViewController.present(controller, animated: true)
    }
    
    func aboutViewControllerDidTapPopCoordinator(_ controller: AboutViewController) {
        navigator.popViewController(animated: true)
    }
    
}

// MARK: - Safari View Controller Delegate

extension AboutCoordinator: SFSafariViewControllerDelegate {

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }

}
