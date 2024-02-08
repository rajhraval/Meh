//
//  MehSliderCell.swift
//  Meh
//
//  Created by Raj Raval on 07/02/24.
//

import UIKit
import MultiSlider

class MehSliderCell: UICollectionViewCell {

    static let reuseIdentifier = "MehSliderCell"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var slider: MultiSlider = {
        let slider = MultiSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = [0, 1]
        slider.orientation = .horizontal
        slider.tintColor = .systemOrange
        slider.outerTrackColor = .systemGroupedBackground
        slider.keepsDistanceBetweenThumbs = false
        slider.thumbImage = UIImage(resource: .pointer)
        slider.trackWidth = 16
        slider.valueLabelFont = .p
        slider.valueLabelPosition = .top
        slider.hasRoundTrackEnds = false
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupView()
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        setupSlider()
    }

    private func setupSlider() {
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        containerView.addSubview(slider)
        slider.pinToTopBottomLeadingTrailingEdgesWithConstant(16)
    }


    @objc
    private func handleSlider(_ slider: MultiSlider) {

    }

   
}
