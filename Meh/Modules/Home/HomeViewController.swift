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
        let configuration = UIImage.SymbolConfiguration(font: .h3)
        let filterSymbol = UIImage(systemName: "slider.horizontal.3")!.withConfiguration(configuration)
        let addSymbol = UIImage(systemName: "plus.circle.fill")!.withConfiguration(configuration)

        let filterButton = UIBarButtonItem(image: filterSymbol, style: .plain, target: self, action: #selector(openFilterBoard))
        let addButton = UIBarButtonItem(image: addSymbol, style: .plain, target: self, action: #selector(addMehItem))

        navigationItem.leftBarButtonItem = filterButton
        navigationItem.rightBarButtonItem = addButton
    }

    private func setupMehCardConstraints() {
        mehCard.isHidden = true
        mehCard.delegate = self
        mehCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mehCard)
        mehCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mehCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mehCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        mehCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
    }

    private func setupLoaderConstraints() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }

}

extension HomeViewController: MehCardDelegate {

    func refreshTapped() {
        loader.startAnimating()
        viewModel.fetchActivity()
    }

    func favoriteTapped() {
        guard let activity = activity else { return }
        viewModel.addActivity(activity)
    }

    func shareTapped() {

    }

}

extension HomeViewController {

    @objc
    private func addMehItem() {

    }

    @objc
    private func openFilterBoard() {

    }

}
