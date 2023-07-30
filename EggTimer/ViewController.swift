//
//  ViewController.swift
//  EggTimer
//
//  Created by Ahmed Alaa on 10/06/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Mark: - Outlets.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //Mark: - Propreties.
    var eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer!
    
    //Mark: - Actions.
    @IBAction func hardnessSelected(_ sender: UIButton) {
       
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownTimer), userInfo:nil, repeats: true)
    }
    @objc func countDownTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
    }
}
   //Mark : - SoundAlert extension.
extension ViewController {
    private func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}


