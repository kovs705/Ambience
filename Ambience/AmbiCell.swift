//
//  AmbiCell.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

class AmbiCell: UICollectionViewCell {
    
    static let id = "ambiCell"
    
    let firstBlock = UIView()
    let secondBlock = UIView()
    let thirdBlock = UIView()
    
    let imageView = UIImageView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews()
        
        configureFirstB()
        configureOtherB()
    }
    
    private func configureFirstB() {
        
    }
    
    private func configureOtherB() {
        
    }
    
    private func addSubviews() {
        let allViews = [firstBlock, secondBlock, thirdBlock, imageView, name]
        allViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
