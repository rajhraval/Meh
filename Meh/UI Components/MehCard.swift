//
//  MehCard.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

protocol MehCardDelegate: AnyObject {
    func refreshTapped()
    func favoriteTapped()
    func shareTapped()
}

final class MehCard: UIView {

    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    private var refreshButton: MehButton = {
        let refreshButton = MehButton(style: .label)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.title = "Meh"
        return refreshButton
    }()

    private var favoriteButton: MehButton = {
        let favoriteButton = MehButton(style: .icon)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.image = UIImage(systemName: "heart.fill")!
        return favoriteButton
    }()

    private var shareButton: MehButton = {
        let shareButton = MehButton(style: .icon)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.image = UIImage(systemName: "square.and.arrow.up")!
        return shareButton
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

    weak var delegate: MehCardDelegate?

    var activity: Activity? {
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
        setupGradient()
    }

    private func setupGradient() {
        containerView.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        randomGradient = CAGradientLayer.createRandomGradientLayer(in: containerView.frame)
        randomGradient.cornerRadius = 20
        randomGradient.cornerCurve = .continuous
        containerView.layer.insertSublayer(randomGradient, at: 0)
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
        setupStackViewConstraints()
    }

    private func setupStackViewConstraints() {
        containerView.addSubview(buttonStackView)
        buttonStackView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 28).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28).isActive = true
        setupFavoriteConstraints()
        setupRefreshConstraints()
        setupShareConstraints()
    }

    private func setupRefreshConstraints() {
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        buttonStackView.addArrangedSubview(refreshButton)
    }

    private func setupFavoriteConstraints() {
        favoriteButton.addTarget(self, action: #selector(favourite), for: .touchUpInside)
        buttonStackView.addArrangedSubview(favoriteButton)

    }

    private func setupShareConstraints() {
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        buttonStackView.addArrangedSubview(shareButton)
    }

    @objc
    private func refresh(_ sender: UIButton) {
        delegate?.refreshTapped()
    }

    @objc
    private func favourite(_ sender: UIButton) {
        delegate?.favoriteTapped()
    }

    @objc
    private func share(_ sender: UIButton) {
        delegate?.shareTapped()
    }


}
