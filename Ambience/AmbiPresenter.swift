//
//  AmbiPresenter.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

protocol AmbiViewProtocol: AnyObject {
    func setAmbience(ambience: Ambience?)
}

protocol AmbiPresenterProtocol: AnyObject {
    init(view: AmbiViewProtocol, ambience: Ambience?)
    var ambience: Ambience? { get }
    
    func setAmbience(ambience: Ambience?)
    func showMore(vc: UIViewController)
}

final class AmbiPresenter: AmbiPresenterProtocol {
    
    weak var view: AmbiViewProtocol?
    var ambience: Ambience?
    
    required init(view: AmbiViewProtocol, ambience: Ambience?) {
        self.view = view
        self.ambience = ambience
    }
    
    func setAmbience(ambience: Ambience?) {
        self.view?.setAmbience(ambience: ambience)
    }
    
    func showMore(vc: UIViewController) {
        // more sounds at MixKit
        // func on the bottom
    }
    
}
