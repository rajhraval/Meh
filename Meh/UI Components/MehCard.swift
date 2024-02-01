//
//  MehCard.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

final class MehCard: UIView {

    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private var activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h0
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private var promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h1
        label.textColor = .white.withAlphaComponent(0.6)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

}
