//
//  MapView.swift
//  semestralka
//
//  Created by Filip Sakala on 24.1.17.
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
    var pathsToDraw = Array<Array<Int>>()
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var distanceCnt: UILabel!
    @IBOutlet weak var rewardCnt: UILabel!
    
    func drawHome(x: Int, y: Int){
        self.homeButton.frame = CGRect(x: x, y: y, width: 50, height: 50)
    }
    
    func drawPlace(x: Int, y: Int, index: Int, isActual: Bool){
        var buttonPlaces = [UIButton]()
        buttonPlaces.appendContentsOf([place0, place1, place2, place3, place4, place5, place6, place7, place8, place9])
        buttonPlaces[index].frame = CGRect(x: x, y: y, width: 50, height: 50)
        if(isActual){
            buttonPlaces[index].setBackgroundImage(UIImage(named: "MarkerFilled"),for: .normal)
        }
    }
    
    func drawPath(fromX: Int, fromY: Int, toX: Int, toY: Int){
        pathsToDraw.append([fromX, fromY, toX, toY])
    }
    
    override func draw(_ rect: CGRect) {
        for i in 0...(pathsToDraw.count - 1) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: pathsToDraw[i][0] + 25, y: pathsToDraw[i][1] + 25))
            path.addLine(to: CGPoint(x: pathsToDraw[i][2] + 25, y: pathsToDraw[i][3] + 25))
            path.close()
            UIColor.black.set()
            path.stroke()
            path.fill()
        }
    }
    
    func updateSelectedPlaceName(name: String) {
        self.placeName.text = name
    }
    
    func updateDistanceToSelectedPlace(distance: Int) {
        self.distanceCnt.text = String(distance)
    }
    
    func updateRewardXPToSelectedPlace(xp: Int) {
        self.rewardCnt.text = String(xp)
    }
    
    
}
