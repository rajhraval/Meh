//
//  HomeViewController.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {

    private var refreshButton: UIButton = {
        let refreshButton = UIButton(type: .system)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.setImage(UIImage(systemName: "arrow.counterclockwise.circle.fill"), for: .normal)
        return refreshButton
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
        setupButtonConstraints()
    }

    private func setupButtonConstraints() {
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        view.addSubview(refreshButton)
        refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
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

}

