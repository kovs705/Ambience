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
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                handleTouchDown()
            } else {
                handleTouchUp()
            }
        }
    }
    
    private func handleTouchDown() {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateThis(view: self.firstBlock, isRestoring: false)
            }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animateThis(view: self.secondBlock, isRestoring: false)
            }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateThis(view: self.thirdBlock, isRestoring: false)
            }
            // self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    private func handleTouchUp() {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateThis(view: self.firstBlock, isRestoring: true)
            }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animateThis(view: self.secondBlock, isRestoring: true)
            }
            
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateThis(view: self.thirdBlock, isRestoring: true)
            }
            
        }, completion: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ambience: Ambience) {
        addSubviews()
        
        configureUI(ambience: ambience)
    }
    
    func configureUI(ambience: Ambience) {
        configureOtherB(ambience)
        configureFirstB()
        configureName(ambience)
        configureImage(ambience)
    }
    
    private func configureFirstB() {
        firstBlock.snp.makeConstraints { make in
            
            make.top.equalTo(contentView).offset(12)
            make.leading.trailing.equalTo(contentView).inset(3)
            
            make.height.equalTo(165)
            //make.width.equalTo(contentView).inset(5)
        }
        
        firstBlock.layer.cornerRadius = 15
        firstBlock.addShadow(color: UIColor.black.cgColor, opacity: 0.3, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 10)
        
        contentView.bringSubviewToFront(thirdBlock)
        contentView.bringSubviewToFront(secondBlock)
        contentView.bringSubviewToFront(firstBlock)
    }
    
    private func configureOtherB(_ ambience: Ambience) {
        secondBlock.backgroundColor = ambience.firstColor
        thirdBlock.backgroundColor = ambience.secondColor
        
        secondBlock.layer.cornerRadius = 15
        thirdBlock.layer.cornerRadius = 15
        
        secondBlock.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(9)
            make.top.equalTo(firstBlock.snp.top).offset(-6)
            make.bottom.equalTo(firstBlock.snp.bottom).inset(15)
        }
        
        thirdBlock.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(18)
            make.top.equalTo(secondBlock.snp.top).offset(-6)
            make.bottom.equalTo(firstBlock.snp.bottom).inset(15)
        }
    }
    
    func configureName(_ ambience: Ambience) {
        name.text = ambience.name
        name.numberOfLines = 0
        name.textAlignment = .center
        
        name.font = UIFont.systemFont(ofSize: 16)
        
        name.snp.makeConstraints { make in
            make.top.equalTo(firstBlock.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.trailing.equalTo(contentView).offset(5)
        }
        
    }
    
    func configureImage(_ ambience: Ambience) {
        firstBlock.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: ambience.image)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(firstBlock)
        }
        
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
    }
    
    private func addSubviews() {
        let allViews = [firstBlock, secondBlock, thirdBlock, name]
        allViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: - Animation
    func animateThis(view: UIView, isRestoring: Bool) {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {
            if isRestoring {
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                view.transform = .identity
            }
        }, completion: nil)
    }
}
