//
//  ViewController.swift
//  BullEye
//
//  Created by Le Minh Dang on 2/6/24.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var roundPlayed: Int = 0
    var score: Int = 0
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetValueLable: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setSliderUI()
        self.startNewGame()

    }
    @IBAction func showAlert(_ sender: Any) {

        var difference: Int
        difference = abs(targetValue - currentValue)
        let point = 10 - difference
        let message: String = "The score is \(point)"
        //
        let title: String
        if difference == 0 {
            title = "Perfect!"
            score += 10
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                score += 5
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        //
        let alert: UIAlertController = UIAlertController(
            title: title, message: message, preferredStyle: .alert
        )
        //
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.startNewRound()
        })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //
        score = score + (point)
        scoreLabel.text = String(score)
        //

    }

    @IBAction func moveSlider(_ slider: UISlider) {
        print("Current slider value: \(slider.value)")
        currentValue = lroundf(slider.value)

    }
    func startNewRound() -> Void {
        roundPlayed += 1
        targetValue = Int.random(in: 0...10)
        currentValue = 0
        slider.value = Float(currentValue)
        updateTargetValueLabel()
    }

    func updateTargetValueLabel() -> Void {
        targetValueLable.text = String(targetValue)
        roundLabel.text = String(roundPlayed)
    }

    func startNewGame() {
        score = 0
        scoreLabel.text = String(score)
        roundPlayed = 0
        startNewRound()
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }
    @IBAction func onStartOver() {
        self.startNewGame()
    }
    
    func setSliderUI() -> Void{
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
}

