//
//  PowerupsScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 5/1/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

class PowerupsScene: SKScene{
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    
    override func didMove(to view: SKView) {
        // this code runs as soon as we move to this scene
        
        let background              = SKSpriteNode(imageNamed: "bg1")
        background.size             = self.size
        background.position         = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition        = 0
        self.addChild(background)
        
        backLabel.text              = "< Shop"
        backLabel.fontSize          = 50
        backLabel.fontColor         = SKColor.white
        backLabel.position          = CGPoint(x: self.size.width*0.15, y: self.size.height*0.95)
        backLabel.zPosition         = 1
        backLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(backLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if backLabel.contains(pointOfTouch){
                let sceneToMoveTo           = ShopScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }


    
}


