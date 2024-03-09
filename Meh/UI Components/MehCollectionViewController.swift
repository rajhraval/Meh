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

    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()

    var navigationView: MehNavigationView = {
        let navigationView = MehNavigationView()
        return navigationView
    }()

    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: .singleRowWithHeader(header: false))
        return collectionView
    }()

    var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    var layout: LayoutType {
        didSet {
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

    func setup() {
        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(containerStackView)
        containerStackView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        setupNavigationView()
        setupCollectionView()
        setupActivityIndicator()
        collectionView.registerCells([UICollectionViewCell.self])
    }

    private func setupNavigationView() {
        containerStackView.addArrangedSubview(navigationView)
    }

    private func setupCollectionView() {
        containerStackView.addArrangedSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupActivityIndicator() {
        view.addSubview(loader)
        loader.centerInSuperview()
    }

}

extension MehCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }

}

extension MehCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}
