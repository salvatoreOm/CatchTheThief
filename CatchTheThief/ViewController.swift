//
//  ViewController.swift
//  CatchTheThief
//
//  Created by Om Parihar on 20/03/24.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var thiefArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var thief1: UIImageView!
    @IBOutlet weak var thief2: UIImageView!
    @IBOutlet weak var thief3: UIImageView!
    @IBOutlet weak var thief4: UIImageView!
    @IBOutlet weak var thief5: UIImageView!
    @IBOutlet weak var thief6: UIImageView!
    @IBOutlet weak var thief7: UIImageView!
    @IBOutlet weak var thief8: UIImageView!
    @IBOutlet weak var thief9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //images
        scoreLabel.text = "Score: \(score)"
        
        //Check HighScore
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        
        thief1.isUserInteractionEnabled = true
        thief2.isUserInteractionEnabled = true
        thief3.isUserInteractionEnabled = true
        thief4.isUserInteractionEnabled = true
        thief5.isUserInteractionEnabled = true
        thief6.isUserInteractionEnabled = true
        thief7.isUserInteractionEnabled = true
        thief8.isUserInteractionEnabled = true
        thief9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        thief1.addGestureRecognizer(recognizer1)
        thief2.addGestureRecognizer(recognizer2)
        thief3.addGestureRecognizer(recognizer3)
        thief4.addGestureRecognizer(recognizer4)
        thief5.addGestureRecognizer(recognizer5)
        thief6.addGestureRecognizer(recognizer6)
        thief7.addGestureRecognizer(recognizer7)
        thief8.addGestureRecognizer(recognizer8)
        thief9.addGestureRecognizer(recognizer9)
        
        
        thiefArray = [thief1,thief2,thief3,thief4,thief5,thief6,thief7,thief8,thief9]
        
        
        //Timer
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideThief), userInfo: nil, repeats: true)
        hideThief()
        
    }
    
    @objc func hideThief(){
        for thief in thiefArray{
            thief.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(thiefArray.count - 1)))
        thiefArray[random].isHidden = false
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for thief in thiefArray{
                thief.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore : \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) 
            { (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideThief), userInfo: nil, repeats: true)
                 
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

