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
    
    func givePlayPauseImage()
    func optimizeClose()
    
    func shuffleIt()
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?)
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
    
    var player: AVAudioPlayer?
    
    required init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?, player: AVAudioPlayer?) {
        self.view = view
        self.ambience = ambience
        self.ambiences = ambiences
        self.player = player
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
    
}
