//
//  AmbienceManager.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

protocol AmbienceManagerProtocol {
    var all: [Ambience] { get }
    
}

class AmbienceManager: AmbienceManagerProtocol {
    
    var all: [Ambience] = [
        Ambience(name: "Blue Forest", firstColor: UIColor(named: Colors.BlueForest.one)!, secondColor: UIColor(named: Colors.BlueForest.two)!, image: Images.blueForest, pathToSound: ""),
        Ambience(name: "Peacefull Night", firstColor: UIColor(named: Colors.PeacefullNight.one)!, secondColor: UIColor(named: Colors.PeacefullNight.two)!, image: Images.peacefullNight, pathToSound: ""),
        Ambience(name: "Highest Mountains", firstColor: UIColor(named: Colors.HighestMountains.one)!, secondColor: UIColor(named: Colors.HighestMountains.two)!, image: Images.highestMountains, pathToSound: ""),
        Ambience(name: "Silent Winter", firstColor: UIColor(named: Colors.SilentWinter.one)!, secondColor: UIColor(named: Colors.SilentWinter.two)!, image: Images.silentWinter, pathToSound: ""),
        Ambience(name: "Urban City", firstColor: UIColor(named: Colors.UrbanCity.one)!, secondColor: UIColor(named: Colors.UrbanCity.two)!, image: Images.urbanCity, pathToSound: "")
    ]
    
    
}
