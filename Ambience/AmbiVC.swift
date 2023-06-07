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
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
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
    
    func configureSoundB() {
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .semibold)
        soundB.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        soundB.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        
        
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
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            self.imageView.image = nil
            self.ambienceImage.image = nil
            
            self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
            self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 0.4, from: 1, toValue: 0), forKey: "opacityAnimation")
        }
    }
    
    @objc func playPause() {
        if !isPlaying {
            
            play()
        } else {
            
            stop()
        }
    }
    
    // MARK: - AVPlayer
    func play() {
        guard let sound = presenter.ambience?.pathToSound else { return }
        let path = Bundle.main.path(forResource: sound, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        let session = AVAudioSession.sharedInstance()
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 50
            
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            
            let currentVolume = session.outputVolume
//            var num = 0.0
            for _ in 1...10 {
//                num += 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.player?.volume = currentVolume + 0.1
                }
            }
            
            
            player?.play()
        } catch {
            fatalError("Couldn't load file")
        }
    }
    
    func stop() {
        player?.stop()
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
    
}
