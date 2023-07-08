//
//  AmbiVC.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import SnapKit
import AVFoundation

class AmbiVC: UIViewController {
    
    var presenter: AmbiPresenterProtocol!
    
    private var imageView = UIImageView()
    private var closeB = UIButton()
    
    private var ambienceImage = UIImageView()
    private var soundB = UIButton()
    private var shuffleB = UIButton()
    private var nameLabel = UILabel()
    
    private var showMore = UIButton() // more sounds on MixKit
    
    var player: AVAudioPlayer?
    var isPlaying: Bool = false
    
    var images: [ImageResult] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
        view.backgroundColor = .black
        imageView.backgroundColor = .black
        ambienceImage.backgroundColor = .black
        
        configureUI()
        configureButtons()
        
        setAmbience(ambience: presenter.ambience)
        
        presenter.getPhotosfromUnsplash()
    }
    
    
    // MARK: - Other funcs
    func configureUI() {
        view.addSubviews(imageView, ambienceImage, closeB, soundB, shuffleB)
        placeImageView()
        placeAmbienceImage()
    }
    
    func configureButtons() {
        placeCloseB()
        placeSoundB()
        placeShuffleB()
        
        givePlayPauseImage()
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
        
        closeB.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: UIHelper.giveConfigForImage(size: 25, weight: .semibold)), for: .normal)
        closeB.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        closeB.tintColor = .systemGray6
    }
    
    func placeSoundB() {
        soundB.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        soundB.tintColor = .systemGray5
        
        soundB.snp.makeConstraints { make in
            make.top.equalTo(ambienceImage.snp.bottom).offset(100)
            make.centerX.equalTo(view)
        }
    }
    
    func placeShuffleB() {
        shuffleB.setImage(UIImage(systemName: "shuffle", withConfiguration: UIHelper.giveConfigForImage(size: 30, weight: .semibold)), for: .normal)
        shuffleB.addTarget(self, action: #selector(shuffle), for: .touchUpInside)
        shuffleB.tintColor = .systemGray5
        
        shuffleB.snp.makeConstraints { make in
            make.top.equalTo(ambienceImage.snp.bottom).offset(107)
            make.leading.equalTo(soundB.snp.trailing).offset(40)
        }
    }
    
    
    // MARK: - Obj-c funcs
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            dismiss(animated: true, completion: nil)
            optimizeClose()
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
        optimizeClose()
    }
    
    @objc func playPause() {
        presenter.playPause()
    }
    
    @objc func shuffle() {
        presenter.shuffle()
    }
    
}


// MARK: - Protocol
extension AmbiVC: AmbiViewProtocol {
    
    func setAmbience(ambience: Ambience?) {
        guard let image = ambience?.image else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let self = self else { return }
            self.imageView.image = UIImage(named: image)
            self.ambienceImage.image = UIImage(named: image)
            
            self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
            self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
        }
    }
    
    func givePlayPauseImage() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.isPlaying {
                self.soundB.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIHelper.giveConfigForImage(size: 45, weight: .semibold)), for: .normal)
            } else {
                self.soundB.setImage(UIImage(systemName: "play.fill", withConfiguration: UIHelper.giveConfigForImage(size: 45, weight: .semibold)), for: .normal)
            }
        }
    }
    
    func optimizeClose() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            self.imageView.image = nil
            self.ambienceImage.image = nil
            
            self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
            self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
        }
    }
    
    func shuffleIt() {
        if isPlaying {
            playPause()
            givePlayPauseImage()
        }
        setAmbience(ambience: presenter?.ambience)
    }
    
    func changePhoto() {
        guard (!images.isEmpty) else {
            print("Empty!!")
            return
        }
        
        guard let randomImage = images.randomElement()?.urls.regular else {
            return
        }
        ImageClient.shared.setImage(from: randomImage, placeholderImage: UIImage(named: self.presenter.ambience!.image)) { image in
            guard let image else {
                putImage(image: image!)
                return
            }
            
            putImage(image: image)
            
        }
        
        func putImage(image: UIImage) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = nil
                self.ambienceImage.image = nil
                
                self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
                self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.imageView.image = image
                    self.ambienceImage.image = image
                    
                    self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
                    self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
                }
            }
        }
    }
    
    
    
}
