//
//  SceneServices.swift
//  Compound
//
//  Created by Daniel Maness on 1/26/15.
//  Copyright (c) 2015 Daniel Maness. All rights reserved.
//

import SpriteKit

class SceneServices {
    func createButton(name: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, hidden: Bool, label: SKLabelNode) -> SKShapeNode {
        var button = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height))
        button.name = name
        button.position = CGPointMake(x, y)
        button.fillColor = UIColor.whiteColor()
        button.strokeColor = UIColor.blackColor()
        
        //var label = createLabel(name, fontSize: fontSizeSmall, fontColor: fontColor, fontName: fontName, position: CGPoint(x: width / 2, y: height / 4))
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
}