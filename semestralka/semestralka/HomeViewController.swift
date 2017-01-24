//
//  HomeViewController.swift
//  semestralka
//
//  Created by Filip Sakala on 23.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit
import CoreMotion

class HomeViewController: UIViewController {
    var days:[String] = []
    var stepsTaken:[Int] = []
    @IBOutlet weak var stepCount: UILabel!
    var prevStepCount = -1
    @IBOutlet weak var actualLevel: UILabel!
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = TimeZone.current
        cal.timeZone = timeZone
        
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
                            
                            // If you can get the difference, you can add players's XP and lower distance in path (toWalk) if exists
                            if(self.prevStepCount != -1) { // you can count the difference
                                self.model.addXPFromSteps(steps: Int(data!.numberOfSteps) - self.prevStepCount)
                                v.updateXP(actualXP: self.model.getXP(), nextLevelXP: self.model.getNextLevelXP())
                            }
                            self.prevStepCount = Int(data!.numberOfSteps)
                            v.updateLevel(level: self.model.getLevel())
                        }
                    }
                })
            }
        }
    }}
