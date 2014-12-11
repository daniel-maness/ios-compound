//
//  GameViewController.swift
//  Compound
//
//  Created by Daniel Maness on 12/4/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    let businessLogic = BusinessLogic()
    
    var scene: GameScene!
    var challenge: Challenge!
    var totalPoints: Int = 0
    var guess: String = ""
    var maxWordLength = 12
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as SKView
        skView.multipleTouchEnabled = false
        //skView.ignoresSiblingOrder = true
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        
        // Configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.keyboardHandler = handleKeyboard
        scene.menuHandler = handleMenu
        
        skView.presentScene(scene)
        
        beginGame()
    }
    
    func beginGame() {
        newChallenge()
    }
    
    func newChallenge() {
        self.challenge = createChallenge()
        guess = ""
        scene.updateChallengeDisplay(self.challenge)
        scene.updatePointsDisplay(totalPoints)
    }

    func createChallenge() -> Challenge {
        return businessLogic.getNewChallenge()
    }
    
    func handleKeyboard(keyboard: Keyboard) {
        switch keyboard.touchedKey.name! {
        case "clear":
            guess = ""
        case "submit":
            if trySubmit() {
                updatePoints()
                newChallenge()
                return
            } else {
                guess = ""
            }
        case "del":
            if countElements(guess) <= 1 {
                guess = ""
            } else {
                guess = guess.substringToIndex(guess.endIndex.predecessor())
            }
            scene.updateAnswerDisplay(guess)
        default:
            if countElements(guess) < maxWordLength {
                guess += keyboard.touchedKey.name!
            }
        }
        
        scene.updateAnswerDisplay(guess)
    }
    
    func handleMenu(name: String) {
        switch name {
        case "reveal":
            scene.updateAnswerDisplay(challenge.keyword.Name)
        case "skip":
            newChallenge()
        default:
            return
        }
    }
    
    func trySubmit() -> Bool {
        var checkAnswer = businessLogic.checkAnswer(guess, challenge: challenge)
        challenge = checkAnswer.Challenge
        
        return checkAnswer.Success
    }
    
    func updatePoints() {
        totalPoints += challenge.points
        scene.updatePointsDisplay(totalPoints)
    }
}
