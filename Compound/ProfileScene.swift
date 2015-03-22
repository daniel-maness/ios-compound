//
//  ProfileScene.swift
//  Compound
//
//  Created by Daniel Maness on 3/18/15.
//  Copyright (c) 2015 Daniel Maness. All rights reserved.
//

import SpriteKit

class ProfileScene: SKScene {
    let fontSizeSmall: CGFloat = 16
    let fontSizeMedium: CGFloat = 32
    let fontSizeLarge: CGFloat = 48
    let fontName = "DINCondensed-Bold"
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
    var playButton: SKShapeNode!
    var challengesButton: SKShapeNode!
    var profileButton: SKShapeNode!
    var settingsButton: SKShapeNode!
    
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
        var label = createLabel("PROFILE", fontSize: fontSizeLarge, fontColor: titleColor, fontName: fontName)
        label.position = CGPoint(x: 0, y: 0)
        menuLayer.addChild(label)
    }
    
    func createButton(name: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, fontSize: CGFloat) -> SKShapeNode {
        var button = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height))
        button.name = name
        button.position = CGPointMake(x, y)
        button.fillColor = SKColor.whiteColor()
        button.hidden = hidden
        
        var label = createLabel(name, fontSize: fontSize, fontColor: buttonTextColor, fontName: fontName)
        label.name = "label"
        label.position = CGPoint(x: buttonWidth / 2, y: (buttonHeight - label.frame.size.height) / 2)
        button.addChild(label)
        
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
        /* Called when a touch begins */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        if let nodeName = nodeAtPoint(location).name {
            
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch moves */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        if let nodeName = nodeAtPoint(location).name {
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch ends */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(menuLayer)
        if let nodeName = nodeAtPoint(location).name {
            
        }
    }
}
