//
//  Extensions.swift
//  Ambience
//
//  Created by Kovs on 29.05.2023.
//

import UIKit
import SafariServices

// MARK: - UIView extension

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

    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
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
