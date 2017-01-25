//
//  semestralkaTests.swift
//  semestralkaTests
//
//  Created by Filip Sakala.
//  Copyright © 2017 Filip Sakala. All rights reserved.
//

import XCTest
@testable import semestralka

class semestralkaTests: XCTestCase {
    let model = Model.instance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testXPAdding() {
        let xp = model.getXP()
        model.addXPFromSteps(steps: 20)
        XCTAssert(xp < model.getXP())
    }
    
    func testLeveling() {
        //let xp = model.getXP()
        let level = model.getLevel()
        let differenceXP = model.getNextLevelXP()
        model.player.xp += differenceXP
        XCTAssert(level + 1 == model.getLevel())
        //XCTAssert(level + 1 != model.getLevel())
    }
    
    func testActualPlace(){
        let a = Place(name: "Hello", x: 10, y: 10)
        model.player.actualPlace = a
        XCTAssert(model.isActualPlace(place: a) == true)
    }
    
    func testAddWalkedSteps(){
        let a = Place(name: "Hello", x: 10, y: 10)
        let b = Place(name: "World", x: 10, y: 20) // distance 10
        let p = Path(from: a, to: b)
        model.player.walkingPath = p
        let xp = model.getXP()
        let s = model.player.walkingPath!.walkedSteps
        
        model.addWalkedSteps(steps: 1)
        XCTAssert(xp == model.getXP())
        XCTAssert(model.player.walkingPath!.walkedSteps == s + 1)
        model.addWalkedSteps(steps: 9)
        XCTAssert(xp != model.getXP())
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
