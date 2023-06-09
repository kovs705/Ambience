//
//  Builder.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

protocol BuilderProtocol {
    func getMainModule() -> UIViewController
    func getDetailModule(ambience: Ambience) -> UIViewController
}


final class Builder: BuilderProtocol {
    
    func getMainModule() -> UIViewController {
        let view = MainVC()
        let ambienceManager = AmbienceManager()
        let presenter = MainVCPresenter(view: view, ambiences: ambienceManager)
        view.presenter = presenter
        return view
    }
    
    func getDetailModule(ambience: Ambience) -> UIViewController {
        let view = AmbiVC()
        let ambienceManager = AmbienceManager()
        let presenterPlayer = view.player
        let presenter = AmbiPresenter(view: view, ambience: ambience, ambiences: ambienceManager, player: view.player)
        view.presenter = presenter
        return view
    }
}
