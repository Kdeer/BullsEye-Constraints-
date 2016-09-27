//
//  ViewController.swift
//  BullsEye
//
//  Created by Xiaochao Luo on 2016-09-23.
//  Copyright © 2016 Xiaochao Luo. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        score += points
    
        let title: String
        if difference == 0 {
            score += 10
            points += 10
            title = "Perfect!" + " Have 10 bonus!"
        } else if difference < 5 {
            score += 5
            points += 5
            title = "You almost had it!" + " 5 bonus!"
        } else if difference < 10 {
            score += 1
            points += 1
            title = "Pretty good!" + " Here 1 bonus"
        } else {
            title = "Not even close..."
        }

        let message1 = "You scored \(points) points"
        let alert = UIAlertController(title: title,
                                      message: message1,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: { action in
                                    self.startNewRound()
                                    self.updateLabels()
                                    })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print("The value of the slider is now: \(currentValue), \(slider.value)")
    }
    
    @IBAction func startOver(_ sender: AnyObject) {
        
        startNewGame()
        updateLabels()
        
        //Core Animation Crossfade
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
        
    }
    
    
    
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    

}

