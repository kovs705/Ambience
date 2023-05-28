//
//  MainVCPresenter.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

protocol MainVCViewProtocol: AnyObject {
    
}

protocol MainVCPresenterProtocol: AnyObject {
    
    init(view: MainVCViewProtocol)
}

final class MainVCPresenter: MainVCPresenterProtocol {
    
    weak var view: MainVCViewProtocol?
    
    required init(view: MainVCViewProtocol) {
        self.view = view
    }
    
    
}
