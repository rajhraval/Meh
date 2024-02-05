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
                mehCard.isHidden = false
                mehCard.activity = activity
                Log.message("Activity is \(activity?.name ?? "NULL")")
            }
            .store(in: &cancellables)
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                if state == .idle {
                    loader.stopAnimating()
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
        let filterSymbol = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")

        let filterButton = UIBarButtonItem(image: filterSymbol, style: .plain, target: self, action: #selector(openFilterBoard))

        navigationItem.rightBarButtonItem = filterButton
    }

    private func setupMehCardConstraints() {
        mehCard.isHidden = true
        mehCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mehCard)
        setupStackViewConstraints()
        mehCard.pinToLeadingAndTrailingEdgesWithConstant(16)
        mehCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        mehCard.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -36).isActive = true
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
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
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
        viewModel.fetchActivity()
        mehCard.flipCard()
    }

    @objc
    private func favourite(_ sender: UIButton) {
        mehCard.jumpCard()
    }

    @objc
    private func share(_ sender: UIButton) {
        
    }

}

extension HomeViewController {

    @objc
    private func openFilterBoard() {

    }

}
