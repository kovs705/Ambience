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
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addShadow(color: CGColor, opacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}

// MARK: - UIImage extension

extension UIImage {
    func blurImage(radius: CGFloat) -> UIImage? {
        let context = CIContext(options: nil)
        let imageToBlur = CIImage(image: self)
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(imageToBlur, forKey: kCIInputImageKey)
        blurFilter?.setValue(radius, forKey: kCIInputRadiusKey)
        guard let outputImage = blurFilter?.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
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
