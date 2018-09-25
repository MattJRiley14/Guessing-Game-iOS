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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        greetingLabel.text = "Welcome to the Guessing Game"
        userInputTextField.text = "Enter guess here"
        guessingStatusLabel.text = "Guess a number between 1 and 100"
        attemptsLabel.text = "Attempts left: 5"
        timesPlayedLabel.text = ""
    }
    
    var randomNumber = Int(arc4random_uniform(100)) + 1
    var numberOfTries = 5
    var guessedNumber: Int? = nil
    var timesPlayed = 0
    

    
    @IBAction func resetButtonTapped(_ sender: Any) {
        randomNumber = Int(arc4random_uniform(100)) + 1
        numberOfTries = 5
        userInputTextField.text = "Enter guess here"
        guessingStatusLabel.text = "Guess a number between 1 and 100"
        guessedNumber = nil
        attemptsLabel.text = "Attempts left: \(numberOfTries)"
        timesPlayed += 1
        timesPlayedLabel.text = "Number of times you have played: \(timesPlayed)"
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

        if guessedNumber == randomNumber {
            guessingStatusLabel.text = "YOU WON!!!"
        } else if guessedNumber > randomNumber {
            numberOfTries -= 1
            guessingStatusLabel.text = "Guess Lower"
            if numberOfTries >= 0 {
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
            }
        } else if guessedNumber < randomNumber {
            numberOfTries -= 1
            guessingStatusLabel.text = "Guess Higher"
            if numberOfTries >= 0 {
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
            }
        }
        
        if numberOfTries <= 0 {
            guessingStatusLabel.text = "GAME OVER!!! The answer was \(randomNumber)"
        }
        
    }
    
}



