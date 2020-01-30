//  SummaryViewController.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol SummaryViewControllerDelegate: class {
    func summaryViewControllerDidTapButton(_ controller: SummaryViewController)
}

// MARK: - View Controller

final class SummaryViewController: UIViewController {
    
    weak var delegate: SummaryViewControllerDelegate?
    
    // MARK: - UI Elements
    
    private let headerLabel = UILabel {
        $0.text = "I think of Coordinators in three layers, each of which builds upon the one before:"
    }
    
    private let descriptionLabel = UILabel {
        $0.text = "A Coordinator is the foundation, which simply starts and keeps track of any child coordinators.\n\nPresentationCoordinator can be seen — it owns a UIViewController it’s in charge of handling business and/or presentation logic for.\n\nNavigationCoordinator is used when the coordinator manages, or is part of, a more complex navigation stack."
    }
    
    private let imageView = UIImageView {
        $0.image = UIImage(named: "coordinator")
        $0.contentMode = .scaleAspectFit
    }
    
    private let button = UIButton(type: .system).applying {
        $0.addTarget(nil, action: #selector(didTapButton), for: .touchUpInside)
        $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .semibold)
        $0.setTitle("Right on", for: .normal)
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
    }
    
}

// MARK: - Configuration

private extension SummaryViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        
        let font: UIFont = .systemFont(ofSize: 16.0)
        [headerLabel, descriptionLabel].forEach {
            $0.font = font
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
    }
    
    func configureConstraints() {
        let padding: CGFloat = 20.0
        let safeArea = view.safeAreaLayoutGuide
        
        let scrollView = UIScrollView()
        scrollView.contentSize = view.frame.size
        view.addSubview(scrollView, constraints: [scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                                  scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                                  scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                                  scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
        
        scrollView.addSubview(headerLabel, constraints: [headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
                                                         headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                                                         headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        
        scrollView.addSubview(imageView, constraints: [imageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: padding),
                                                       imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                       imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
                                                       imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.80)])
        
        scrollView.addSubview(descriptionLabel, constraints: [descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
                                                              descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                                                              descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)])
        
        scrollView.addSubview(button, constraints: [button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                                                    button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding)])
    }
    
}

// MARK: - Action

private extension SummaryViewController {
    
    @objc func didTapButton() {
        delegate?.summaryViewControllerDidTapButton(self)
    }
    
}
