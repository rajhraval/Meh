//
//  MehCard.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

final class MehCard: UIView {

    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private var activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private var promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h1
        label.textColor = .white.withAlphaComponent(0.6)
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private var randomGradient: CAGradientLayer! {
        didSet {
            setupView()
        }
    }

    var activity: Activity? {
        didSet {
            setupView()
        }
    }

    var cardColor: UIColor = UIColor.randomColor {
        didSet {
            setupView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.backgroundColor = cardColor
        containerView.cornerRadius(20)
    }

    private func setupView() {
        setupContainerView()
        setupPromptLabel()
        setupActivityLabel()
    }

    private func setupContainerView() {
        addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupPromptLabel() {
        promptLabel.text = activity == nil ? "Uh, this is not real" : "This is what you can do."
        containerView.addSubview(promptLabel)
        promptLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28).isActive = true
        promptLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28).isActive = true
        promptLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -28).isActive = true
    }

    private func setupActivityLabel() {
        activityLabel.text = activity?.name ?? "No Activity? Meh :("
        containerView.addSubview(activityLabel)
        activityLabel.topAnchor.constraint(greaterThanOrEqualTo: promptLabel.bottomAnchor, constant: 28).isActive = true
        activityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28).isActive = true
        activityLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -28).isActive = true
        activityLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28).isActive = true
    }
    
    func flipCard() {
        cardColor = .randomColor
        UIView.transition(with: self, duration: 0.6, options: .transitionFlipFromRight, animations: nil)
    }

    func jumpCard() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.bounds.origin.y += 20
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.bounds.origin.y -= 20
            })
        }

    }


}
