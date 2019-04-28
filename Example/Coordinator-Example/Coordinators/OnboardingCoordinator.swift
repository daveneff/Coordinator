//  OnboardingCoordinator.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator)
}

// MARK: - Coordinator

/** A Coordinator which takes a user through the first-time user / onboarding flow. */

final class OnboardingCoordinator: CoordinatorNavigable {
    
    weak var delegate: OnboardingCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let textAndButtonViewController: TextAndButtonViewController
    
    init() {
        let initialViewController = TextAndButtonViewController(title: "Yo!",
                                                                description: "Welcome to the Onboarding Flow of this example project.\n\nCoordinators make it really easy to handle conditional routing like this.",
                                                                buttonTitle: "Cool")
        self.textAndButtonViewController = initialViewController
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        textAndButtonViewController.delegate = self
    }
    
}

// MARK: - Text and Button View Controller Delegate

extension OnboardingCoordinator: TextAndButtonViewControllerDelegate {
    
    func textAndButtonViewControllerDidTapButton(_ controller: TextAndButtonViewController) {
        let summaryViewController = SummaryViewController()
        summaryViewController.delegate = self
        navigator.push(summaryViewController, animated: true)
    }
        
}

// MARK: - Summary View Controller Delegate

extension OnboardingCoordinator: SummaryViewControllerDelegate {
    
    func summaryViewControllerDidTapButton(_ controller: SummaryViewController) {
        delegate?.onboardingCoordinatorDidFinish(self)
    }
    
}
