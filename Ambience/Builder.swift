//
//  Builder.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

protocol BuilderProtocol {
    func getMainModule() -> UIViewController
}


final class Builder: BuilderProtocol {
    
    func getMainModule() -> UIViewController {
        let view = MainVC()
        let ambienceManager = AmbienceManager()
        let presenter = MainVCPresenter(view: view, ambiences: ambienceManager)
        view.presenter = presenter
        return view
    }
}
