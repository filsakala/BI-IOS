//
//  Player.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import Foundation

class User {
    var name: String = "Filip"
    var xp: Int = 0
    var actualPlace: Place?
    var walkingPath: Path?
    
    // Easy leveling rule: Geometric series (1000 * 2^level) = XP to get
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
    
    // Get destination of walking path
    func walkingTo() -> Place? {
        if(walkingPath != nil) {
            if(walkingPath!.from.name == actualPlace!.name){
                return walkingPath!.to
            } else {
                return walkingPath!.from
            }
        }
        return nil
    }
    
}
