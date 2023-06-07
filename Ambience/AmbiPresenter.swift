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
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?)
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
    
    required init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?) {
        self.view = view
        self.ambience = ambience
        self.ambiences = ambiences
    }
    
    func setAmbience(ambience: Ambience?) {
        self.view?.setAmbience(ambience: ambience)
    }
    
    
    // MARK: - AVPlayer functionality
    func playPause() {
        if view?.isPlaying == true {
            stop()
        } else {
            play()
        }
    }
    
    func play() {
        guard let sound = ambience?.pathToSound else { return }
        let path = Bundle.main.path(forResource: sound, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        let session = AVAudioSession.sharedInstance()
        do {
            view?.player? = try AVAudioPlayer(contentsOf: url)
            view?.player?.numberOfLoops = 50
            
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            
            let currentVolume = session.outputVolume
//            var num = 0.0
            for _ in 1...10 {
//                num += 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    guard let self = self else { return }
                    self.view?.player?.volume = currentVolume + 0.1
                }
            }
            
            
            self.view?.player?.play()
        } catch {
            fatalError("Couldn't load file")
        }
    }
    
    func stop() {
        view?.player?.stop()
    }
    
    func shuffle() {
        print("Shuffled")
    }
    
    
    func showMore(vc: UIViewController) {
        // more sounds at MixKit
        // func on the bottom
    }
    
}
