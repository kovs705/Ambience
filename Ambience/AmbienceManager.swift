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
        Ambience(name: "Warm capmfire", firstColor: UIColor(named: Colors.WarmCampfire.one)!, secondColor: UIColor(named: Colors.WarmCampfire.two)!, image: Images.warmCampfire, pathToSound: ""),
        Ambience(name: "Silent Winter", firstColor: UIColor(named: Colors.SilentWinter.one)!, secondColor: UIColor(named: Colors.SilentWinter.two)!, image: Images.silentWinter, pathToSound: ""),
        Ambience(name: "Urban City", firstColor: UIColor(named: Colors.UrbanCity.one)!, secondColor: UIColor(named: Colors.UrbanCity.two)!, image: Images.urbanCity, pathToSound: ""),
        Ambience(name: "Sea waves", firstColor: UIColor(named: Colors.SeaWaves.one)!, secondColor: UIColor(named: Colors.SeaWaves.two)!, image: Images.seaWaves, pathToSound: ""),
        Ambience(name: "Magic", firstColor: UIColor(named: Colors.Magic.one)!, secondColor: UIColor(named: Colors.Magic.two)!, image: Images.magic, pathToSound: ""),
        Ambience(name: "Calm underwater", firstColor: UIColor(named: Colors.CalmUnderwater.one)!, secondColor: UIColor(named: Colors.CalmUnderwater.two)!, image: Images.calmUnderwater, pathToSound: "")
    ]
    
    
}
