//
//  SettingsScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/29/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import GameplayKit

class SettingsScene: SKScene{
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let musicLabel              = SKLabelNode(fontNamed: "MarketDeco")
    let soundsLabel             = SKLabelNode(fontNamed: "MarketDeco")
    let languageLabel           = SKLabelNode(fontNamed: "MarketDeco")
    let resetLabel              = SKLabelNode(fontNamed: "MarketDeco")
    let coinsLabel              = SKLabelNode(fontNamed: "MarketDeco")
    
    var musicState  = "On"
    var gameAudio   = "On"
    
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
        
        musicLabel.text              = "Music: \(musicState)"
        musicLabel.fontSize          = 90
        musicLabel.fontColor         = SKColor.white
        musicLabel.position          = CGPoint(x: self.size.width*0.2, y: self.size.height*0.8)
        musicLabel.zPosition         = 1
        musicLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(musicLabel)
        
        soundsLabel.text          = "Game Sounds: On"
        soundsLabel.fontSize      = 90
        soundsLabel.fontColor     = SKColor.white
        soundsLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.7)
        soundsLabel.zPosition     = 1
        soundsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(soundsLabel)
        
        languageLabel.text          = "Language: 🇬🇧English"
        languageLabel.fontSize      = 90
        languageLabel.fontColor     = SKColor.white
        languageLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.6)
        languageLabel.zPosition     = 1
        languageLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(languageLabel)
        
        resetLabel.text             = "Reset Game"
        resetLabel.fontSize         = 90
        resetLabel.fontColor        = SKColor.white
        resetLabel.position         = CGPoint(x: self.size.width*0.2, y: self.size.height*0.5)
        resetLabel.zPosition        = 1
        resetLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(resetLabel)
        
        coinsLabel.text              = "🔸 \(gameCoins)"
        coinsLabel.fontSize          = 50
        coinsLabel.fontColor         = SKColor.white
        coinsLabel.position          = CGPoint(x: self.size.width*0.85, y: self.size.height*0.95)
        coinsLabel.zPosition         = 1
        coinsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.right
        self.addChild(coinsLabel)


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
            
            if languageLabel.contains(pointOfTouch){
                let sceneToMoveTo           = LanguagesScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if musicLabel.contains(pointOfTouch){
                if(musicState == "On"){
                    musicState = "Off"
                }
                else{
                    musicState = "On"
                }
                musicLabel.text              = "Music: \(musicState)"
            }
            
            if soundsLabel.contains(pointOfTouch){
                if(gameAudio == "On"){
                    gameAudio = "Off"
                }
                else{
                    gameAudio = "On"
                }
                soundsLabel.text              = "Game Sounds: \(gameAudio)"
            }
            
            if resetLabel.contains(pointOfTouch){
                gameCoins = 0
                accumulatedCoins = 0
                highScoreNumber = 0
                startingLives = 3
                
                
                
                UserDefaults().set(0, forKey: "highScoreSaved")
                UserDefaults().set(0, forKey: "accumulatedCoins")
                UserDefaults().set(3, forKey: "startingLives")
                // language
                // starting level
                coinsLabel.text              = "🔸 \(gameCoins)"
                
                
            }
        }
    }
    
}

// This file is a stub that will later deal with game settings
