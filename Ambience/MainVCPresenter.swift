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
    var ambiences: AmbienceManagerProtocol? { get }
    init(view: MainVCViewProtocol, ambiences: AmbienceManagerProtocol?)
}

final class MainVCPresenter: MainVCPresenterProtocol {

    weak var view: MainVCViewProtocol?
    var ambiences: AmbienceManagerProtocol?

    required init(view: MainVCViewProtocol, ambiences: AmbienceManagerProtocol?) {
        self.view = view
        self.ambiences = ambiences
    }

}
