//
//  AmbiCell.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit
import SnapKit

class AmbiCell: UICollectionViewCell {
    
    static let id = "ambiCell"
    
    let firstBlock = UIView()
    let secondBlock = UIView()
    let thirdBlock = UIView()
    
    let imageView = UIImageView()
    let name = UILabel()
    
    let offset = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ambience: Ambience) {
        addSubviews()
        
        configureUI(ambience: ambience)
    }
    
    func configureUI(ambience: Ambience) {
        configureFirstB(ambience)
        configureOtherB(ambience)
        configureName(ambience)
        configureImage(ambience)
    }
    
    private func configureFirstB(_ ambience: Ambience) {
        firstBlock.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
            make.height.width.equalTo(contentView).inset(20)
        }
        
        firstBlock.layer.cornerRadius = 15
        
    }
    
    private func configureOtherB(_ ambience: Ambience) {
        secondBlock.backgroundColor = ambience.firstColor
        thirdBlock.backgroundColor = ambience.secondColor
        
        secondBlock.layer.cornerRadius = 15
        thirdBlock.layer.cornerRadius = 15
        
        secondBlock.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-offset)
            make.height.width.equalTo(85)
        }
        
        thirdBlock.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-offset * 2)
            make.height.width.equalTo(60)
        }
    }
    
    func configureName(_ ambience: Ambience) {
        name.text = ambience.name
        name.numberOfLines = 0
        
        name.snp.makeConstraints { make in
            make.top.equalTo(firstBlock.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).offset(5)
        }
        
    }
    
    func configureImage(_ ambience: Ambience) {
        firstBlock.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: ambience.image)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(firstBlock)
        }
        
        imageView.contentMode = .scaleToFill
    }
    
    private func addSubviews() {
        let allViews = [firstBlock, secondBlock, thirdBlock, name]
        allViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
