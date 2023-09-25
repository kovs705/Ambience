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

    private var imageView     = UIImageView()
    private var closeB        = UIButton()
    private var unsplashB     = UIButton()

    private var ambienceImage = UIImageView()
    private var soundB        = UIButton()
    private var shuffleB      = UIButton()
    private var nameLabel     = UILabel()

    private var showMore      = UIButton() // more sounds on MixKit

    var player: AVAudioPlayer?
    var isPlaying = false
    var isLoading = false

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

        Task { await setNewAmbience(ambience: presenter.ambience) }

        images.removeAll()
    }

    override func viewDidDisappear(_ animated: Bool) {
        performClearing()
        presenter = nil
    }

    // MARK: - UI funcs
    func configureUI() {
        view.addSubviews(imageView, ambienceImage, closeB, unsplashB, soundB, shuffleB)
        placeImageView()
        placeAmbienceImage()
    }

    func configureButtons() {
        placeCloseB()
        placeUnsplashB()

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
            make.height.equalTo(view.snp.width).inset(40)
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

    func placeUnsplashB() {

        unsplashB.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.trailing.equalTo(view).inset(25)
        }

        unsplashB.setImage(UIImage(systemName: "photo.stack.fill", withConfiguration: UIHelper.giveConfigForImage(size: 25, weight: .semibold)), for: .normal)
        unsplashB.addTarget(self, action: #selector(unsplashIt), for: .touchUpInside)
        unsplashB.tintColor = .systemGray6

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

    // MARK: - Other funcs
    func performClearing() {
        images.removeAll()
        ImageClient.shared.clearCache()
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
        performClearing()
    }

    @objc func unsplashIt() {
        presenter.getPhotosfromUnsplash()
    }

}

// MARK: - Protocol
extension AmbiVC: AmbiViewProtocol {

    func setNewAmbience(ambience: Ambience?) async {
        guard let image = ambience?.image else { return }

        do {
            let loadedImage = try await loadImage(named: image)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = loadedImage
                self.ambienceImage.image = loadedImage
                self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
                self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 1, from: 0, toValue: 1), forKey: "opacityAnimation")
            }
        } catch {
            print("Error loading image:", error)
        }
    }

    func loadImage(named name: String) async throws -> UIImage {
        return try await withUnsafeThrowingContinuation { continuation in
            DispatchQueue.global().async {
                if let image = UIImage(named: name) {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(throwing: NSError(domain: "Failed to load", code: 0, userInfo: nil))
                }
            }
        }
    }

    // MARK: - PlayPauseImage
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

    // MARK: - Close func
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
        Task {
            await setNewAmbience(ambience: presenter?.ambience)
        }
    }

    // MARK: - Change photo
    func changePhoto() {
        guard let randomImage = images.randomElement()?.urls.small,
              let ambience = self.presenter.ambience else { return }

        Task {
            do {
                if let image = try await ImageClient.shared.setImage(from: randomImage, placeholderImage: UIImage(named: ambience.image)) {
                    await putNewImage(image: image)
                } else {
                    await putNewImage(image: UIImage(named: ambience.image)!)
                }
            } catch {
                print("Error in setting image and changing photo")
            }
        }
    }

    func putNewImage(image: UIImage) async {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 0.5, from: 1, toValue: 0), forKey: "opacityAnimation")
            self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 0.5, from: 1, toValue: 0), forKey: "opacityAnimation")

            self.imageView.image     = nil
            self.ambienceImage.image = nil

        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.image = image
            self.ambienceImage.image = image

            self.imageView.layer.add(UIHelper.giveOpacityAnimation(duration: 0.5, from: 0, toValue: 1), forKey: "opacityAnimation")
            self.ambienceImage.layer.add(UIHelper.giveOpacityAnimation(duration: 0.5, from: 0, toValue: 1), forKey: "opacityAnimation")
        }

    }

}
