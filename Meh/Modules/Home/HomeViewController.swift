//
//  HomeViewController.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {

    private var refreshButton: MehButton = {
        let refreshButton = MehButton(style: .text)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.title = "Meh"
        return refreshButton
    }()

    private var favoriteButton: MehButton = {
        let favoriteButton = MehButton(style: .symbol)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.backgroundColour = .systemPink
        return favoriteButton
    }()

    private var shareButton: MehButton = {
        let shareButton = MehButton(style: .icon)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.font = .h2
        shareButton.foregroundColour = .systemRed
        return shareButton
    }()

    private var activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h0
        return label
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    private var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
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
        view.backgroundColor = .systemBackground
        setupView()
        bind()
    }

    private func bind() {
        viewModel.$activity
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] randomActivity in
                guard let self = self else { return }
                activity = randomActivity
                activityLabel.text = activity?.name
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
        setupStackViewConstraints()
        setupActivityLabelConstraints()
    }

    private func setupActivityLabelConstraints() {
        view.addSubview(activityLabel)
        activityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupStackViewConstraints() {
        view.addSubview(buttonStackView)
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
        shareButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    private func setupLoaderConstraints() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }

    @objc
    func refresh(_ sender: UIButton) {
        loader.startAnimating()
        viewModel.fetchActivity()
    }

    @objc
    func favourite(_ sender: UIButton) {
        guard let activity = activity else { return }
        viewModel.addActivity(activity)
    }

    @objc
    func share(_ sender: UIButton) {

    }
    
}

