//
//  HomeViewController.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit
import CoreMotion

class HomeViewController: UIViewController {
    var days:[String] = []
    var stepsTaken:[Int] = []
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var actualLevel: UILabel!
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    let model = Model.instance // Singleton
    var prevStepCount = -1 // Step count from previous update
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pedometer
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
                        //print("\(data!.numberOfSteps)")
                        // Casting to HomeView
                        if let v = self.view as? HomeView {
                            v.updateStepCount(stepCount: Int(data!.numberOfSteps))
                            
                            // Get the step difference, add players's XP and lower distance in path (toWalk) if exists
                            if(self.prevStepCount != -1) { // you can count the difference
                                let diff = Int(data!.numberOfSteps) - self.prevStepCount
                                self.model.addXPFromSteps(steps: diff)
                                v.updateXP(actualXP: self.model.getXP(), nextLevelXP: self.model.getNextLevelXP())
                                self.model.addWalkedSteps(steps: diff) // check walking paths
                            }
                            self.prevStepCount = Int(data!.numberOfSteps)
                            v.updateLevel(level: self.model.getLevel())
                        }
                    }
                })
            }
        }
    }

}
