//
//  ViewController.swift
//  hit-me-app
//
//  Created by Shreya Randive on 8/29/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targeLbl: UILabel!
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentRoundLbl: UILabel!
    @IBOutlet weak var totalScoreLbl: UILabel!
    
    var sliderValue = 0
    var targetValue = 0
    var totalScore = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = Int(slider.value)
        startNewGame()
        
        let thumbImgNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImgNormal, for: .normal)
        
        let thumbImgHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImgHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let traackLeftImg = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = traackLeftImg.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImg = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImg.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func hitmMeBtnPressed(_ sender: Any) {
        score = 100 - abs(targetValue - sliderValue)
        let title: String
        
        if score == 100 {
            title = "Perfect!\nBonus points: 100"
            score += 100
        } else if score == 99 {
            title = "Oof! That was close!\nBonus point: 50"
            score += 50
        } else if score >= 95 {
            title = "Almost had it!"
        } else if score >= 90 {
            title = "Still good"
        } else {
            title = "Not even close..."
        }
        
        let message: String = "You scored: \(score)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cool!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        sliderValue = Int(slider.value.rounded())
    }
    
    @IBAction func startOverBtnPressed(_ button: UIButton) {
        startNewGame()
    }
    
    func startNewRound() {
        round += 1
        totalScore += score
        targetValue = Int.random(in: 1...100)
        sliderValue = 50
        slider.value = Float(sliderValue)
        updateLabels()
    }
    
    func startNewGame() {
        totalScore = 0
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targeLbl.text = String(targetValue)
        totalScoreLbl.text = String(totalScore)
        currentRoundLbl.text = String(round)
    }
}

