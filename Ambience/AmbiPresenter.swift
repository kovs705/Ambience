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
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?, ambiences: AmbienceManagerProtocol?)
    var ambience: Ambience? { get }
    var ambiences: AmbienceManagerProtocol? { get }
    
    func setAmbience(ambience: Ambience?)
    func showMore(vc: UIViewController)
    
    var player: AVAudioPlayer? { get set }
    func playPause(ambience: Ambience?)
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
    
    func playPause(ambience: Ambience?) {
        
    }
    
    
    func showMore(vc: UIViewController) {
        // more sounds at MixKit
        // func on the bottom
    }
    
}
