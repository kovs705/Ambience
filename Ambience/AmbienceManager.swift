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
        Ambience(name: "Blue forest", firstColor: UIColor(named: Colors.BlueForest.one)!, secondColor: UIColor(named: Colors.BlueForest.two)!, image: Images.blueForest, pathToSound: Sounds.blueForest),
        Ambience(name: "Peacefull night", firstColor: UIColor(named: Colors.PeacefullNight.one)!, secondColor: UIColor(named: Colors.PeacefullNight.two)!, image: Images.peacefullNight, pathToSound: Sounds.peacefullNight),
        Ambience(name: "Highest mountains", firstColor: UIColor(named: Colors.HighestMountains.one)!, secondColor: UIColor(named: Colors.HighestMountains.two)!, image: Images.highestMountains, pathToSound: Sounds.highestMountains),
        Ambience(name: "Warm capmfire", firstColor: UIColor(named: Colors.WarmCampfire.one)!, secondColor: UIColor(named: Colors.WarmCampfire.two)!, image: Images.warmCampfire, pathToSound: Sounds.warmCampfire),
        Ambience(name: "Silent winter", firstColor: UIColor(named: Colors.SilentWinter.one)!, secondColor: UIColor(named: Colors.SilentWinter.two)!, image: Images.silentWinter, pathToSound: Sounds.silentWinter),
        Ambience(name: "Urban city", firstColor: UIColor(named: Colors.UrbanCity.one)!, secondColor: UIColor(named: Colors.UrbanCity.two)!, image: Images.urbanCity, pathToSound: Sounds.urbanCity),
        Ambience(name: "Sea waves", firstColor: UIColor(named: Colors.SeaWaves.one)!, secondColor: UIColor(named: Colors.SeaWaves.two)!, image: Images.seaWaves, pathToSound: Sounds.seaWaves),
        Ambience(name: "Magic", firstColor: UIColor(named: Colors.Magic.one)!, secondColor: UIColor(named: Colors.Magic.two)!, image: Images.magic, pathToSound: Sounds.magic),
        Ambience(name: "Calm underwater", firstColor: UIColor(named: Colors.CalmUnderwater.one)!, secondColor: UIColor(named: Colors.CalmUnderwater.two)!, image: Images.calmUnderwater, pathToSound: Sounds.calmUnderwater)
    ]
    
    
}
