//
//  Model.swift
//  semestralka
//
//  Created by Filip Sakala on 23.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import Foundation
import CoreData

class Model {
    static let instance = Model() // Singleton instance
    var player: User = User()
    var places: [Place] = [Place]()
    var paths: [Path] = [Path]()
    var home: Place
    
    init(){
        // Init places
        places.append(contentsOf: [Place(name: "Ozryn", x: 40, y: 50), Place(name: "Durmchapel", x: 120, y: 40), Place(name: "Marnmouth", x: 200, y: 60), Place(name: "Northwich", x: 250, y: 120), Place(name: "Dunwich", x: 230, y: 200), Place(name: "Craydon", x: 200, y: 270), Place(name: "Lindow", x: 140, y: 320), Place(name: "Nerton", x: 80, y: 280), Place(name: "Aberdyfi", x: 40, y: 200), Place(name: "Everwinter", x: 25, y: 120)
            ])
        home = Place(name: "Home", x: 130, y: 180)
        //places.append(home)
        player.actualPlace = home
        
        // Init paths
        paths.append(contentsOf: [Path(from: places[0], to: places[9]), Path(from: places[0], to: places[8]), Path(from: places[0], to: places[7]), Path(from: places[1], to: places[9]), Path(from: places[1], to: places[8]), Path(from: places[1], to: home), Path(from: places[2], to: places[6]), Path(from: places[2], to: places[5]), Path(from: places[2], to: places[3]), Path(from: places[3], to: places[4]), Path(from: places[3], to: places[5]), Path(from: places[4], to: places[5]), Path(from: places[4], to: places[7]), Path(from: places[6], to: home), Path(from: places[6], to: places[7]), Path(from: places[8], to: home), Path(from: places[8], to: places[9])
            ])
    }
    
    // delegate to Player
    func getLevel() -> Int {
        return player.getLevel()
    }
    
    func addXPFromSteps(steps: Int){
        player.xp += steps
    }
    
    func getXP() -> Int {
        return player.xp
    }
    
    func getNextLevelXP() -> Int {
        return player.getNextLevelXP()
    }
    
    func getActualPlace() -> Place {
        return player.actualPlace!
    }
    
    func isActualPlace(place: Place) -> Bool {
        return (place.name == player.actualPlace!.name)
    }
    
    func isWalkingPath(path: Path) -> Bool {
        if(player.walkingPath == nil){
            return false
        }
        let f = player.walkingPath!.from
        let t = player.walkingPath!.to
        if(path.from.x == f.x && path.from.y == f.y
            && path.to.x == t.x && path.to.y == t.y){
            return true
        }
        return false
    }
    
    // update steps to walk on path
    func addWalkedSteps(steps: Int) {
        if(player.walkingPath != nil) {
            player.walkingPath!.walkedSteps += steps
            if(player.walkingPath!.stepsToWalk() <= 0) {
                // gimme reward
                player.xp += player.walkingPath!.reward
                // Where am I now?
                if(player.walkingPath!.from.name == player.actualPlace!.name){
                    player.actualPlace = player.walkingPath!.to
                } else {
                    player.actualPlace = player.walkingPath!.from
                }
                player.walkingPath!.walkedSteps = 0
                player.walkingPath = nil
            }
        }
    }
}
