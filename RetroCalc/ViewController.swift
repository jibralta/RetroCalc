//
//  ViewController.swift
//  RetroCalc
//
//  Created by Gladys Umali on 10/10/16.
//  Copyright © 2016 Joy Umali. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty  // operation will be empty when first opening
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)  // ! for unwrapping. telling it that it does exist.
    
    do {
        
        try btnSound = AVAudioPlayer(contentsOf: soundURL)  // anything that says throws needs a do and a catch
        btnSound.prepareToPlay()
        
    } catch let err as NSError {
        
        print(err.debugDescription)
        
        }
        
        outputLbl.text = "0"
}
    
    @IBAction func numberPressed(sender:UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMutiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
        runningNumber = "0"
    }
    
    func playSound() {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func processOperation(operation:Operation) { // This function is called whenever an operator is pressed.  See above IBActions.
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // A user selected an operator, but then selected another operator without first entering a number.
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
//                runningNumber = ""
            }
            
            currentOperation = operation
            
        } else {
            // This is the first time an operator has been pressed.
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

}


