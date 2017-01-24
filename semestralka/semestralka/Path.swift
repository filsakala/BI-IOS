//
//  Path.swift
//  semestralka
//
//  Created by Filip Sakala on 24.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import Foundation

class Path {
    var from: Place
    var to: Place
    var reward: Int
    var walkedSteps = 0
    
    init(from: Place, to: Place){
        self.from = from
        self.to = to
        reward = from.stepDistance(place: to)
    }
    
    func stepsToWalk() -> Int {
        return from.stepDistance(place: to) - walkedSteps
    }
    
}
