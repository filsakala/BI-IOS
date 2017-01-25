//
//  HomeView.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit

class HomeView: UIView {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var xpProgress: UIProgressView!
    
    func updateLevel(level: Int){
        levelLabel.text = "Level \(level)"
    }
    
    func updateStepCount(stepCount: Int){
        stepCountLabel.text = String(stepCount)
    }
    
    func updateXP(actualXP: Int, nextLevelXP: Int){
        xpLabel.text = "XP \(actualXP)/\(nextLevelXP)"
        xpProgress.progress = Float(actualXP) / Float(nextLevelXP)
        // print(xpProgress.progress)
    }
}
