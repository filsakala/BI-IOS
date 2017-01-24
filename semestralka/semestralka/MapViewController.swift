//
//  MapViewController.swift
//  semestralka
//
//  Created by Filip Sakala on 24.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    var model = Model()
    var selectedPlace: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        // casting
        if let mview = view as? MapView {
            mview.drawHome(x: model.home.x, y: model.home.y)
            for i in 0...(model.places.count - 1) {
                mview.drawPlace(x: model.places[i].x, y: model.places[i].y, index: i, isActual: model.isActualPlace(place: model.places[i]))
            }
            mview.pathsToDraw = []
            for i in 0...(model.paths.count - 1) {
                mview.drawPath(fromX: model.paths[i].from.x, fromY: model.paths[i].from.y,
                               toX: model.paths[i].to.x, toY: model.paths[i].to.y)
            }
        }
    
    }
    
    private func getPathWithPlaces(from: Place, to: Place) -> Place? {
        for path in model.paths {
            if((path.from == from && path.to == to) ||
                (path.to == from && path.from == to)){
                return path
            }
        }
        return nil // not found
    }
    
    @IBAction func placeClick(_ sender: UIButton) {
        //print("Place clicked \(sender.accessibilityIdentifier)")
        if(sender.accessibilityIdentifier != nil){
            if(sender.accessibilityIdentifier == "home"){ // do sth with actual state and home
                selectedPlace = model.home
            } else {
                let selectedPlaceNo = Int(sender.accessibilityIdentifier!)
                selectedPlace = model.places[selectedPlaceNo!]
            }
            
            // you got selectedPlace, do the logic
            let path = self.getPathWithPlaces(from: actualPlace, to: selectedPlace)
            if let mview = view as? MapView {
                mview.updateSelectedPlaceName(name: selectedPlace!.name)
                mview.updateDistanceToSelectedPlace(distance: selectedPlace!.stepDistance(place: model.getActualPlace()))
                if (path != nil){
                    mview.updateRewardXPToSelectedPlace(xp: path!.reward)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
