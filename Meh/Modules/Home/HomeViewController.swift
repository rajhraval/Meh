//
//  HomeViewController.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {

    private var mehCard: MehCard =  {
        let mehCard = MehCard()
        mehCard.translatesAutoresizingMaskIntoConstraints = false
        mehCard.isHidden = true
        return mehCard
    }()

    private var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 18
        return stackView
    }()

    private var refreshButton: MehButton = {
        let refreshButton = MehButton(style: .jumboText)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.title = "Meh"
        refreshButton.foregroundColour = .orange
        return refreshButton
    }()

    private var favoriteButton: MehButton = {
        let favoriteButton = MehButton(style: .jumboSymbol)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.image = UIImage(systemName: "heart.fill")!
        return favoriteButton
    }()

    private var shareButton: MehButton = {
        let shareButton = MehButton(style: .jumboSymbol)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.image = UIImage(systemName: "square.and.arrow.up")!
        return shareButton
    }()

    private var filterButton: MehButton = {
        let filterButton = MehButton(style: .icon)
        filterButton.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")!
        filterButton.foregroundColour = .orange
        return filterButton
    }()

    private var activity: Activity?
    private var viewModel: HomeViewModel!
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: HomeViewModel = HomeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
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
        title = "Feeling Meh?"
        view.backgroundColor = .systemBackground
        setupView()
        bind()
    }

    private func bind() {
        viewModel.$activity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] randomActivity in
                guard let self = self else { return }
                activity = randomActivity
                mehCard.activity = activity
                updateColor()
                Log.message("Activity is \(activity?.name ?? "NULL")")
            }
            .store(in: &cancellables)
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                if state == .idle {
                    loader.stopAnimating()
                    mehCard.isHidden = false
                }
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        setupLoaderConstraints()
        setupMehCardConstraints()
        setupBarButtons()
    }

    private func setupBarButtons() {
        filterButton.addTarget(self, action: #selector(openFilterBoard), for: .touchUpInside)
        let filterButton = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = filterButton
    }

    private func setupMehCardConstraints() {
        mehCard.isHidden = true
        mehCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mehCard)
        setupStackViewConstraints()
        mehCard.pinToLeadingAndTrailingEdgesWithConstant(16)
        mehCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        mehCard.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -22).isActive = true
    }

    private func setupStackViewConstraints() {
        view.addSubview(buttonStackView)
        buttonStackView.pinToLeadingAndTrailingEdgesWithConstant(64)
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36).isActive = true
        setupFavoriteConstraints()
        setupRefreshConstraints()
        setupShareConstraints()
    }

    private func setupRefreshConstraints() {
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        buttonStackView.addArrangedSubview(refreshButton)
        refreshButton.setWidthHeightConstraints(96)
    }

    private func setupFavoriteConstraints() {
        favoriteButton.addTarget(self, action: #selector(favourite), for: .touchUpInside)
        buttonStackView.addArrangedSubview(favoriteButton)
        favoriteButton.setWidthHeightConstraints(64)
    }

    private func setupShareConstraints() {
        let shareAction = UIAction(title: "Share Image", image: UIImage(systemName: "square.and.arrow.up"), handler: { [weak self] _ in
            guard let self = self else { return }
            saveImage(mehCard.asImage())
        })

        let saveAction = UIAction(title: "Save Image", image: UIImage(systemName: "square.and.arrow.down"), handler: { [weak self] _ in
            guard let self = self else { return }
            saveImage(mehCard.asImage())
        })

        shareButton.showsMenuAsPrimaryAction = true
        shareButton.menu = UIMenu(children: [shareAction, saveAction])
        buttonStackView.addArrangedSubview(shareButton)
        shareButton.setWidthHeightConstraints(64)
    }

    private func setupLoaderConstraints() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }

}

extension HomeViewController {

    @objc
    private func refresh(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        viewModel.fetchActivity()
        mehCard.flipCard()
    }

    @objc
    private func favourite(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        mehCard.jumpCard()
        guard let activity = activity else { return }
        viewModel.addActivity(activity, with: mehCard.cardColor)
    }

    private func updateColor() {
        let color = mehCard.cardColor
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            refreshButton.backgroundColour = color.withAlphaComponent(0.6)
            refreshButton.foregroundColour = color

            favoriteButton.backgroundColour = color
            shareButton.backgroundColour = color

            filterButton.foregroundColour = color
        }
    }

}

extension HomeViewController {

    private func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    private func shareImage(_ image: UIImage) {
        let image = ShareableImage(image: image, title: "Feeling Meh?", subtitle: "Here's what you can do.")
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

}

extension HomeViewController {

    @objc
    private func openFilterBoard() {
        
    }

}
