//
//  UIHelper.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

enum UIHelper {
    
    static func createTwoColumnLayout(in view: UIView) -> UICollectionViewLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 2
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 30)
        
        return flowLayout
    }
    
    static func giveOpacityAnimation(duration: Double, from value: Int, toValue: Int) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = value
        animation.toValue = toValue
        animation.duration = CFTimeInterval(duration)
        
        return animation
    }
}

