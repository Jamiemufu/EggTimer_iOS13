//
//  ViewController.swift
//  EggTimer
//
//  Created by Jamie Ecans on 20/11/2019.
//  Copyright © 2019 JE Design. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    // consts - dict
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var secondsRemaining = 60
    // initialise increment as float
    var increment: Float = 1.0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // set hardness from button title
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        // rset default label
        titleLabel.text = "How do you like your eggs?"
        // set default progress percentange
        progressBar.progress = 0
        // reset timer
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        // set to dict key:value
        secondsRemaining = eggTime[hardness]!
        // calculate increment percentage based on secondsRemaning to be added each second to progressBar
        increment = 1 / Float(secondsRemaining)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            // increment progressBar
            secondsRemaining -= 1
            progressBar.progress += increment
        } else {
            // play alarm
             playSound(soundFile: "alarm")
            // reset time
            timer.invalidate()
            titleLabel.text = "DONE!"
            // fill progress bar
            progressBar.progress = 1.0
        }
    }
    
    func playSound(soundFile: String) {
        let url = Bundle.main.url(forResource: soundFile, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
