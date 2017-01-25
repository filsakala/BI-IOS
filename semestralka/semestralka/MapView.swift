//
//  MapView.swift
//  semestralka
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import UIKit

class MapView: UIView {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var place1: UIButton!
    @IBOutlet weak var place2: UIButton!
    @IBOutlet weak var place3: UIButton!
    @IBOutlet weak var place4: UIButton!
    @IBOutlet weak var place5: UIButton!
    @IBOutlet weak var place6: UIButton!
    @IBOutlet weak var place7: UIButton!
    @IBOutlet weak var place8: UIButton!
    @IBOutlet weak var place9: UIButton!
    @IBOutlet weak var place0: UIButton!
    var pathsToDraw = [[Int]]()
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var distanceCnt: UILabel!
    @IBOutlet weak var rewardCnt: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var stepProgress: UIProgressView!
    @IBOutlet weak var stepProgressLabel: UILabel!
    
    func drawHome(x: Int, y: Int){
        self.homeButton.frame = CGRect(x: x, y: y, width: 50, height: 50)
    }
    
    func drawPlace(x: Int, y: Int, index: Int, isActual: Bool){
        var buttonPlaces: [UIButton] = [UIButton]()
        buttonPlaces.append(contentsOf: [place0, place1, place2, place3, place4, place5, place6, place7, place8, place9])
        buttonPlaces[index].frame = CGRect(x: x, y: y, width: 30, height: 30)
        if(isActual){
            buttonPlaces[index].setBackgroundImage(UIImage(named: "MarkerFilled"), for: .normal)
        } else {
            buttonPlaces[index].setBackgroundImage(UIImage(named: "Marker"), for: .normal)
        }
    }
    
    func drawPath(fromX: Int, fromY: Int, toX: Int, toY: Int, isWalkingPath: Bool){
        let isW = isWalkingPath ? 1 : 0
        pathsToDraw.append([fromX, fromY, toX, toY, isW])
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for i in 0...(pathsToDraw.count - 1) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: pathsToDraw[i][0] + 15, y: pathsToDraw[i][1] + 15))
            path.addLine(to: CGPoint(x: pathsToDraw[i][2] + 15, y: pathsToDraw[i][3] + 15))
            path.close()
            if(pathsToDraw[i][4] == 1){ // isWalkingPath
                UIColor.red.set()
            } else {
                UIColor.black.set()
            }
            path.stroke()
            path.fill()
        }
    }
    
    func updateSelectedPlaceName(name: String) {
        self.placeName.text = name
    }
    
    func updateDistanceToSelectedPlace(distance: Int) {
        self.distanceCnt.text = "distance: \(distance) steps"
    }
    
    func updateRewardXPToSelectedPlace(xp: Int, isConnected: Bool) {
        if(isConnected){
            self.rewardCnt.text = "reward: \(xp) xp"
            self.goButton.isEnabled = true
        } else {
            self.rewardCnt.text = "No path"
            self.goButton.isEnabled = false
        }
    }
    
    func updateStepProgress(walked: Int, toWalk: Int, fromName: String?, toName: String?){
        self.stepProgress.progress = Float(walked) / Float(toWalk)
        var text = "\(walked)/\(toWalk) steps"
        if(fromName != nil && toName != nil) {
            text += " (\(fromName!)-\(toName!))"
        }
        
        self.stepProgressLabel.text = text
    }
}
