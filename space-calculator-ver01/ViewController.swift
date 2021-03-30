//
//  ViewController.swift
//  space-calculator-ver01
//
//  Created by Oğuz Çörekçioğlu on 30.03.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftVarStr = ""
    var rightVarStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL as URL)
            btnSound.volume = 0.1
            btnSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        if (btn.tag == 10){
            runningNumber = ""
            leftVarStr = ""
            rightVarStr = ""
            result = ""
            currentOperation = Operation.Empty
            outputLbl.text = "0"
        }
    }
    @IBAction func onDividePressed(_ sender: Any) {
        if runningNumber != ""{
            processOperation(op: Operation.Divide)}
        else{
            playSound()
        }
    }
    @IBAction func onMultiplyPressed(_ sender: Any) {
        if runningNumber != "" {
            processOperation(op: Operation.Multiply)}
        else{
            playSound()
        }
    }
    @IBAction func onSubtractPressed(_ sender: Any) {
        if runningNumber != ""{
            processOperation(op: Operation.Subtract)}
        else{
            playSound()
        }
    }
    @IBAction func onAddPressed(_ sender: Any) {
        if runningNumber != "" {
            processOperation(op: Operation.Add)}
        else{
            playSound()
        }
    }
    @IBAction func onEqualPressed(_ sender: Any) {
        if runningNumber != ""{
            processOperation(op: currentOperation)}
        else{
            playSound()
        }
    }
    
    func processOperation(op: Operation){
        playSound()
        
        // This check need to fill rightValue
        if currentOperation != Operation.Empty {
            if runningNumber != ""{
                rightVarStr = runningNumber
                runningNumber = ""
                // Some math Calculation
                if currentOperation == Operation.Divide{
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                }else if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                }
                leftVarStr = result
                outputLbl.text = result
            }
            currentOperation = op
            
        } else {
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }


    
    func playSound()
    {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

