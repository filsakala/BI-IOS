//
//  RewardView.swift
//  semestralka
//
//  Created by Filip Sakala on 25.1.17.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit

class RewardView: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func openReward(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "XP"), for: .normal)
        let r = arc4random_uniform(75) + 25
        Model.instance.player.xp += Int(r)
        descriptionLabel.text = "+\(r) XP!!"
    }
    

}
