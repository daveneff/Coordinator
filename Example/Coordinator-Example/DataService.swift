//  DataService.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

/**
 This class mimicks any kind of data service an app might have for the sake of this example.
 In real life, it'd probably be a network service or ore robust persistence layer.
 */

final class DataService {
    
    static let shared = DataService()
    
    private let defaults = UserDefaults.standard
    
    private init() { }
    
}

// MARK: - User State

extension DataService {
    
    private var userStateKey: String { return "FirstTimeUser" }
    
    /// Mocks an asynchronous call to check if this is the first time the user has loaded the app.
    
    func fetchUserState(isFirstTimeUser: @escaping (Bool) -> Void) {
        isFirstTimeUser(defaults.string(forKey: userStateKey) == nil)
    }
    
    /// Saves the user status to the data service.
    
    func set(isFirstTimeUser: Bool) {
        isFirstTimeUser ? defaults.removeObject(forKey: userStateKey) : defaults.set(userStateKey, forKey: userStateKey)
    }

}

// MARK: - View Count

extension DataService {
    
    private var viewCountKey: String { return "ViewCount" }

    /// Returns how many times the ViewController has been viewed.
    
    func fetchViewControllerViewedCount() -> Int {
        return defaults.integer(forKey: viewCountKey)
    }
    
    /// Incremenets and saves how many times the ViewController has been viewed.
    
    func set(viewControllerViewedCount count: Int) {
        defaults.set(count, forKey: viewCountKey)
    }
    
}
