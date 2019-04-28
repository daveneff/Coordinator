//  Coordinator.swift
//  Created by Dave Neff.

import UIKit

// *******************************
// MARK: - Coordinator
// *******************************

///  The most basic type of `Coordinator`: one that manages other coordinators.

protocol Coordinator: class {
    
    /** Any child coordinators to keep track of, to prevent them from getting deallocated in memory. */
    var childCoordinators: [Coordinator] { get set }
    
    /** Used for handling startup tasks - think of it as the `viewDidLoad()` of coordinators. */
    func start()
    
}

extension Coordinator {
    
    /**
     Adds a child coordinator to the parent, preventing it from getting deallocated in memory.
     
     - Parameter childCoordinator: The coordinator to keep allocated in memory.
     */
    
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    /**
     Removes a child coordinator from its parent, releasing it from memory.
     
     - Parameter childCoordinator: The coordinator to release.
     */

    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
}

// *******************************
// MARK: - CoordinatorPresentable
// *******************************

///  The underlying protocol for `CoordinatorPresentable`.
///
///  - Important:
///  It's usually best to avoid implementing this protocol directly. It acts as a base protocol
///  for `CoordinatorPresentable` to avoid `associatedtype` compiler errors.

protocol BaseCoordinatorPresentable: Coordinator {
    
    /** The underlying root view controller for `CoordinatorPresentable`. */
    var _rootViewController: UIViewController { get }
    
}

///  A `Coordinator` which also manages a `UIViewController`.

protocol CoordinatorPresentable: BaseCoordinatorPresentable {
    
    associatedtype ViewController: UIViewController
    
    /** The `Coordinator`'s root view controller. */
    var rootViewController: ViewController { get }
    
}

// `BaseCoordinatorPresentable` default implementation

extension CoordinatorPresentable {
    
    /** A computed property which simply returns the `rootViewController`. */
    var _rootViewController: UIViewController { return rootViewController }
    
}

// MARK: - Presentation Methods

extension CoordinatorPresentable {
    
    /**
     Starts a child coordinator and presents its `rootViewController` modally. This method also retains the `childCoordinator` in memory, which needs to be released upon dismissal.
     
     - Parameters:
        - childCoordinator: The coordinator to present and retain.
        - animated: Specify `true` to animate the transition or `false` if you do not want the transition to be animated.
     */
    
    func presentCoordinator(_ childCoordinator: BaseCoordinatorPresentable, animated: Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        rootViewController.present(childCoordinator._rootViewController, animated: animated)
    }
    
    /**
     Dismisses a child coordinator's `rootViewController` which was presented modally, and releases the coordinator from memory.
     
     - Parameters:
        - childCoordinator: The coordinator to dismiss and release.
        - animated: Specify `true` to animate the transition or `false` if you do not want the transition to be animated.
        - completion: The block to execute after the view controller is dismissed.
     */
    
    func dismissCoordinator(_ childCoordinator: BaseCoordinatorPresentable, animated: Bool, completion: (() -> Void)? = nil) {
        childCoordinator._rootViewController.dismiss(animated: animated, completion: completion)
        self.removeChildCoordinator(childCoordinator)
    }

}

// *******************************
// MARK: - CoordinatorNavigable
// *******************************

///  Handles the navigation flow between one or more `UIViewController`s and/or `Coordinator`s, pulling the responsibility of navigation one level above.

protocol CoordinatorNavigable: CoordinatorPresentable {
    
    /** Responsible for the navigation stack between `UIViewController`s. */
    var navigator: NavigatorType { get }
    
}

// MARK: - Navigation Methods

extension CoordinatorNavigable {
    
    /**
     Starts a child coordinator and pushes its `rootViewController` onto the navigation stack.
     This method also manages retaining and releasing the `childCoordinator` in memory.
     
     - Parameters:
        - childCoordinator: The coordinator to push.
        - animated: Specify `true` to animate the transition or `false` if you do not want the transition to be animated.
     */
    
    func pushCoordinator(_ childCoordinator: BaseCoordinatorPresentable, animated: Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        navigator.push(childCoordinator._rootViewController,
                       animated: animated,
                       onPoppedCompletion: { [weak self] in
                        self?.removeChildCoordinator(childCoordinator)
        })
    }
    
}
