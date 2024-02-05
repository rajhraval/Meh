//
//  ShareViewController.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

class ShareViewController: UIViewController {

    private var mehCard: MehCard = {
        let mehCard = MehCard()
        mehCard.translatesAutoresizingMaskIntoConstraints = false
        return mehCard
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var downloadButton: MehButton = {
        let button = MehButton(style: .text)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColour = .systemMint
        button.title = "Save"
        return button
    }()

    private var shareButton: MehButton = {
        let button = MehButton(style: .text)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColour = .systemIndigo
        button.title = "Share"
        return button
    }()

    private var dismissButton: MehButton = {
        let button = MehButton(style: .icon)
        button.image = UIImage(systemName: "xmark.circle.fill")!
        return button
    }()

    private var item: MehItem!

    init(item: MehItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setup() {
        title = "Share"
        view.backgroundColor = .systemBackground
        setupStackViewConstraints()
        setupNavigationItemButton()
    }

    private func setupStackViewConstraints() {
        mehCard.activity = Activity(from: item)
        let color = UIColor(hex: item.color)
        mehCard.cardColor = color
        dismissButton.foregroundColour = color
        view.addSubview(mehCard)
        view.addSubview(buttonStackView)
        mehCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        mehCard.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.topAnchor, constant: -20).isActive = true
        mehCard.pinToLeadingAndTrailingEdgesWithConstant(20)
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        buttonStackView.pinToLeadingAndTrailingEdgesWithConstant(20)
        buttonStackView.addArrangedSubviews(downloadButton, shareButton)
        downloadButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        downloadButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
    }

    private func setupNavigationItemButton() {
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: dismissButton)
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc
    func saveImage(_ sender: UIButton) {
        let image = mehCard.asImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    @objc
    func shareImage(_ sender: UIButton) {
        let cardImage = mehCard.asImage()
        let image = ShareableImage(image: cardImage, title: "Feeling Meh?", subtitle: "Here's what you can do.")
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

    @objc
    func dismissView(_ sender: UIButton) {
        dismiss(animated: true)
    }


}
