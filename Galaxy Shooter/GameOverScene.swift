//
//  GameOverScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/29/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

var highScoreNumber         = UserDefaults().integer(forKey: "highScoreSaved")
var accumulatedCoins        = UserDefaults().integer(forKey: "accumulatedCoins")

class GameOverScene: SKScene{
    
    let restartLabel            = SKLabelNode(fontNamed: "MarketDeco")
    let profileLabel            = SKLabelNode(fontNamed: "MarketDeco")
    let settingsLabel           = SKLabelNode(fontNamed: "MarketDeco")
    let mainMenuLabel           = SKLabelNode(fontNamed: "MarketDeco")
    let shopLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let coinsLabel              = SKLabelNode(fontNamed: "MarketDeco")
    
    
    //var highScoreNumber         = UserDefaults().integer(forKey: "highScoreSaved")
    //var accumulatedCoins        = UserDefaults().integer(forKey: "accumulatedCoins")
    
    
    override func didMove(to view: SKView) {
        // this code runs as soon as we move to this scene
        
        let background              = SKSpriteNode(imageNamed: "bg1")
        background.size             = self.size
        background.position         = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition        = 0
        self.addChild(background)
        
        let gameOverLabel           = SKLabelNode(fontNamed: "MarketDeco")
        gameOverLabel.text          = "Game Over"
        gameOverLabel.fontSize      = 150
        gameOverLabel.fontColor     = SKColor.white
        gameOverLabel.position      = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        gameOverLabel.zPosition     = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel              = SKLabelNode(fontNamed: "MarketDeco")
        scoreLabel.text             = "Score: \(gameScore)"
        scoreLabel.fontSize         = 100
        scoreLabel.fontColor        = SKColor.white
        scoreLabel.position         = CGPoint(x: self.size.width/2, y: self.size.height*0.65)
        scoreLabel.zPosition        = 1
        self.addChild(scoreLabel)
        
        coinsLabel.text              = "🔸\(gameCoins)"
        coinsLabel.fontSize          = 70
        coinsLabel.fontColor         = SKColor.white
        coinsLabel.position          = CGPoint(x: self.size.width*0.15, y: self.size.height*0.95)
        coinsLabel.zPosition         = 1
        coinsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(coinsLabel)

        
        // Profile stuff should be saved in a similar way!!!
        //let defaults                = UserDefaults()
        //var highScoreNumber         = defaults.integer(forKey: "highScoreSaved")
        
        if(gameScore > highScoreNumber){
            highScoreNumber = gameScore
            UserDefaults().set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        //var accumulatedCoins        = defaults.integer(forKey: "accumulatedCoins")
        accumulatedCoins = gameCoins
        UserDefaults().set(accumulatedCoins, forKey: "accumulatedCoins")
        
        //  -------------
        
        let highScoreLabel          = SKLabelNode(fontNamed: "MarketDeco")
        highScoreLabel.text         = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize     = 100
        highScoreLabel.fontColor    = SKColor.white
        highScoreLabel.position     = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        highScoreLabel.zPosition    = 1
        self.addChild(highScoreLabel)
        

        restartLabel.text           = "New Game"
        restartLabel.fontSize       = 75
        restartLabel.fontColor      = SKColor.white
        restartLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        restartLabel.zPosition      = 1
        self.addChild(restartLabel)
        
        mainMenuLabel.text           = "Main Menu"
        mainMenuLabel.fontSize       = 75
        mainMenuLabel.fontColor      = SKColor.white
        mainMenuLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.325)
        mainMenuLabel.zPosition      = 1
        self.addChild(mainMenuLabel)

        profileLabel.text           = "Profile"
        profileLabel.fontSize       = 75
        profileLabel.fontColor      = SKColor.white
        profileLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        profileLabel.zPosition      = 1
        self.addChild(profileLabel)
        
        
        settingsLabel.text           = "Settings"
        settingsLabel.fontSize       = 75
        settingsLabel.fontColor      = SKColor.white
        settingsLabel.position       = CGPoint(x: self.size.width/2, y: self.size.height*0.175)
        settingsLabel.zPosition      = 1
        self.addChild(settingsLabel)
        
        shopLabel.text              = "Shop"
        shopLabel.fontSize          = 75
        shopLabel.fontColor         = SKColor.white
        shopLabel.position          = CGPoint(x: self.size.width/2, y: self.size.height*0.1)
        shopLabel.zPosition         = 1
        self.addChild(shopLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch){
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
            
            if mainMenuLabel.contains(pointOfTouch){
                let sceneToMoveTo           = MainMenuScene(size: self.size)
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
