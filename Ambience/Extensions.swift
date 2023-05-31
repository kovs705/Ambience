//
//  Extensions.swift
//  Ambience
//
//  Created by Kovs on 29.05.2023.
//

import UIKit
import SafariServices

//MARK: - UIView extension

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addShadow(color: CGColor, opacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}

// MARK: - UIViewController and Safari

extension UIViewController {
    func presentSafariVC(with url: URL, for vc: UIViewController) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .black
        vc.present(safariVC, animated: true)
    }
}
