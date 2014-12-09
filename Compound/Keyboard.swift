//
//  Keyboard.swift
//  Compound
//
//  Created by Daniel Maness on 11/22/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import SpriteKit

class Keyboard: SKNode {
    let _numRows = 4
    
    var keyboardWidth: CGFloat
    var keyboardHeight: CGFloat
    var keyColor: SKColor
    var keyColorActive: SKColor
    var touchedKey = SKShapeNode()
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(keyboardWidth: CGFloat, keyboardHeight: CGFloat, keyColor: SKColor, keyColorActive: SKColor) {
        self.keyboardWidth = keyboardWidth
        self.keyboardHeight = keyboardHeight
        self.keyColor = keyColor
        self.keyColorActive = keyColorActive
        
        super.init()
        
        self.createKeyboard()
    }
    
    func createKeyboard() {
        self.name = "keyboard"
        
        // Bottom row
        createRow(0, keyText: ["clear", "submit"])
        
        // Inner rows
        createRow(1, keyText: ["z", "x", "c", "v", "b", "n", "m", "del"])
        createRow(2, keyText: ["a", "s", "d", "f", "g", "h", "j", "k", "l"])
        
        // Top Row
        createRow(3, keyText: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"])
    }
    
    func createRow(rowIndex: Int, keyText: [String]) {
        var numKeys = keyText.count
        var keyWidth = keyboardWidth / CGFloat(numKeys)
        var keyHeight = keyboardHeight / CGFloat(_numRows)
        var leftBound = keyboardWidth / -2
        var bottomBound = keyboardHeight / -2 + CGFloat(rowIndex) * keyHeight
        
        for i in 0..<numKeys {
            var key = createKey(keyWidth, height: keyHeight, xPosition: leftBound + CGFloat(i) * keyWidth, yPosition: bottomBound, text: keyText[i])
            self.addChild(key)
        }
    }
    
    func createKey(width: CGFloat, height: CGFloat, xPosition: CGFloat, yPosition: CGFloat, text: String) -> SKShapeNode {
        var key = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height))
        key.name = text
        key.position = CGPointMake(xPosition, yPosition)
        key.fillColor = UIColor.whiteColor()
        key.strokeColor = UIColor.blackColor()
        key.zPosition = 100
        
        var label = createLabel(width / 2, yPosition: height / 4, text: text)
        key.addChild(label)
        label.zPosition = 90
        
        return key
    }
    
    func createLabel(xPosition: CGFloat, yPosition: CGFloat, text: String) -> SKLabelNode {
        var label = SKLabelNode()
        label.name = text
        label.text = text
        label.fontColor = UIColor.blackColor()
        label.fontSize = 16
        label.fontName = "Helvetica"
        label.position = CGPoint(x: xPosition, y: yPosition)
        
        return label
    }
    
    func setupAction(text: String) {
        
    }
    
    func showTouch() {
        clearTouches()
        touchedKey.fillColor = keyColorActive
    }
    
    func hideTouch(key: SKShapeNode) {
        key.fillColor = keyColor
    }
    
    func clearTouches() {
        for key in self.children {
            hideTouch(key as SKShapeNode)
        }
    }
    
    func clearTouchesExceptSelected(node: SKShapeNode) {
        for key in self.children {
            if (key as SKShapeNode) != node {
                (key as SKShapeNode).fillColor = SKColor.whiteColor()
            }
        }
    }
}