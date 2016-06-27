//
//  Model.swift
//  Assignment2
//
//  Created by Tony on 6/27/16.
//  Copyright © 2016 Anthony Cavallo. All rights reserved.
//

import Foundation

@objc protocol MyModelDelegate: class {
    func updateTimerLabels(mainTime: String, lapTime: String)
}
class MyModel: NSObject {
    weak var delegate: MyModelDelegate?
    
    init(delegate: MyModelDelegate) {
        self.delegate = delegate
    }
    
    private var mainTimer: NSTimeInterval = 0.0
    private var lapTimer: NSTimeInterval = 0.0
    
    private var stoppedMainTime: NSTimeInterval = 0.0
    private var stoppedLapTime: NSTimeInterval = 0.0
    
    private var mainTimeSinceLastUpdate: NSTimeInterval = 0.0
    private var lapTimeSinceLastUpdate: NSTimeInterval = 0.0
    
    private var myTimer: NSTimer = NSTimer()
    
    var lapTimesArray: NSMutableArray = NSMutableArray()
    
    private(set) var newMainTime = ""
    private(set) var newLapTime = ""
    
    func createTimer() {
        if(!myTimer.valid) {
            mainTimer = NSDate.timeIntervalSinceReferenceDate()
            lapTimer = NSDate.timeIntervalSinceReferenceDate()
            
            myTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(MyModel.updateTimer), userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(myTimer, forMode: NSRunLoopCommonModes)
        }
    }
    
    func updateTimer() {
        let currentMainTime = NSDate.timeIntervalSinceReferenceDate()
        let currentLapTime = currentMainTime
        
        mainTimeSinceLastUpdate = currentMainTime - mainTimer + stoppedMainTime
        var tempTime = mainTimeSinceLastUpdate
        
        let mainMinutes = UInt32(tempTime / 60)
        tempTime -= (NSTimeInterval(mainMinutes) * 60)
        
        let mainSeconds = UInt32(tempTime)
        tempTime -= NSTimeInterval(mainSeconds)
        
        let mainMilliseconds = UInt32(tempTime * 100)
        
        newMainTime = String(format: "%02i:%02i.%02i", mainMinutes, mainSeconds, mainMilliseconds)
        
        lapTimeSinceLastUpdate = currentLapTime - lapTimer + stoppedLapTime
        tempTime = lapTimeSinceLastUpdate
        
        let lapMinutes = UInt32(tempTime / 60)
        tempTime -= (NSTimeInterval(lapMinutes) * 60)
        
        let lapSeconds = UInt32(tempTime)
        tempTime -= NSTimeInterval(lapSeconds)
        
        let lapMilliseconds = UInt32(tempTime * 100)
        
        newLapTime = String(format: "%02i:%02i.%02i", lapMinutes, lapSeconds, lapMilliseconds)
        
        if(delegate != nil) {
            
        }
    }
}