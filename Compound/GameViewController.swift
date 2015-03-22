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
    
    var homeScene: HomeScene!
    var scene: GameScene!
    var challenge: Challenge!
    var totalPoints: Int = 0
    var guess: String = ""
    var maxWordLength = 12
    var timer = NSTimer()
    let maxTime = 60
    var time: Int = 0
    
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
        
        homeScene = HomeScene(size: skView.bounds.size)
        homeScene.scaleMode = .AspectFill
        homeScene.buttonHandler = handleHomeButton
        homeScene.playHandler = handlePlayButton
        homeScene.challengesHandler = handleChallengesButton
        homeScene.profileHandler = handleProfileButton
        homeScene.settingsHandler = handleSettingsButton
        
        skView.presentScene(homeScene)
        
    }
    
    func loadGameScene(){
        // Configure the view.
        let skView = self.view as SKView
        skView.multipleTouchEnabled = false
        
        // Configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.keyboardHandler = handleKeyboard
        scene.menuHandler = handleMenu
        
        skView.presentScene(scene)
        
        beginGame()
    }
    
    func handleTimer() {
        if time > 0 {
            time--
            scene.updateTimerDisplay(time)
            
            if time == 45 || time == 30 || time == 10 {
                useHint()
            }
        } else {
            stopChallenge()
        }
    }
    
    func startTimer() {
        time = maxTime
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("handleTimer"), userInfo: nil, repeats: true)
        scene.updateTimerDisplay(time)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func beginGame() {
        newChallenge()
    }
    
    func newChallenge() {
        self.challenge = createChallenge()
        guess = ""
        scene.updateChallengeDisplay(challenge)
        scene.updatePointsDisplay(totalPoints)
        
        startChallenge()
    }

    func createChallenge() -> Challenge {
        return businessLogic.getNewChallenge()
    }
    
    func handleKeyboard(keyboard: Keyboard) {
        if !challenge.ended {
            switch keyboard.touchedKey.name! {
            case "clear":
                guess = ""
            case "submit":
                if trySubmit() {
                    challenge.points = businessLogic.calculatePoints(challenge.guesses.count)
                    stopChallenge()
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
    }
    
    func handleMenu(name: String) {
        switch name {
        case "hint":
            handleHint()
        case "skip":
            handleSkip()
        case "next":
            handleNext()
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
    
    func handleHint() {
        useHint()
    }
    
    func handleSkip() {
        stopChallenge()
        newChallenge()
    }
    
    func handleNext() {
        stopChallenge()
        newChallenge()
    }
    
    func useHint() {
        var useHint = businessLogic.useHint(challenge)
        challenge = useHint.Challenge
        
        scene.updateChallengeDisplay(challenge, hint: useHint.Hint)
    }
    
    func startChallenge() {
        startTimer()
    }
    
    func stopChallenge() {
        challenge.ended = true
        updatePoints()
        stopTimer()
        scene.updateChallengeDisplay(challenge)
    }
    
    func handleHomeButton(name: String) {
        switch name {
        case "PLAY":
            loadGameScene()
        case "CHALENGES":
            break
        case "PROFILE":
            break
        case "SETTINGS":
            break
        default:
            break
        }
    }
    
    func handlePlayButton() {
        loadGameScene()
    }
    
    func handleChallengesButton() {
        
    }
    
    func handleProfileButton() {
        
    }
    
    func handleSettingsButton() {
        
    }
}
