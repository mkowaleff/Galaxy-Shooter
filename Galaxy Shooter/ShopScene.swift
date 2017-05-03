//
//  ShopScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 5/1/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import Foundation
import SpriteKit

class ShopScene: SKScene{
    let backLabel               = SKLabelNode(fontNamed: "MarketDeco")
    let coinsLabel              = SKLabelNode(fontNamed: "MarketDeco")
    let startingLivesLabel      = SKLabelNode(fontNamed: "MarketDeco")
    let stylesLabel             = SKLabelNode(fontNamed: "MarketDeco")
    let colorsLabel             = SKLabelNode(fontNamed: "MarketDeco")
    let powerupsLabel           = SKLabelNode(fontNamed: "MarketDeco")
    //let bulletsLabel            = SKLabelNode(fontNamed: "MarketDeco")
    
    var startingLives           = UserDefaults().integer(forKey: "startingLives")
    
    override func didMove(to view: SKView) {
        // this code runs as soon as we move to this scene
        
        let background              = SKSpriteNode(imageNamed: "bg1")
        background.size             = self.size
        background.position         = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition        = 0
        self.addChild(background)
        
        backLabel.text              = "< Main Menu"
        backLabel.fontSize          = 50
        backLabel.fontColor         = SKColor.white
        backLabel.position          = CGPoint(x: self.size.width*0.15, y: self.size.height*0.95)
        backLabel.zPosition         = 1
        backLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(backLabel)
        
        coinsLabel.text              = "🔸 \(gameCoins)"
        coinsLabel.fontSize          = 50
        coinsLabel.fontColor         = SKColor.white
        coinsLabel.position          = CGPoint(x: self.size.width*0.85, y: self.size.height*0.95)
        coinsLabel.zPosition         = 1
        coinsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.right
        self.addChild(coinsLabel)
        
        startingLivesLabel.text          = "Starting Lives:\(startingLives)      🔸25"
        startingLivesLabel.fontSize      = 80
        startingLivesLabel.fontColor     = SKColor.white
        startingLivesLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.75)
        startingLivesLabel.zPosition     = 1
        startingLivesLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(startingLivesLabel)
        
        stylesLabel.text          = "Ship Styles"
        stylesLabel.fontSize      = 80
        stylesLabel.fontColor     = SKColor.white
        stylesLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.50)
        stylesLabel.zPosition     = 1
        stylesLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(stylesLabel)
        
        colorsLabel.text          = "Ship Colors"
        colorsLabel.fontSize      = 80
        colorsLabel.fontColor     = SKColor.white
        colorsLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.45)
        colorsLabel.zPosition     = 1
        colorsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(colorsLabel)
        
        powerupsLabel.text          = "Powerups"
        powerupsLabel.fontSize      = 80
        powerupsLabel.fontColor     = SKColor.white
        powerupsLabel.position      = CGPoint(x: self.size.width*0.2, y: self.size.height*0.40)
        powerupsLabel.zPosition     = 1
        powerupsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(powerupsLabel)
        
        
        
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
            
            if stylesLabel.contains(pointOfTouch){
                let sceneToMoveTo           = StylesScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if colorsLabel.contains(pointOfTouch){
                let sceneToMoveTo           = ColorsScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if powerupsLabel.contains(pointOfTouch){
                let sceneToMoveTo           = PowerupsScene(size: self.size)
                sceneToMoveTo.scaleMode     = self.scaleMode
                let myTransition            = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if startingLivesLabel.contains(pointOfTouch){
                if(gameCoins >= 25){
                    startingLives               += 1
                    UserDefaults().set(startingLives, forKey: "startingLives")
                    gameCoins                   -= 25
                    UserDefaults().set(gameCoins, forKey:"accumulatedCoins")
                    coinsLabel.text              = "🔸 \(gameCoins)"
                    startingLivesLabel.text      = "Starting Lives:\(startingLives)      🔸25"
                }
                
            }
        }
    }
    
    func performTransaction(){
        
    }
    


}
