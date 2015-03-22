//
//  Button.swift
//  Compound
//
//  Created by Daniel Maness on 11/20/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import SpriteKit

enum ButtonType: Int {
    case Unknown = 0, Pink, PinkAction, Blue, BlueAction
}

class Button: SKShapeNode {
    private var label: SKLabelNode!
    var buttonHandler: (() -> ())?
    var action: () -> Void
    
    var backgroundColor: SKColor!
    var backgroundColorActive: SKColor!
    var textColor: SKColor!
    var textColorActive: SKColor!
    
    var fontSize: CGFloat = 16.0
    var fontName: String = "Helvetica"
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, size: CGSize, position: CGPoint, backgroundColor: SKColor, textColor: SKColor, buttonAction: () -> Void) {
        self.buttonHandler = buttonAction
        self.action = buttonAction
        self.backgroundColor = backgroundColor
        self.backgroundColorActive = textColor
        self.textColor = textColor
        self.textColorActive = backgroundColor
        
        super.init()
        
        self.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        self.name = name
        self.position = position
        self.fillColor = backgroundColor
        self.strokeColor = textColor
        
        self.fillColor = backgroundColor
        createLabel(text)
        self.addChild(self.label)
        
        userInteractionEnabled = true
    }
    
    private func createLabel(text: String) -> SKLabelNode {
        self.label = SKLabelNode()
        self.label.text = text
        self.label.name = self.name
        self.label.fontColor = textColor
        self.label.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height - label.frame.size.height) / 2)
        
        return label
    }
    
    func setTextElements(text: String, fontName: String, fontSize: CGFloat) {
        self.label.text = text
        self.label.fontName = fontName
        self.label.fontSize = fontSize
    }
    
    func setColorElements(backgroundColor: SKColor, textColor: SKColor) {
        self.backgroundColor = backgroundColor
        self.backgroundColorActive = textColor
        self.textColor = textColor
        self.textColorActive = backgroundColor
        
        self.fillColor = backgroundColor
        self.label.fontColor = self.textColor
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        if self.containsPoint(location) {
            self.fillColor = backgroundColorActive
            self.label.fontColor = textColorActive
        } else {
            self.parent?.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        if self.containsPoint(location) {
            self.fillColor = self.backgroundColorActive
            self.label.fontColor = self.textColorActive
        } else {
            self.fillColor = self.backgroundColor
            self.label.fontColor = self.textColor
            self.parent?.touchesMoved(touches, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        if self.containsPoint(location) {
            if let handle = buttonHandler {
                handle()
            }
        } else {
            self.parent?.nextResponder()
//            self.parent?.touchesEnded(touches, withEvent: event)
        }
        
        self.fillColor = backgroundColor
        self.label.fontColor = textColor
    }
}