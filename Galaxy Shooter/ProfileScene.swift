//
//  ProfileScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/29/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

class ProfileScene: SKScene{
    
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let colorLabel              = SKLabelNode(fontNamed: "MarketDeco")
    let shipStyleLabel          = SKLabelNode(fontNamed: "MarketDeco")
    let backgroundLabel         = SKLabelNode(fontNamed: "MarketDeco")
    
    var currentColor = "Red"
    
    override func didMove(to view: SKView) {
        // this code runs as soon as we move to this scene
        
        let background              = SKSpriteNode(imageNamed: "bg1")
        background.size             = self.size
        background.position         = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition        = 0
        self.addChild(background)
        
        backLabel.text              = "< Main Menu"
        backLabel.fontSize          = 35
        backLabel.fontColor         = SKColor.white
        backLabel.position          = CGPoint(x: self.size.width*0.15, y: self.size.height*0.975)
        backLabel.zPosition         = 1
        backLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(backLabel)
        
        colorLabel.text              = "Color: \(currentColor)"
        colorLabel.fontSize          = 90
        colorLabel.fontColor         = SKColor.white
        colorLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.7)
        colorLabel.zPosition         = 1
        colorLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(colorLabel)
        
        shipStyleLabel.text          = "Style: Default"
        shipStyleLabel.fontSize      = 90
        shipStyleLabel.fontColor     = SKColor.white
        shipStyleLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.6)
        shipStyleLabel.zPosition     = 1
        shipStyleLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(shipStyleLabel)
        
        backgroundLabel.text          = "Background: Sky"
        backgroundLabel.fontSize      = 90
        backgroundLabel.fontColor     = SKColor.white
        backgroundLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.5)
        backgroundLabel.zPosition     = 1
        backgroundLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(backgroundLabel)
        
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if backLabel.contains(pointOfTouch){
                let sceneToMoveTo           = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if colorLabel.contains(pointOfTouch){
                if(currentColor == "Red"){
                    currentColor = "Green"
                }
                else if(currentColor == "Green"){
                    currentColor = "Blue"
                }
                else if(currentColor == "Blue"){
                    currentColor = "Red"
                }
                
                colorLabel.text = "Color: \(currentColor)"
            }
        }
    }
    
}

// This file is a stub that will later deal with game profile characterization
