//
//  MapViewController.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit
import CoreMotion

class MapViewController: UIViewController {
    var model: Model = Model.instance
    var selectedPlace: Place?
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        cal.timeZone = TimeZone.current
        let midnightOfToday = cal.date(from: comps)!
        
        // Run only in Physical Device, iOS
        if(CMPedometer.isStepCountingAvailable()){
            self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        self.updateView()
                    }
                })
            }
        }
        // casting
        if let mview = view as? MapView {
            mview.drawHome(x: model.home.x, y: model.home.y)
            for i in 0...(model.places.count - 1) {
                mview.drawPlace(x: model.places[i].x, y: model.places[i].y, index: i, isActual: model.isActualPlace(place: model.places[i]))
            }
            mview.pathsToDraw = []
            for i in 0...(model.paths.count - 1) {
                let p = model.paths[i]
                mview.drawPath(fromX: p.from.x, fromY: p.from.y,
                               toX: p.to.x, toY: p.to.y, isWalkingPath: model.isWalkingPath(path: p))
            }
        }
    }
    
    private func getPathWithPlaces(from: Place, to: Place) -> Path? {
        for i in 0...(model.paths.count - 1) {
            let f = model.paths[i].from
            let t = model.paths[i].to
            if(from.name == f.name && to.name == t.name){
                return model.paths[i]
            }
            if(from.name == t.name && to.name == f.name){
                return model.paths[i]
            }
        }
        return nil // not found
    }
    
    @IBAction func placeClick(_ sender: UIButton) {
        print("Place clicked \(sender.accessibilityIdentifier)")
        if(sender.accessibilityIdentifier != nil){
            if(sender.accessibilityIdentifier == "home"){ // do sth with actual state and home
                selectedPlace = model.home
            } else {
                let selectedPlaceNo = Int(sender.accessibilityIdentifier!)
                selectedPlace = model.places[selectedPlaceNo!]
            }
            
            // you have the selectedPlace, do the logic
            updateView()
        }
    }
    
    @IBAction func goClick(_ sender: UIButton) {
        if(model.player.walkingPath == nil && self.selectedPlace != nil) {
            let actualPlace = model.getActualPlace()
            model.player.walkingPath = self.getPathWithPlaces(from: actualPlace, to: selectedPlace!)
            print("Walking to \(selectedPlace!.name)")
            updateView()
        }
    }
    
    private func updateView() {
        if let mview = view as? MapView {
            mview.drawHome(x: model.home.x, y: model.home.y)
            for i in 0...(model.places.count - 1) {
                let p = model.places[i]
                mview.drawPlace(x: p.x, y: p.y, index: i, isActual: model.isActualPlace(place: p))
            }
            mview.pathsToDraw = [] // delete paths
            for i in 0...(model.paths.count - 1) {
                let p = model.paths[i]
                mview.drawPath(fromX: p.from.x, fromY: p.from.y,
                               toX: p.to.x, toY: p.to.y, isWalkingPath: model.isWalkingPath(path: p))
            }
            if(selectedPlace != nil){
                let actualPlace = model.getActualPlace()
                let path: Path? = self.getPathWithPlaces(from: actualPlace, to: selectedPlace!)
                if(selectedPlace === model.player.walkingTo()){
                    mview.updateSelectedPlaceName(name: "\(selectedPlace!.name) (walking)")
                } else {
                    mview.updateSelectedPlaceName(name: selectedPlace!.name)
                }
            
                let distance = selectedPlace!.stepDistance(place: actualPlace)
                mview.updateDistanceToSelectedPlace(distance: distance)
                
                if ((path) != nil){
                    mview.updateRewardXPToSelectedPlace(xp: path!.reward, isConnected: true)
                } else {
                    mview.updateRewardXPToSelectedPlace(xp: 0, isConnected: false)
                }
            }
            if(model.player.walkingPath != nil){
                mview.updateStepProgress(walked: model.player.walkingPath!.walkedSteps, toWalk: model.player.walkingPath!.stepsToWalk() + model.player.walkingPath!.walkedSteps, fromName: model.player.walkingPath!.from.name, toName: model.player.walkingPath!.to.name)
                mview.goButton.isEnabled = false
            } else {
                mview.updateStepProgress(walked: 0, toWalk: 0, fromName: nil, toName: nil)
                mview.goButton.isEnabled = true
            }
            mview.setNeedsDisplay()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
