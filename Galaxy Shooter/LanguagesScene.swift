//
//  LanguagesScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 5/2/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

class LanguagesScene: SKScene{
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let bulgarianLabel          = SKLabelNode()
    let englishLabel            = SKLabelNode()
    let frenchLabel             = SKLabelNode()
    let germanLabel             = SKLabelNode()
    let russianLabel            = SKLabelNode()
    let spanishLabel            = SKLabelNode()
    let ukrainianLabel          = SKLabelNode()
    
    let thaiLabel               = SKLabelNode()
    
    override func didMove(to view: SKView) {
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
        
        
        
        bulgarianLabel.text              = "🇧🇬 Български"
        bulgarianLabel.fontSize          = 100
        bulgarianLabel.fontColor         = SKColor.white
        bulgarianLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.9)
        bulgarianLabel.zPosition         = 1
        bulgarianLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(bulgarianLabel)
        
        englishLabel.text              = "🇬🇧 English"
        englishLabel.fontSize          = 100
        englishLabel.fontColor         = SKColor.white
        englishLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.8)
        englishLabel.zPosition         = 1
        englishLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(englishLabel)
        
        frenchLabel.text               = "🇫🇷 Français"
        frenchLabel.fontSize           = 100
        frenchLabel.fontColor          = SKColor.white
        frenchLabel.position           = CGPoint(x: self.size.width*0.2, y: self.size.height*0.7)
        frenchLabel.zPosition          = 1
        frenchLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(frenchLabel)
        
        germanLabel.text               = "🇩🇪 Deutsche"
        germanLabel.fontSize           = 100
        germanLabel.fontColor          = SKColor.white
        germanLabel.position           = CGPoint(x: self.size.width*0.2, y: self.size.height*0.6)
        germanLabel.zPosition          = 1
        germanLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(germanLabel)
        
        russianLabel.text              = "🇷🇺 Русский"
        russianLabel.fontSize          = 100
        russianLabel.fontColor         = SKColor.white
        russianLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.5)
        russianLabel.zPosition         = 1
        russianLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(russianLabel)
        
        spanishLabel.text              = "🇪🇸 Español"
        spanishLabel.fontSize          = 100
        spanishLabel.fontColor         = SKColor.white
        spanishLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.4)
        spanishLabel.zPosition         = 1
        spanishLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(spanishLabel)
        
        thaiLabel.text              = "🇹🇭 ไทย"
        thaiLabel.fontSize          = 100
        thaiLabel.fontColor         = SKColor.white
        thaiLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.3)
        thaiLabel.zPosition         = 1
        thaiLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(thaiLabel)
        
        ukrainianLabel.text              = "🇺🇦 Українська"
        ukrainianLabel.fontSize          = 100
        ukrainianLabel.fontColor         = SKColor.white
        ukrainianLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.2)
        ukrainianLabel.zPosition         = 1
        ukrainianLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(ukrainianLabel)
        
        
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if backLabel.contains(pointOfTouch){
                let sceneToMoveTo           = SettingsScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
    
}
