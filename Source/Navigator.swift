//  Navigator.swift
//  Created by Dave Neff.
// 
//  👋 Navigator borrows heavily from the Router in Ian MacCallum's CoordinatorKit:
//  👉 https://github.com/imaccallum/CoordinatorKit

import UIKit

// *******************************
// MARK: - NavigatorType
// *******************************

///  Defines a proxy for a `UINavigationController`, providing a
///  a completion handler for when controllers are popped from the stack.
///
///  For a concrete instance, use a `Navigator`.

public protocol NavigatorType {
    
    /** Pops all the view controllers on the stack except the root view controller and updates the display. */
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]?

    /** Pops view controllers until the specified view controller is at the top of the navigation stack. */
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    
    /** Pops the top view controller from the navigation stack and updates the display. */
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    
    /** Pushes a view controller onto the receiver’s stack and updates the display. */
    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)?)
    
    /** Replaces all the view controllers currently managed by the navigation controller a new root view controller. */
    func setRootViewController(_ viewController: UIViewController, animated: Bool)

}

public extension NavigatorType {

    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, onPoppedCompletion: nil)
    }

}

// *******************************
// MARK: - Navigator
// *******************************

///  `Navigator` is a proxy object for a `UINavigationController`.
///  Unlike a regular `UINavigationController`, however, it provide a completion handler
///  for when its `UIViewContoller`s are popped from the navigation stack.

public final class Navigator: NSObject, NavigatorType {

    private let navigationController: UINavigationController
    private var completions: [UIViewController: () -> Void]
    
    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        
        super.init()
        
        self.navigationController.delegate = self
    }
    
}

// MARK: - Navigation methods

public extension Navigator {
    
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToRootViewController(animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToViewController(viewController, animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }
    
    func popViewController(animated: Bool) -> UIViewController? {
        if let poppedController = navigationController.popViewController(animated: animated) {
            runCompletion(for: poppedController)
            return poppedController
        }
        return nil
    }

    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)? = nil) {
        if let completion = onPoppedCompletion {
            completions[viewController] = completion
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }

    func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        completions.forEach { $0.value() }      // call completions so all view controllers are deallocated
        completions = [:]
        navigationController.setViewControllers([viewController], animated: animated)
    }

}

// MARK: - UINavigationControllerDelegate

extension Navigator: UINavigationControllerDelegate {
    
    // Runs completion handler when a user swipes-to-go-back or taps the back button in the navigation bar.
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let poppingViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),    // ensure the view controller is popping
            !navigationController.viewControllers.contains(poppingViewController) else {
                return
        }
        
        runCompletion(for: poppingViewController)
    }
    
}

// MARK: - Helpers

private extension Navigator {
    
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
