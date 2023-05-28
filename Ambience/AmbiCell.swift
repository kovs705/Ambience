//
//  AmbiCell.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

class AmbiCell: UICollectionViewCell {
    
    static let id = "ambiCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
