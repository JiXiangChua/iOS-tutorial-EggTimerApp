//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //creating a dictionary called eggTimes
    let eggTimes = [
        //key: value
        "Soft": 3, //original 300 seconds (5 min)
        "Medium": 4, //original 420 seconds (7 min)
        "Hard": 7 //original 720 seconds (12 min)
    ]

    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer!

    @objc func updateTimer() { //@objc means objective c due to the #selector function
        //example functionality
        if secondsPassed < totalTime {
            //print("\(secondsPassed) seconds.")
            secondsPassed += 1 //have to place this at the front so that our progress bar can show 100% due to the conditions we set it to be secondPassed < totalTime
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            print(percentageProgress)
            
            progressBar.progress = percentageProgress //progress property takes in a floating number.
            
        } else {
            timer.invalidate() // to stop the timer from running
            titleLabel.text = "DONE!" //change the label to DONE when the timer reaches 0
            playAlarm()
            
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //print(sender.currentTitle!)
        //When the button is pressed again, we want to stop the timer so that it can create a brand new timer rather than stacking ontop of the eariler Timer.scheduledTimer function which makes it run twice as fast since the first function is still on going.
        timer.invalidate()
        
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        //print(eggTimes[hardness]!) //We have to add ! to the key becuz of how swift dictionaries work.
        //swift dictionaries returns a optional datatype value.
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //timeInterval - how often do you want the timer to fire in seconds
        // repeats: true becuz we want this function to repeat every second
        
        //reset the progress bar to 0, seconds passed to 0 and the label everytime the user press another button again.
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
    

    }
    
    func playAlarm(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!) //put the music file in our player
        player.play() //play the sound
    }
}
