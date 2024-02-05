//
//  ShareableImage.swift
//  Meh
//
// Credit: https://nemecek.be/blog/189/wip-sharing-data-with-uiactivityviewcontroller-tips-tricks
//

import UIKit
import LinkPresentation

final class ShareableImage: NSObject, UIActivityItemSource {
    private let image: UIImage
    private let title: String
    private let subtitle: String?

    init(image: UIImage, title: String, subtitle: String? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle

        super.init()
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return title
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return image
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()

        metadata.iconProvider = NSItemProvider(object: image)
        metadata.title = title
        if let subtitle = subtitle {
            metadata.originalURL = URL(fileURLWithPath: subtitle)
        }

        return metadata
    }
}

