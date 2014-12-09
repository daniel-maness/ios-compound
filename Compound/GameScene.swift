//
//  GameScene.swift
//  Compound
//
//  Created by Daniel Maness on 12/4/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let keyboardWidth: CGFloat
    let keyboardHeight: CGFloat
    let keyColor = SKColor.whiteColor()
    let keyActiveColor = SKColor(red: CGFloat(255.0 / 255.0), green: CGFloat(62.0 / 255.0), blue: CGFloat(150.0 / 255.0), alpha: CGFloat(1.0))
    let gameLayer = SKNode()
    let challengeLayer = SKNode()
    let keyboardLayer = SKNode()
    
    var keyboard: Keyboard!
    var keyboardHandler: ((Keyboard) ->())?
    var labels = [SKLabelNode]()
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(size: CGSize) {
        keyboardWidth = size.width
        keyboardHeight = size.height / 3
        
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        view.backgroundColor = .whiteColor()
        setup()
    }
    
    func setup() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
        addChild(gameLayer)
        
        
        challengeLayer.position = CGPoint(x: self.frame.width / -2, y: self.frame.height / 2)
        gameLayer.addChild(challengeLayer)
        
        
        setupKeyboard()
        setupLabels()

    }
    
    func setupKeyboard() {
        keyboard = Keyboard(keyboardWidth: keyboardWidth, keyboardHeight: keyboardHeight, keyColor: keyColor, keyColorActive: keyActiveColor)
        keyboardLayer.addChild(keyboard)
        keyboardLayer.position = CGPoint(x: 0, y: -keyboardHeight)
        gameLayer.addChild(keyboardLayer)
    }
    
    func setupLabels() {
        let labelHeight = 50
        var yPosition = 100
        
        for i in 0..<3 {
            var label = SKLabelNode()
            label.fontSize = 25
            label.fontColor = SKColor.blackColor()
            label.fontName = "Helvetica"
            label.position = CGPoint(x: 0, y: yPosition)
            
            labels.append(label)
            challengeLayer.addChild(label)
            
            yPosition -= labelHeight
        }
    }
    
    func updateChallengeDisplay(challenge: Challenge) {
        
    }
    
    func updatePointsDisplay(points: Int) {
        
    }
    
    func updateAnswerDisplay(text: String) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(gameLayer)
        if keyboardLayer.containsPoint(location) {
            for node in nodesAtPoint(location) {
                if node.parent??.name == keyboard.name {
                    keyboard.touchedKey = node as SKShapeNode
                    keyboard.showTouch()
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch moves */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(gameLayer)
        if keyboardLayer.containsPoint(location) {
            for node in nodesAtPoint(location) {
                if node.parent??.name == keyboard.name {
                    keyboard.touchedKey = node as SKShapeNode
                    keyboard.showTouch()
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch ends */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(gameLayer)
        if keyboardLayer.containsPoint(location) {
            for node in nodesAtPoint(location) {
                if node.parent??.name == keyboard.name {
                    if let handler = keyboardHandler {
                        handler(keyboard)
                    }
                }
            }
        }
        
        keyboard.clearTouches()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}