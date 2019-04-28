//  ExamplesCoordinator.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Coordinator

final class ExamplesCoordinator: CoordinatorNavigable {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let dataService = DataService.shared
    private let examplesViewController: ExamplesViewController
    
    init() {
        let examplesViewController = ExamplesViewController()
        self.examplesViewController = examplesViewController
        
        let navigationController = UINavigationController(rootViewController: examplesViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        examplesViewController.delegate = self
    }
    
}

// MARK: - Examples View Controller Delegate

extension ExamplesCoordinator: ExamplesViewControllerDelegate {
    
    func examplesViewControllerDidTapPresentViewController(_ controller: ExamplesViewController) {
        let title = dataService.fetchViewControllerViewedCount() == 0 ? "First View" : "View #\(dataService.fetchViewControllerViewedCount() + 1)"
        let textAndButtonController = TextAndButtonViewController(title: title,
                                                                  description: "A Coordinator mediates between different services, then tells the ViewController how to render.\n\nFor example, in this context, this ViewController shows how many times you've viewed it (above). The Coordinator is in responsible for grabbing that from the DataService, preparing it, then passing it to the ViewController.\n\nThat makes this ViewController a lot more \"dumb\", and a lot more flexible.",
                                                                  buttonTitle: "What Else Does It Do?")
        textAndButtonController.delegate = self
        examplesViewController.present(textAndButtonController, animated: true)
        
        let newViewCount = dataService.fetchViewControllerViewedCount() + 1
        dataService.set(viewControllerViewedCount: newViewCount)
    }
    
    func examplesViewControllerDidTapPresentCoordinator(_ controller: ExamplesViewController) {
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.delegate = self
        presentCoordinator(onboardingCoordinator, animated: true)
    }
    
    func examplesViewControllerDidTapPushCoordinator(_ controller: ExamplesViewController) {
        let coordinator = AboutCoordinator(navigator: navigator)
        pushCoordinator(coordinator, animated: true)
    }
    
}

// MARK: - Text And Button View Controller Delegate

extension ExamplesCoordinator: TextAndButtonViewControllerDelegate {
    
    func textAndButtonViewControllerDidTapButton(_ controller: TextAndButtonViewController) {
        controller.showAlert(title: "A Lot!",
                             message: "Not only does a Coordinator mediate between different services, it also handles conditional navigation.\n\nLike right now, I'd rather  show this alert rather than dismiss or push a new ViewController.\n\nPulling that code into the Coordinator makes it really easy to modify navigation routes as requirements change.",
                             actionTitle: "Gotcha",
                             handler: {
                                controller.dismiss(animated: true)
        })
    }
    
}

// MARK: - Onboarding Coordinator Delegate

extension ExamplesCoordinator: OnboardingCoordinatorDelegate {
    
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator) {
        dismissCoordinator(coordinator, animated: true)
    }

}
