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
    var scene: GameScene!
    var challenge: Challenge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as SKView
        skView.multipleTouchEnabled = false
        skView.ignoresSiblingOrder = true
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        
        // Configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.keyboardHandler = handleKeyboard
        
        skView.presentScene(scene)
        
        beginGame()
    }
    
    func beginGame() {
        challenge = newChallenge()
    }

    func newChallenge() -> Challenge {
        var businessLogic = BusinessLogic()
        
        return businessLogic.getNewChallenge()
    }
    
    func handleKeyboard(keyboard: Keyboard) {
        switch keyboard.touchedKey.name! {
        case "clear":
            scene.updateAnswerDisplay("")
        case "del":
            scene.updateAnswerDisplay("")
        default:
            return
        }
    }
}
