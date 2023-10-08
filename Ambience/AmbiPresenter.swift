//
//  AmbiPresenter.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import AVFoundation

protocol AmbiViewProtocol: AnyObject {
    func setNewAmbience(ambience: Ambience?) async
    func loadImage(named name: String) async throws -> UIImage
    
    var isPlaying: Bool { get set }
    var player: AVAudioPlayer? { get set }
    
    var images: [ImageResult] { get set }
    
    func givePlayPauseImage()
    func optimizeClose()
    
    func shuffleIt()
    func changePhoto()
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?, networkService: NetworkService, caller: APICaller?)
    var ambience: Ambience? { get }
    var ambiences: AmbienceManagerProtocol? { get }
    
    func showMore(vc: UIViewController)
    
    var player: AVAudioPlayer? { get set }
    var APICaller: APICaller? { get set }
    
    func playPause()
    
    func play()
    func stop()
    func shuffle()
    
    func getPhotosfromUnsplash()
}

final class AmbiPresenter: AmbiPresenterProtocol {
    
    weak var view: AmbiViewProtocol?
    var ambience: Ambience?
    var ambiences: AmbienceManagerProtocol?
    
    var networkService: NetworkService!
    
    var player: AVAudioPlayer?
    var APICaller: APICaller?
    
    required init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?, networkService: NetworkService, caller: APICaller?) {
        self.view = view
        self.ambience = ambience
        self.ambiences = ambiences
        self.player = player
        self.networkService = networkService
        self.APICaller = caller
    }
    
    // MARK: - AVPlayer functionality
    func playPause() {
        if view?.isPlaying == true {
            stop()
            print("pause")
        } else {
            print("play")
            play()
        }
    }
    
    func play() {
        guard let sound = ambience?.pathToSound else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let path = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
            print("Success")
            do {
                try self.player = AVAudioPlayer(contentsOf: path)
                self.player?.numberOfLoops = 50
    
                self.player?.prepareToPlay()
                self.player?.volume = 1.0
                
                self.player?.play()
                self.view?.isPlaying = true
                self.view?.givePlayPauseImage()
            } catch {
                fatalError("Couldn't load file")
            }
        }

    }
    
    func stop() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.player?.setVolume(0, fadeDuration: 2)
            self.player?.stop()
            self.view?.isPlaying = false
            self.view?.givePlayPauseImage()
        }
    }
    
    func shuffle() {
        var random: Ambience! = giveRandomAmbi()
        
        while random == ambience {
            random = giveRandomAmbi()
        }
        
        ambience = random
        view?.shuffleIt()
        view?.images.removeAll()
        print("Shuffled")
    }
    
    func giveRandomAmbi() -> Ambience {
        guard let shuffledAmbience = ambiences?.all.randomElement() else { return ambience! }
        return shuffledAmbience
    }
    
    func showMore(vc: UIViewController) {
        // more sounds at MixKit
        // func on the bottom
    }
    
    func getPhotosfromUnsplash() {
        guard let view = self.view else { return }
        guard let ambience = ambience else { return }
        
        if view.images.isEmpty {
            let ambienceWord: String = ambience.name

            guard let APICaller = APICaller else { return }
            APICaller.createRequestAndFetchPhotos(with: ambienceWord, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let images):
                    addContents(of: images)
                    print("Cool!")
                    self.view?.changePhoto()
                    
                case .failure(let error):
                    print(error)
                }
                
                func addContents(of images: [ImageResult]) {
                    self.view?.images.append(contentsOf: images)
                }
            })
        } else {
            self.view?.changePhoto()
        }
        
    }
    
}
