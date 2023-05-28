//
//  CVLayout.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

struct TwoColumnLayout {
    static func createTwoColumnLayout(in view: UIView) -> UICollectionViewLayout {
        let width = view.bounds.width
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 8
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 2
        let itemHeight = itemWidth / 2.22
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = padding
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: padding,
                                               left: padding,
                                               bottom: padding,
                                               right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return flowLayout
    }
}

