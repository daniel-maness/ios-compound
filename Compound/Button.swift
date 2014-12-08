//
//  Button.swift
//  Compound
//
//  Created by Daniel Maness on 11/20/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import SpriteKit

class Button: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: () -> Void) {
        defaultButton = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 50, height: 75))
        activeButton = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 50, height: 75))
        //activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.hidden = true
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
