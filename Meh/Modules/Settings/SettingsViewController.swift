//
//  SettingsViewController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

final class SettingsViewController: UIViewController {

    private var viewModel: SettingsViewModel!

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
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

    func setup() {
        title = "Favorites"
        view.backgroundColor = .white
    }

}
