//  AppCoordinator.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

/** The application's root `Coordinator`. */

final class AppCoordinator: PresentationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = AppRootViewController()
    
    private let dataService = DataService.shared
    
    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
        dataService.fetchUserState { [weak self] isFirstTimeUser in
            self?.route(isFirstTimeUser: isFirstTimeUser)
        }
    }
    
}

// MARK: - Routing

private extension AppCoordinator {
    
    func route(isFirstTimeUser: Bool) {
        if isFirstTimeUser {
            let onboardingCoordinator = OnboardingCoordinator()
            onboardingCoordinator.delegate = self
            presentCoordinator(onboardingCoordinator, animated: false)
        } else {
            let examplesCoordinator = ExamplesCoordinator()
            addChildCoordinator(examplesCoordinator)
            examplesCoordinator.start()
            rootViewController.set(childViewController: examplesCoordinator.rootViewController)
        }
    }
    
}

// MARK: - Onboarding Coordinator Delegate

extension AppCoordinator: OnboardingCoordinatorDelegate {
    
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator) {
        let isFirstTimeUser = false
        dataService.set(isFirstTimeUser: isFirstTimeUser)
        route(isFirstTimeUser: isFirstTimeUser)
        
        dismissCoordinator(coordinator, animated: true)
    }
    
}
