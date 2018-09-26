//
//  ViewController.swift
//  Guessing-Game
//
//  Created by Matthew Riley on 9/21/18.
//  Copyright © 2018 Matthew Riley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var guessingStatusLabel: UILabel!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var resetButtonText: UIButton!
    @IBOutlet weak var submitButtonText: UIButton!
    @IBOutlet weak var timesPlayedLabel: UILabel!
    
    var randomNumber = 0
    var numberOfTries = 5
    var timesPlayed = 0
    var guessedNumber: Int? = nil

    
    func reset() {
        randomNumber = Int(arc4random_uniform(100)) + 1
        numberOfTries = 5
        userInputTextField.isHidden = false
        guessingStatusLabel.text = "Guess number between 1 and 100"
        guessedNumber = nil
        attemptsLabel.text = "Attempts left: \(numberOfTries)"
        timesPlayedLabel.text = "Number of times you have played: \(timesPlayed)"
        submitButtonText.isHidden = false
        userInputTextField.text = ""
        userInputTextField.placeholder = "Enter Guess Here"
        greetingLabel.text = "Welcome to the Guessing Game"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reset()
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timesPlayed += 1
        reset()
        userInputTextField.placeholder = ""
    }
    
    @IBAction func test(_ sender: Any) {
        userInputTextField.placeholder = ""
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if userInputTextField.text == "Show Answer" {
            guessingStatusLabel.text = "The number is: \(String(randomNumber))"
            return
        }
        
        if let textFieldAsANumber = Int(userInputTextField.text!) {
            if textFieldAsANumber >= 1 && textFieldAsANumber <= 100 {
                guessedNumber = textFieldAsANumber
            } else {
                guessingStatusLabel.text = "Please enter a number between 1 and 100"
                guessedNumber = nil
                return
            }
        } else {
            guessingStatusLabel.text = "Invalid entry. Please enter a number"
            guessedNumber = nil
            return
        }
        
        guard let guessedNumber = guessedNumber else {
            return
        }
        
        if numberOfTries != 0 {
            if guessedNumber == randomNumber {
                guessingStatusLabel.text = "YOU WON!!!"
                submitButtonText.isEnabled = false
            } else if guessedNumber > randomNumber {
                numberOfTries -= 1
                guessingStatusLabel.text = "Guess Lower"
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
            } else if guessedNumber < randomNumber {
                numberOfTries -= 1
                guessingStatusLabel.text = "Guess Higher"
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
            }
        }
        
        if numberOfTries == 0 {
            guessingStatusLabel.text = "GAME OVER!!! The answer was \(randomNumber)"
            submitButtonText.isHidden = true
            userInputTextField.isHidden = true
        }
    }
}



