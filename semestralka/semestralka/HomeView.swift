//
//  HomeView.swift
//  semestralka
//
//  Created by Filip Sakala on 23.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit

class HomeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
