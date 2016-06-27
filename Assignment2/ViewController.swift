//
//  ViewController.swift
//  Assignment2
//
//  Created by Tony on 6/26/16.
//  Copyright © 2016 Anthony Cavallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyModelDelegate, UITableViewDataSource, UITableViewDelegate {
    var delegate: MyModelDelegate!
    var model: MyModel!
    var running = false
    
    @IBOutlet var mainTimer: UILabel!
    @IBOutlet var lapTimer: UILabel!
    
    @IBOutlet var lapsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = MyModel(delegate: self)
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        
        setupButtonDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBAction func startButton(sender: AnyObject) {
        if running == false {
            model.createTimer()
            
            startButtonOutlet.setTitle("Stop", forState: .Normal)
            startButtonOutlet.setTitleColor(UIColor.redColor(), forState: .Normal)
            startButtonOutlet.layer.borderColor = UIColor.redColor().CGColor
            
            resetButtonOutlet.enabled = true
            resetButtonOutlet.setTitle("Lap", forState: .Normal)
            running = true
        } else {
            startButtonOutlet.setTitle("Resume", forState: .Normal)
            startButtonOutlet.layer.borderColor = UIColor.greenColor().CGColor
            startButtonOutlet.setTitleColor(UIColor.greenColor(), forState: .Normal)
            resetButtonOutlet.setTitle("Reset", forState: .Normal)
            
            model.stopTime()
            running = false
        }
    }
    
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBAction func resetButton(sender: AnyObject) {
        if running == true {
            model.createLapTimer()
            lapsTableView.reloadData()
        } else {
            model.lapTimesArray.removeAllObjects()
            lapsTableView.reloadData()
            resetButtonOutlet.enabled = false
            
            model.resetTime()
            
            startButtonOutlet.setTitle("Start", forState: .Normal)
            startButtonOutlet.setTitleColor(UIColor.greenColor(), forState: .Normal)
            startButtonOutlet.layer.borderColor = UIColor.greenColor().CGColor
            
            resetButtonOutlet.setTitle("Reset", forState: .Normal)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.lapTimesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! LapCell
        cell.lapNumber.text = String(format: "Lap %i", (model.lapTimesArray.count - indexPath.row))
        cell.lapTime.text = String(format: "%@", (model.lapTimesArray[indexPath.row] as? String)!)
       // textLabel?.text = String(format: "Lap %2i\t\t%@", (model.lapTimesArray.count - indexPath.row), (model.lapTimesArray[indexPath.row] as? String)!)
        
        return cell
    }
    
    func updateTimerLabels(mainTime: String, lapTime: String) {
        mainTimer.text = mainTime
        lapTimer.text = lapTime
    }
    
    func setupButtonDisplay() {
        
    }

}

