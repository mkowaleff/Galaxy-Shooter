//
//  MainMenuScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/29/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

var startingLives           = 3

class MainMenuScene: SKScene{
    
    let defaults                = UserDefaults()
    //var startingLives           = 3
    
  
    let startGameLabel          = SKLabelNode(fontNamed: "MarketDeco")
    let profileLabel            = SKLabelNode(fontNamed: "MarketDeco")
    let settingsLabel           = SKLabelNode(fontNamed: "MarketDeco")
    let shopLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let coinsLabel              = SKLabelNode(fontNamed: "MarketDeco")
    
    override func didMove(to view: SKView) {
        
        
        var startingLivesDef = defaults.integer(forKey: "startingLives")
        if(startingLives > startingLivesDef){
            startingLivesDef = startingLives
            defaults.set(startingLivesDef, forKey: "startingLives")
        }
        // this code runs as soon as we move to this scene
        
        let background              = SKSpriteNode(imageNamed: "bg1")
        background.size             = self.size
        background.position         = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition        = 0
        self.addChild(background)
        
        let gameByLabel             = SKLabelNode(fontNamed: "MarketDeco")
        gameByLabel.text            = "Martin Kowaleff's"
        gameByLabel.fontSize        = 50
        gameByLabel.fontColor       = SKColor.white
        gameByLabel.position        = CGPoint(x: self.size.width/2, y: self.size.height*0.775)
        gameByLabel.zPosition       = 1
        self.addChild(gameByLabel)
        
        let gameNameLabel1          = SKLabelNode(fontNamed: "MarketDeco")
        gameNameLabel1.text         = "Galaxy"
        gameNameLabel1.fontSize     = 200
        gameNameLabel1.fontColor    = SKColor.white
        gameNameLabel1.position     = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        gameNameLabel1.zPosition    = 1
        self.addChild(gameNameLabel1)
        
        let gameNameLabel2          = SKLabelNode(fontNamed: "MarketDeco")
        gameNameLabel2.text         = "Shooter"
        gameNameLabel2.fontSize     = 200
        gameNameLabel2.fontColor    = SKColor.white
        gameNameLabel2.position     = CGPoint(x: self.size.width/2, y: self.size.height*0.625)
        gameNameLabel2.zPosition    = 1
        self.addChild(gameNameLabel2)
        

        startGameLabel.text         = "New Game"
        startGameLabel.fontSize     = 150
        startGameLabel.fontColor    = SKColor.white
        startGameLabel.position     = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        startGameLabel.zPosition    = 1
        startGameLabel.name         = "startButton"
        self.addChild(startGameLabel)
        
        profileLabel.text           = "Profile"
        profileLabel.fontSize       = 150
        profileLabel.fontColor      = SKColor.white
        profileLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.325)
        profileLabel.zPosition      = 1
        self.addChild(profileLabel)
        
        
        settingsLabel.text           = "Settings"
        settingsLabel.fontSize       = 150
        settingsLabel.fontColor      = SKColor.white
        settingsLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        settingsLabel.zPosition      = 1
        self.addChild(settingsLabel)
        
        shopLabel.text              = "Shop"
        shopLabel.fontSize          = 150
        shopLabel.fontColor         = SKColor.white
        shopLabel.position          = CGPoint(x: self.size.width/2, y: self.size.height*0.175)
        shopLabel.zPosition         = 1
        self.addChild(shopLabel)
        
        coinsLabel.text              = "🔸\(gameCoins)"
        coinsLabel.fontSize          = 70
        coinsLabel.fontColor         = SKColor.white
        coinsLabel.position          = CGPoint(x: self.size.width*0.15, y: self.size.height*0.95)
        coinsLabel.zPosition         = 1
        coinsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(coinsLabel)
        
        
        
        
        
        
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if startGameLabel.contains(pointOfTouch){
                let sceneToMoveTo           = GameScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if profileLabel.contains(pointOfTouch){
                let sceneToMoveTo           = ProfileScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if settingsLabel.contains(pointOfTouch){
                let sceneToMoveTo           = SettingsScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if shopLabel.contains(pointOfTouch){
                let sceneToMoveTo           = ShopScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
        }
    }

    
    
    
    
    
    
    
    
    
    
    
}

// This file is a stub that will later deal with game main menu

