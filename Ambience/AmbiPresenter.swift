//
//  AmbiPresenter.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import AVFoundation

protocol AmbiViewProtocol: AnyObject {
    func setAmbience(ambience: Ambience?)
    
    var isPlaying: Bool { get set }
    var player: AVAudioPlayer? { get set }
    
    var images: [UnImage] { get set }
    
    func givePlayPauseImage()
    func optimizeClose()
    
    func shuffleIt()
    func changePhoto()
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?, networkService: NetworkService)
    var ambience: Ambience? { get }
    var ambiences: AmbienceManagerProtocol? { get }
    
    func setAmbience(ambience: Ambience?)
    func showMore(vc: UIViewController)
    
    var player: AVAudioPlayer? { get set }
    func playPause()
    
    func play()
    func stop()
    func shuffle()
}

final class AmbiPresenter: AmbiPresenterProtocol {
    
    weak var view: AmbiViewProtocol?
    var ambience: Ambience?
    var ambiences: AmbienceManagerProtocol?
    
    var networkService: NetworkService!
    
    var player: AVAudioPlayer?
    
    required init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?, networkService: NetworkService) {
        self.view = view
        self.ambience = ambience
        self.ambiences = ambiences
        self.player = player
        self.networkService = networkService
    }
    
    func setAmbience(ambience: Ambience?) {
        self.view?.setAmbience(ambience: ambience)
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
        guard let shuffledAmbience = ambiences?.all.randomElement() else { return }
        ambience = shuffledAmbience
        view?.shuffleIt()
        print("Shuffled")
    }
    
    
    func showMore(vc: UIViewController) {
        // more sounds at MixKit
        // func on the bottom
    }
    
    func getPhotofromUnsplash() {
        let request = SearchPhotosRequest(page: "1", query: "Mountains")
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let images):
                guard let images = images else {
                    return
                }
                
                if self.view?.images == nil {
                    self.view?.images.append(contentsOf: images)
                    
                } else {
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
