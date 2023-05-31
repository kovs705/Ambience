//
//  AmbiVC.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import SnapKit

class AmbiVC: UIViewController {
    
    var presenter: AmbiPresenterProtocol!
    
    private var imageView = UIImageView()
    private var closeB = UIButton()
    
    private var ambienceImage = UIImageView()
    private var soundB = UIButton()
    private var shuffleB = UIButton()
    private var nameLabel = UILabel()
    
    private var showMore = UIButton() // more sounds on MixKit
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .down
        self.imageView.addGestureRecognizer(swipeGesture)
        
        imageView.backgroundColor = .black
        ambienceImage.backgroundColor = .black
        
        configureUI()
        placeImageView()
        placeAmbienceImage()
        
        placeCloseB()
        
        setAmbience(ambience: presenter.ambience)
    }
    
    
    // MARK: - Other funcs
    func configureUI() {
        view.addSubviews(imageView, ambienceImage, closeB)
        
        closeB.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    func placeImageView() {
        
        let transparentView = UIView()
        transparentView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = transparentView.bounds
        
        transparentView.addSubviews(blurView)
        imageView.addSubviews(transparentView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        blurView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(transparentView)
        }
        
        transparentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(imageView)
        }
    }
    
    func placeAmbienceImage() {
        
        ambienceImage.snp.makeConstraints { make in
            make.top.equalTo(view).inset(170)
            make.leading.trailing.equalTo(view).inset(40)
            make.height.equalTo(300)
        }
        
        ambienceImage.contentMode = .scaleAspectFill
        ambienceImage.clipsToBounds = true
        ambienceImage.layer.cornerRadius = 16
    }
    
    func placeCloseB() {

        closeB.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalTo(view).inset(25)
        }
        
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        closeB.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: config), for: .normal)
        closeB.tintColor = .systemGray6
    }
    
    // MARK: - Swipe gesture
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            // Handle the gesture direction
            // For example, dismiss the view controller
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Protocol
extension AmbiVC: AmbiViewProtocol {
    
    func setAmbience(ambience: Ambience?) {
        guard let image = ambience?.image else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: image)
            self.ambienceImage.image = UIImage(named: image)
        }
    }
    
}
