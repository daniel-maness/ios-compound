//
//  GameScene.swift
//  Compound
//
//  Created by Daniel Maness on 12/4/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let fontColor = SKColor.blackColor()
    let fontName = "Helvetica"
    let sceneWidth: CGFloat
    let sceneHeight: CGFloat
    let keyboardWidth: CGFloat
    let keyboardHeight: CGFloat
    let challengeLayerHeight: CGFloat
    let menuLayerHeight: CGFloat
    let keyColor = SKColor.whiteColor()
    let keyActiveColor = SKColor(red: CGFloat(255.0 / 255.0), green: CGFloat(62.0 / 255.0), blue: CGFloat(150.0 / 255.0), alpha: CGFloat(1.0))
    let gameLayer = SKNode()
    let menuLayer = SKNode()
    let challengeLayer = SKNode()
    let keyboardLayer = SKNode()
    
    var keyboard: Keyboard!
    var keyboardHandler: ((Keyboard) ->())?
    var menuHandler: ((String) ->())?
    var hintLabels = [SKLabelNode]()
    var answerLabel = SKLabelNode()
    var pointsLabel = SKLabelNode()
    var timerLabel = SKLabelNode()
    
    var hintButton: SKShapeNode!
    var skipButton: SKShapeNode!
    var nextButton: SKShapeNode!
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(size: CGSize) {
        sceneWidth = size.width
        sceneHeight = size.height
        
        keyboardWidth = sceneWidth
        keyboardHeight = sceneHeight / 3
        
        menuLayerHeight = 40
        challengeLayerHeight = sceneHeight - menuLayerHeight - keyboardHeight
        
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setup()
    }
    
    func setup() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(gameLayer)
        
        //let background = SKSpriteNode(fileNamed: "background")
        
        createKeyboardLayer()
        createChallengeLayer()
        createMenuLayer()
    }
    
    func createKeyboardLayer() {
        keyboard = Keyboard(keyboardWidth: size.width, keyboardHeight: size.height / 3, keyColor: keyColor, keyColorActive: keyActiveColor)
        keyboardLayer.addChild(keyboard)
        keyboardLayer.position = CGPoint(x: 0, y: -keyboardHeight)
        gameLayer.addChild(keyboardLayer)
    }
    
    func createChallengeLayer() {
        let background = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: sceneWidth, height: challengeLayerHeight))
        background.position = CGPoint(x: 0, y: 0)
        challengeLayer.addChild(background)
        challengeLayer.position = CGPoint(x: 0, y: sceneHeight / 2 - (challengeLayerHeight / 2) - menuLayerHeight)
        gameLayer.addChild(challengeLayer)

        let labelHeight = challengeLayerHeight / 4.5
        var yPosition = labelHeight
        
        // Timer label
        timerLabel = createLabel("", fontSize: FontSize.small, fontColor: fontColor, fontName: fontName, position: CGPoint(x: 0, y: 2.75 * labelHeight))
        gameLayer.addChild(timerLabel)
        
        // Hint labels
        for i in 0..<3 {
            var label = createLabel("", fontSize: FontSize.medium, fontColor: fontColor, fontName: fontName, position: CGPoint(x: 0, y: yPosition))
            
            hintLabels.append(label)
            challengeLayer.addChild(label)
            
            yPosition -= labelHeight
        }
        
        // Answer label
        answerLabel = createLabel("", fontSize: FontSize.medium, fontColor: keyActiveColor, fontName: fontName, position: CGPoint(x: 0, y: yPosition))
        challengeLayer.addChild(answerLabel)
    }
    
    func createMenuLayer() {
        let background = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: sceneWidth, height: menuLayerHeight))
        background.position = CGPoint(x: 0, y: 0)
        menuLayer.addChild(background)
        
        menuLayer.position = CGPoint(x: 0, y: sceneHeight / 2 - (menuLayerHeight / 2))
        gameLayer.addChild(menuLayer)
        
        // Points label
        pointsLabel = createLabel("", fontSize: FontSize.small, fontColor: fontColor, fontName: fontName, position: CGPoint(x: sceneWidth / -2 + 40, y: -5))
        menuLayer.addChild(pointsLabel)
        
        let buttonWidth = sceneWidth / 4
        let buttonHeight = menuLayerHeight - 1
        
        // Hint button
        hintButton = createButton("hint", width: buttonWidth, height: buttonHeight, x: 0, y:  menuLayerHeight / -2, hidden: false)
        menuLayer.addChild(hintButton)
        
        // Skip button
        skipButton = createButton("skip", width: buttonWidth, height: buttonHeight, x: sceneWidth / 2 - buttonWidth, y: menuLayerHeight / -2, hidden: false)
        menuLayer.addChild(skipButton)
        
        // Next button
        nextButton = createButton("next", width: buttonWidth, height: buttonHeight, x: sceneWidth / 2 - buttonWidth, y: menuLayerHeight / -2, hidden: true)
        menuLayer.addChild(nextButton)
    }
    
    func createButton(name: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, hidden: Bool) -> SKShapeNode {
        var button = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height))
        button.name = name
        button.position = CGPointMake(x, y)
        button.fillColor = UIColor.whiteColor()
        button.strokeColor = UIColor.blackColor()
        
        var label = createLabel(name, fontSize: FontSize.small, fontColor: fontColor, fontName: fontName, position: CGPoint(x: width / 2, y: height / 4))
        button.addChild(label)
        
        button.hidden = hidden
        
        return button
    }
    
    func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, fontName: String, position: CGPoint) -> SKLabelNode{
        var label = SKLabelNode()
        label.text = text
        label.name = text
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.fontName = fontName
        label.position = position
        
        return label
    }

    func updateChallengeDisplay(challenge: Challenge, hint: String?=nil) {
        if challenge.ended {
            showCompletedChallenge(challenge)
        } else if challenge.hintsUsed > 0 {
            showChallengeWithHints(challenge, hint: hint!)
        } else {
            showChallenge(challenge)
        }
    }
    
    func updatePointsDisplay(points: Int) {
        pointsLabel.text = "Points:  " + String(points)
    }
    
    func updateTimerDisplay(time: Int) {
        if time == 60 {
            timerLabel.text = "1:00"
        } else {
            if time < 10 {
                timerLabel.text = "0:0" + String(time)
            } else {
                timerLabel.text = "0:" + String(time)
            }
        }
    }
    
    func updateAnswerDisplay(text: String) {
        answerLabel.text = text
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
        } else if menuLayer.containsPoint(location) {
            if hintButton.containsPoint(location) {
                hintButton.fillColor = keyActiveColor
                nextButton.fillColor = keyColor
            } else if skipButton.containsPoint(location) {
                skipButton.fillColor = keyColor
                skipButton.fillColor = keyActiveColor
            } else if nextButton.containsPoint(location) {
                hintButton.fillColor = keyColor
                nextButton.fillColor = keyActiveColor
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
        } else if menuLayer.containsPoint(location) {
            if hintButton.containsPoint(location) {
                hintButton.fillColor = keyActiveColor
                nextButton.fillColor = keyColor
            } else if skipButton.containsPoint(location) {
                skipButton.fillColor = keyColor
                skipButton.fillColor = keyActiveColor
            } else if nextButton.containsPoint(location) {
                hintButton.fillColor = keyColor
                nextButton.fillColor = keyActiveColor
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
        } else if menuLayer.containsPoint(location) {
            if let handler = menuHandler {
                handler(nodeAtPoint(location).name!)
            }
        }
        
        keyboard.clearTouches()
        hintButton.fillColor = keyColor
        skipButton.fillColor = keyColor
        nextButton.fillColor = keyColor
    }
    
    private func showChallenge(challenge: Challenge) {
        for i in 0..<3 {
            hintLabels[i].text = challenge.combinations[i].keywordLocation == Location.Left ? challenge.combinations[i].rightWord.Name : challenge.combinations[i].leftWord.Name
        }
        updateAnswerDisplay("")
        hintButton.hidden = false
        skipButton.hidden = false
        nextButton.hidden = true
    }
    
    private func showChallengeWithHints(challenge: Challenge, hint: String) {
        for i in 0..<3 {
            hintLabels[i].text = challenge.combinations[i].keywordLocation == Location.Left ? hint + challenge.combinations[i].rightWord.Name : challenge.combinations[i].leftWord.Name + hint
        }
        
        if challenge.hintsUsed == 3 {
            hintButton.hidden = true
        }
    }
    
    private func showCompletedChallenge(challenge: Challenge) {
        for i in 0..<3 {
            hintLabels[i].text = challenge.combinations[i].leftWord.Name + challenge.combinations[i].rightWord.Name
        }
        updateAnswerDisplay(challenge.keyword.Name)
        hintButton.hidden = true
        skipButton.hidden = true
        nextButton.hidden = false
    }
}