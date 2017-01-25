//
//  Place.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import Foundation

class Place {
    var name: String
    var x: Int, y: Int
    
    init(name: String, x: Int, y: Int){
        self.name = name
        self.x = x
        self.y = y
    }
    
    // Euclidean (L2) distance
    private func edistance(place: Place) -> Double {
        return sqrt(
            pow(Double(self.x - place.x), 2) +
                pow(Double(self.y - place.y), 2)
        )
    }
    
    // Distance to another place in steps
    func stepDistance(place: Place) -> Int {
        return Int(edistance(place: place))
    }
}
