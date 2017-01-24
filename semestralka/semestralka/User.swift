//
//  Player.swift
//  semestralka
//
//  Created by Filip Sakala on 23.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import Foundation

class User {
    var name = "Filip"
    var xp = 0
    var actualPlace: Place?
    var walkingPath: Path?
    
    // Easy leveling rule: Geometric series (1000 * 2**level) = XP to get
    func getLevel() -> Int{
        if(self.xp > 100){
            return Int(floor(log2(Double(self.xp) / 100))) + 1
        } else {
            return 0
        }
    }
    
    func getNextLevelXP() -> Int {
        return 100 * Int(pow(Double(2), Double(getLevel())))
    }
    
}
