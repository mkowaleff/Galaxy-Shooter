//
//  SettingsScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/29/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

class SettingsScene: SKScene{
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let musicLabel              = SKLabelNode(fontNamed: "MarketDeco")
    let soundsLabel             = SKLabelNode(fontNamed: "MarketDeco")
    let languageLabel           = SKLabelNode(fontNamed: "MarketDeco")
    
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
        
        musicLabel.text              = "Music On/Off"
        musicLabel.fontSize          = 80
        musicLabel.fontColor         = SKColor.white
        musicLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.6)
        musicLabel.zPosition         = 1
        musicLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(musicLabel)
        
        soundsLabel.text          = "Game Sounds On/Off"
        soundsLabel.fontSize      = 80
        soundsLabel.fontColor     = SKColor.white
        soundsLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.55)
        soundsLabel.zPosition     = 1
        soundsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(soundsLabel)
        
        languageLabel.text          = "Language: English"
        languageLabel.fontSize      = 80
        languageLabel.fontColor     = SKColor.white
        languageLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.50)
        languageLabel.zPosition     = 1
        languageLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(languageLabel)


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
        }
    }
    
}

// This file is a stub that will later deal with game settings
