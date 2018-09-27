//
//  ViewController.swift
//  Guessing-Game
//
//  Created by Matthew Riley on 9/21/18.
//  Copyright © 2018 Matthew Riley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Created outlets for all labels, buttons, and text field so they can be used below
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var guessingStatusLabel: UILabel!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var resetButtonText: UIButton!
    @IBOutlet weak var submitButtonText: UIButton!
    @IBOutlet weak var timesPlayedLabel: UILabel!
    
    // Variable for random number to be reset after each game
    var randomNumber = 0
    // Variable for number of tries user gets
    var numberOfTries = 0
    // Variable for times played and set it to zero. (One will be added each time reset button function is tapped)
    var timesPlayed = 0
    // variable optional for user guesses (Set as optional nil so it can be verified below)
    var guessedNumber: Int? = nil
    
    // Reset function to be run when screen loads and each time reset button it tapped
    func reset() {
        // Creates a random number
        randomNumber = Int(arc4random_uniform(100)) + 1
        // Sets number of tries
        numberOfTries = 5
        // Puts input text field back on screen for resets
        userInputTextField.isHidden = false
        // Sets text in guessingStatusLabel
        guessingStatusLabel.text = "Guess number between 1 and 100"
        // Sets text for attemptsLabel
        attemptsLabel.text = "Attempts left: \(numberOfTries)"
        // Sets text for timesPlayedLabel
        timesPlayedLabel.text = "Number of times you have played: \(timesPlayed)"
        // Shows submitButton again
        submitButtonText.isHidden = false
        // Sets userInputTextField back to an empty string
        userInputTextField.text = ""
        // Sets text for userInputTextField placeholder
        userInputTextField.placeholder = "Enter Guess Here"
        // Sets background color
        self.view.backgroundColor = UIColor.brown
        // Enables sumbitButton
        submitButtonText.isEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Sets text for greetingLabel
        greetingLabel.text = "Welcome to the Guessing Game"
        // Runs reset function
        reset()
    }
    
    // Fuction runs when reset button it tapped
    @IBAction func resetButtonTapped(_ sender: Any) {
        // Adds to timesPlayed
        timesPlayed += 1
        // Runs reset function
        reset()
        // Sets placeholder to an empty string (User knows where to enter guess after playing the first time)
        userInputTextField.placeholder = ""
    }
    
    // Function runs when user taps inside text field
    @IBAction func tappedInsideTextField(_ sender: Any) {
        // Sets placeholder to an empty string (So it is easier for user to enter guess)
        userInputTextField.placeholder = ""
    }
    // Function runs when Submit button is tapped
    @IBAction func submitButtonTapped(_ sender: Any) {
        // Reveals number is user enters easter egg password
        if userInputTextField.text == "Show Answer" {
            guessingStatusLabel.text = "The number is: \(String(randomNumber))"
            return
        }
        // Verifies user inputs an integer and that the integer is between the bounds of the random number
        if let textFieldAsANumber = Int(userInputTextField.text!) {
            if textFieldAsANumber >= 1 && textFieldAsANumber <= 100 {
                guessedNumber = textFieldAsANumber
            } else {
                // Changes guessingStatusLabel to "Please enter a number between 1 and 100" when user enters an integer out of the bounds. Also, return ends the submitButtonTapped function.
                guessingStatusLabel.text = "Please enter a number between 1 and 100"
                return
            }
        } else {
            // Changes guessingStatusLabel to "Invalid entry. Please enter a number" when user doesn't enter an integer. Also, return ends the submitButtonTapped function.
            guessingStatusLabel.text = "Invalid entry. Please enter a number"
            return
        }
        // Safely unwraps guessedNumber to be used throughout the rest of the function (If it is equal to nil it will end the submitButtonTapped function)
        guard let guessedNumber = guessedNumber else {
            return
        }
        // Runs through these else if statements if numberOfTries is not equal to zero
        if numberOfTries != 0 {
            // If random number is guessed, then user will be told they won, background color will be changed and submit button will be disabled and hidden
            if guessedNumber == randomNumber {
                guessingStatusLabel.text = "YOU WON!!!"
                submitButtonText.isEnabled = false
                submitButtonText.isHidden = true
                self.view.backgroundColor = UIColor.blue
                // If guess is too high, then try/attempt will be removed and user will be told to Guess Lower
            } else if guessedNumber > randomNumber {
                numberOfTries -= 1
                guessingStatusLabel.text = "Guess Lower"
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
                // If guess is too high, then try/attempt will be removed and user will be told to Guess Lower
            } else if guessedNumber < randomNumber {
                numberOfTries -= 1
                guessingStatusLabel.text = "Guess Higher"
                attemptsLabel.text = "Attempts left: \(numberOfTries)"
            }
        }
        
        // If user runs out of tries, then user will be told game is over and told what the random number was. Also, background color will be changed and submit button will be disabled and hidden.
        if numberOfTries == 0 {
            guessingStatusLabel.text = "GAME OVER!!! The answer was \(randomNumber)"
            submitButtonText.isHidden = true
            userInputTextField.isHidden = true
            self.view.backgroundColor = UIColor.red
        }
    }
}

/*
INSTRUCTIONS
1. Allow the user to select an upper bound for the selected random number.
2. Add functionality to store how many times the user has played the game, how many times they’ve won, and how many times they have lost.
3. As an extra challenge, try to figure out how to put this information on another screen.
4. Add functionality to allow the user to customize the game in different ways (such as by changing the background color).
5. As an extra challenge, try to figure out how to do this on another screen.
*/



