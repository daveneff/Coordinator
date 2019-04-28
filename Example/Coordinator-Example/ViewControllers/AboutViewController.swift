//  AboutViewController.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol AboutViewControllerDelegate: class {
    func aboutViewControllerDidTapReset(_ controller: AboutViewController)
    func aboutViewControlleDidTapViewOnGithub(_ controller: AboutViewController)
    func aboutViewControllerDidTapPopCoordinator(_ controller: AboutViewController)
}

// MARK: - View Controller

final class AboutViewController: UIViewController {
    
    weak var delegate: AboutViewControllerDelegate?
    
    // MARK: - UI Elements
    
    private let titleLabel = UILabel {
        $0.text = "About"
        $0.setDefaultStyle(size: .title, weight: .heavy)
    }
    
    private let paragraphLabel = UILabel {
        $0.text = "Thanks for checking out this example!\n\nI hope it’s helpful if you’re experimenting with or trying to understand Coordinators."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.setDefaultStyle(size: .paragraph, weight: .light)
    }
        
    private let resetButton = UIButton(type: .system).applying {
        $0.setTitle("Reset DataService", for: .normal)
        $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .regular)
        $0.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    private let githubButton = UIButton(type: .system).applying {
        $0.setTitle("View On Github", for: .normal)
        $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .regular)
        $0.addTarget(self, action: #selector(didTapGithubButton), for: .touchUpInside)
    }
    
    private let popButton = UIButton(type: .system).applying {
        $0.setTitle("Pop This Coordinator", for: .normal)
        $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .regular)
        $0.addTarget(self, action: #selector(didTapPopCoordinatorButton), for: .touchUpInside)
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureConstraints()
    }
    
}

// MARK: - Configuration

private extension AboutViewController {
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let padding: CGFloat = 30
        
        view.addSubview(titleLabel, constraints: [titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
                                                  titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        view.addSubview(paragraphLabel, constraints: [paragraphLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                      paragraphLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                                      paragraphLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                                                      paragraphLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        
        let stackView = UIStackView(arrangedSubviews: [resetButton, githubButton, popButton]).applying {
            $0.alignment = .center
            $0.axis = .vertical
            $0.spacing = 10
        }
        view.addSubview(stackView, constraints: [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding)])
    }
    
}

// MARK: - Action

private extension AboutViewController {
    
    @objc private func didTapResetButton() {
        delegate?.aboutViewControllerDidTapReset(self)
    }
    
    @objc private func didTapGithubButton() {
        delegate?.aboutViewControlleDidTapViewOnGithub(self)
    }
    
    @objc private func didTapPopCoordinatorButton() {
        delegate?.aboutViewControllerDidTapPopCoordinator(self)
    }

}
