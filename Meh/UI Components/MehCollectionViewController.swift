//
//  MehCollectionViewController.swift
//  Meh
//
//  Created by Raj Raval on 09/03/24.
//

import UIKit

class ViewModelType: ObservableObject {
    public init() {}
}

protocol ViewModelInclusion: AnyObject {
    associatedtype ViewModel: ViewModelType
}

class MehCollectionViewController: UIViewController, ViewModelInclusion {
    typealias ViewModel = ViewModelType

    open var navigationView: MehNavigationView = {
        let navigationView = MehNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()

    open var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: .singleRowWithHeader(header: false))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    open var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    open var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var layout: LayoutType {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.setCollectionViewLayout(layout.layout, animated: true)
        }
    }

    public init(with layout: LayoutType = .singleRowWithHeader(header: false)) {
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setup() {
        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        setupNavigationView()
        setupCollectionView()
        setupActivityIndicator()
        setupEmptyStateView()
        collectionView.registerCells([UICollectionViewCell.self])
    }

    private func setupNavigationView() {
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationView.pinToLeadingAndTrailingEdgesWithConstant()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.pinToLeadingAndTrailingEdgesWithConstant()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupActivityIndicator() {
        view.addSubview(loader)
        loader.centerInSuperview()
    }

    private func setupEmptyStateView() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        emptyStateView.centerInSuperview()
    }

}

extension MehCollectionViewController: UICollectionViewDataSource {

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }

}

extension MehCollectionViewController: UICollectionViewDelegate {
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}
