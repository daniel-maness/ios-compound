//
//  HomeScene.swift
//  Compound
//
//  Created by Daniel Maness on 1/26/15.
//  Copyright (c) 2015 Daniel Maness. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene {
    let fontSizeSmall: CGFloat = 16
    let fontSizeMedium: CGFloat = 32
    let fontSizeLarge: CGFloat = 48
    let buttonWidthScale: CGFloat = 0.75
    let buttonHeightScale: CGFloat = 0.12
    
    let titleColor = ColorPalette.darkGrey
    let buttonTextColor = ColorPalette.pink
    let buttonTextColorActive = ColorPalette.white
    let buttonFillColor = ColorPalette.white
    let buttonFillColorActive = ColorPalette.pink
    let dividerColor = ColorPalette.lightGrey
    
    let sceneWidth: CGFloat
    let sceneHeight: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let dividerHeight: CGFloat
    
    let menuLayer: SKNode
    var buttonHandler: ((String) -> ())?
    
    var playHandler: (() -> ())?
    var challengesHandler: (() -> ())?
    var profileHandler: (() -> ())?
    var settingsHandler: (() -> ())?
    
    var playButton: Button!
    var challengesButton: Button!
    var profileButton: Button!
    var settingsButton: Button!
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(size: CGSize) {
        sceneWidth = size.width
        sceneHeight = size.height
        
        menuLayer = SKNode()
        
        buttonWidth = sceneWidth * buttonWidthScale
        buttonHeight = sceneHeight * buttonHeightScale
        
        dividerHeight = buttonHeight / 4
        
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setup()
    }
    
    func setup() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createMenuLayer()
    }
    
    func createMenuLayer() {
        menuLayer.name = "menu"
        let background = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: sceneWidth, height: sceneHeight))
        background.position = CGPoint(x: 0, y: 0)
        menuLayer.addChild(background)
        
        menuLayer.position = CGPoint(x: 0, y: sceneHeight / 2 - (sceneHeight / 2))
        
        // Logo
        
        
        // Title
        var titleLabel = createLabel("COMPOUND", fontSize: fontSizeLarge, fontColor: titleColor, fontName: FontName.DinCondensed)
        titleLabel.position = CGPoint(x: 0, y: buttonHeight * 1.5)
        menuLayer.addChild(titleLabel)

        // Buttons
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        var buttonPosition = CGPoint(x: buttonWidth / -2, y: 0.0)
        
        playButton = createButton("play", text: "PLAY", position: buttonPosition, buttonAction: playHandler!, addDivider: true)
        menuLayer.addChild(playButton)
        buttonPosition.y -= buttonHeight
        
        challengesButton = createButton("challenges", text: "CHALLENGES", position: buttonPosition, buttonAction: challengesHandler!, addDivider: true)
        menuLayer.addChild(challengesButton)
        buttonPosition.y -= buttonHeight
        
        profileButton = createButton("profile", text: "PROFILE", position: buttonPosition, buttonAction: profileHandler!, addDivider: true)
        menuLayer.addChild(profileButton)
        buttonPosition.y -= buttonHeight
        
        settingsButton = createButton("settings", text: "SETTINGS", position: buttonPosition, buttonAction: settingsHandler!, addDivider: false)
        menuLayer.addChild(settingsButton)
        buttonPosition.y -= buttonHeight
        
        addChild(menuLayer)
    }
    
    func handleButton(name: String) {
        if let handle = buttonHandler {
            handle(name)
        }
    }

    func createButton(name: String, text: String, position: CGPoint, buttonAction: () -> Void, addDivider: Bool) -> Button {
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        var button = Button(text: text, size: buttonSize, position: position, backgroundColor: ColorPalette.white, textColor: ColorPalette.pink, buttonAction: buttonAction)
        button.name = name
        button.strokeColor = ColorPalette.white
        button.setTextElements(text, fontName: FontName.DinCondensed, fontSize: FontSize.medium)
        
        if addDivider {
            var divider = SKShapeNode(rectOfSize: CGSize(width: buttonWidth, height: 1))
            divider.strokeColor = dividerColor
            divider.position = CGPointMake(buttonWidth / 2, 1)
            button.addChild(divider)
        }
        
        return button
    }
    
    func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, fontName: String) -> SKLabelNode{
        var label = SKLabelNode()
        label.text = text
        label.name = text
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.fontName = fontName
        
        return label
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        nodeAtPoint(location).touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        nodeAtPoint(location).touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        nodeAtPoint(location).touchesEnded(touches, withEvent: event)
    }

    func toggleButton(button: SKShapeNode, isActive: Bool) {
        if isActive {
            button.fillColor = buttonFillColorActive
            if let label = button.childNodeWithName("label") as SKLabelNode? {
                label.fontColor = buttonTextColorActive
            }
            if let divider = button.childNodeWithName("divider") as SKShapeNode? {
                divider.hidden = true
            }
        } else {
            button.fillColor = buttonFillColor
            if let label = button.childNodeWithName("label") as SKLabelNode? {
                label.fontColor = buttonTextColor
            }
            if let divider = button.childNodeWithName("divider") as SKShapeNode? {
                divider.hidden = false
            }
        }
    }
    
    func resetButtons() {
        toggleButton(playButton, isActive: false)
        toggleButton(challengesButton, isActive: false)
        toggleButton(profileButton, isActive: false)
        toggleButton(settingsButton, isActive: false)
    }
}
