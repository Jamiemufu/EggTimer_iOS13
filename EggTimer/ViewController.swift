//
//  ViewController.swift
//  EggTimer
//
//  Created by Jamie Ecans on 20/11/2019.
//  Copyright © 2019 JE Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var secondsRemaining = 60
    var increment: Float = 1.0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        progressBar.progress = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        secondsRemaining = eggTime[hardness]!
        increment = 1 / Float(secondsRemaining)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            progressBar.progress += increment
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            progressBar.progress = 1.0
        }
    }
}
