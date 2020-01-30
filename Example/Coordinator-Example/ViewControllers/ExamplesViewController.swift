//  ExamplesViewController.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol ExamplesViewControllerDelegate: class {
    func examplesViewControllerDidTapPresentViewController(_ controller: ExamplesViewController)
    func examplesViewControllerDidTapPresentCoordinator(_ controller: ExamplesViewController)
    func examplesViewControllerDidTapPushCoordinator(_ controller: ExamplesViewController)
}

// MARK: - View Controller

final class ExamplesViewController: UIViewController {
    
    weak var delegate: ExamplesViewControllerDelegate?

    // MARK: - UI Elements
    
    private let presentableCoordinatorLabel = UILabel {
        $0.text = "PresentationCoordinator"
    }
    
    private let navigationCoordinatorLabel = UILabel {
        $0.text = "NavigationCoordinator"
    }
    
    private let presentViewControllerButton = UIButton(type: .system).applying {
        $0.setTitle("Present a ViewController", for: .normal)
        $0.addTarget(self, action: #selector(onPresentViewControllerTapped), for: .touchUpInside)
    }
    
    private let presentCoordinatorButton = UIButton(type: .system).applying {
        $0.setTitle("Present a Coordinator", for: .normal)
        $0.addTarget(self, action: #selector(onPresentCoordinatorTapped), for: .touchUpInside)
    }
    
    private let pushCoordinatorButton = UIButton(type: .system).applying {
        $0.setTitle("Push a Coordinator", for: .normal)
        $0.addTarget(self, action: #selector(onPushCoordinatorTapped), for: .touchUpInside)
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
}

// MARK: - Configuration

private extension ExamplesViewController {
    
    func configureUI() {
        title = "Examples"
        
        view.backgroundColor = .white

        [presentableCoordinatorLabel, navigationCoordinatorLabel].forEach {
            $0.setDefaultStyle(size: .paragraph, weight: .bold)
        }
        
        [presentViewControllerButton, presentCoordinatorButton, pushCoordinatorButton].forEach {
            $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .regular)
        }
        
        let stackView = UIStackView(arrangedSubviews: [presentableCoordinatorLabel,
                                                       presentViewControllerButton,
                                                       presentCoordinatorButton,
                                                       navigationCoordinatorLabel,
                                                       pushCoordinatorButton])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(stackView, constraints: [stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                                 stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)])
    }

}

// MARK: - Action

private extension ExamplesViewController {
    
    @objc func onPresentViewControllerTapped() {
        delegate?.examplesViewControllerDidTapPresentViewController(self)
    }
    
    @objc func onPresentCoordinatorTapped() {
        delegate?.examplesViewControllerDidTapPresentCoordinator(self)
    }

    @objc func onPushCoordinatorTapped() {
        delegate?.examplesViewControllerDidTapPushCoordinator(self)
    }
    
}
