//
//  GameScene.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/28/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import SpriteKit
import GameplayKit

var gameScore       = 0
var gameCoins       = UserDefaults().integer(forKey: "accumulatedCoins")

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var levelNumber     = 0
    var livesNumber     = UserDefaults().integer(forKey: "startingLives")
    
    var levelLabel      = SKLabelNode(fontNamed: "MarketDeco")
    var livesLabel      = SKLabelNode(fontNamed: "MarketDeco")
    let tapToStartLabel = SKLabelNode(fontNamed: "MarketDeco")
    let scoreLabel      = SKLabelNode(fontNamed: "MarketDeco")
    let coinsLabel      = SKLabelNode(fontNamed: "MarketDeco")
    let pauseLabel      = SKLabelNode(fontNamed: "MarketDeco")
    
    
    let player          = SKSpriteNode(imageNamed: "redship1")
    let bulletSound     = SKAction.playSoundFileNamed("laser1.mp3", waitForCompletion: false)
    let explosionSound  = SKAction.playSoundFileNamed("explode.wav", waitForCompletion: false)
    // wait for completion = whether the sound has to be finished before next action
    
    
    
    enum gameState{
        case preGame        // when game state is before start of the game
        case inGame         // when game state is during the game
        case afterGame      // when game state is after the game
    }
    
    var currentGameState = gameState.preGame
    
    
    struct PhysicsCategories{
        static let None:    UInt32 = 0      // collisions
        static let Player:  UInt32 = 0b1    //1
        static let Bullet:  UInt32 = 0b10   //2
        static let Enemy:   UInt32 = 0b100  //4
        static let Planet:  UInt32 = 0b1000 //8
    }
    
    // This makes sure that the player doesn't go off screen
    let gameArea: CGRect
    override init(size: CGSize){
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth           = size.height / maxAspectRatio
        let margin                  = (size.width - playableWidth)/2
        
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // end of off screen code
    
    override func didMove(to view: SKView) {
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0...1{
            let background          = SKSpriteNode(imageNamed: "bg1")
            background.size         = self.size
            background.anchorPoint  = CGPoint(x: 0.5, y: 0)
            background.position     = CGPoint(x: self.size.width/2,
                                              y: self.size.height*CGFloat(i))
            background.zPosition    = 0
            background.name         = "Background"
            self.addChild(background)
        }
        
        
        
        // Moved declaration outside of function so it can be referenced from fireBullet
        player.setScale(1.5)
        player.position                         = CGPoint(x: self.size.width/2, y: 0 - player.size.height)
        player.zPosition                        = 2
        
        player.physicsBody                      = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity   = false
        player.physicsBody!.categoryBitMask     = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask    = PhysicsCategories.None    // player cannot collide
        player.physicsBody!.contactTestBitMask  = PhysicsCategories.Enemy   // player can hit enemy
        self.addChild(player)
        
        scoreLabel.text                     = "Score: 0"
        scoreLabel.fontSize                 = 70
        scoreLabel.fontColor                = SKColor.white
        scoreLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position                 = CGPoint(x: self.size.width*0.15, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition                = 100
        self.addChild(scoreLabel)
        
        livesLabel.text                     = "Lives: \(livesNumber)"
        livesLabel.fontSize                 = 70
        livesLabel.fontColor                = SKColor.white
        livesLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.right
        livesLabel.position                 = CGPoint(x: self.size.width*0.85, y: self.size.height + livesLabel.frame.size.height)
        livesLabel.zPosition                = 100
        self.addChild(livesLabel)
        
        levelLabel.text                     = "1"
        levelLabel.fontSize                 = 70
        levelLabel.fontColor                = SKColor.white
        levelLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.center
        levelLabel.position                 = CGPoint(x: self.size.width*0.5, y: self.size.height + levelLabel.frame.size.height)
        levelLabel.zPosition                = 100
        self.addChild(levelLabel)
        
        coinsLabel.text                     = "🔸\(gameCoins)"
        coinsLabel.fontSize                 = 70
        coinsLabel.fontColor                = SKColor.white
        coinsLabel.position                 = CGPoint(x: self.size.width*0.15, y: self.size.height*0.95)
        coinsLabel.zPosition                = 100
        coinsLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.left
        self.addChild(coinsLabel)
        
        pauseLabel.text              = "⏯"
        pauseLabel.fontSize          = 70
        pauseLabel.fontColor         = SKColor.white
        pauseLabel.position          = CGPoint(x: self.size.width*0.85, y: self.size.height*0.95)
        pauseLabel.zPosition         = 100
        pauseLabel.horizontalAlignmentMode  = SKLabelHorizontalAlignmentMode.right
        self.addChild(pauseLabel)
        
        let moveOntoScreenAction               = SKAction.moveTo(y: self.size.height*0.9, duration: 0.3)
        scoreLabel.run(moveOntoScreenAction)
        livesLabel.run(moveOntoScreenAction)
        levelLabel.run(moveOntoScreenAction)
        //coinsLabel.run(moveOntoScreenAction)
        
        tapToStartLabel.text                    = "Start Game"
        tapToStartLabel.fontSize                = 100
        tapToStartLabel.fontColor               = SKColor.white
        tapToStartLabel.position                = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.zPosition               = 100
        tapToStartLabel.alpha                   = 0
        self.addChild(tapToStartLabel)
        
        let fadeInAction                        = SKAction.fadeIn(withDuration: 0.3)
        tapToStartLabel.run(fadeInAction)

        
    }
    
    
    var lastUpdateTime:         TimeInterval = 0
    var deltaFrameTime:         TimeInterval = 0
    var amountToMovePerSecond:  CGFloat      = 600.0
    // this variable could perhaps be changed as levels increase?
    
    
    override func update(_ currentTime: TimeInterval) {
        if(lastUpdateTime == 0){
            lastUpdateTime = currentTime
        }
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackground = amountToMovePerSecond*CGFloat(deltaFrameTime)
        
        self.enumerateChildNodes(withName: "Background"){
            background, stop in
            
            if(self.currentGameState == gameState.inGame){
                background.position.y -= amountToMoveBackground
            }
            
            if(background.position.y < -self.size.height){
                background.position.y += self.size.height*2
            }
        }
    }
    
    
    func startGame(){
        currentGameState                = gameState.inGame
        
        let fadeOutAction               = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction                = SKAction.removeFromParent()
        let deleteSequence              = SKAction.sequence([fadeOutAction, deleteAction])
        tapToStartLabel.run(deleteSequence)
        
        let moveShipOntoScreenAction    = SKAction.moveTo(y: self.size.height*0.2, duration: 0.5)
        let startLevelAction            = SKAction.run(startNewLevel)
        let startGameSequence           = SKAction.sequence([moveShipOntoScreenAction,startLevelAction])
        player.run(startGameSequence)
    }
    
    
    func loseALife(){
        livesNumber        -= 1
        livesLabel.text     = "Lives: \(livesNumber)"
        
        let scaleUp         = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown       = SKAction.scale(to: 1.0, duration: 0.2)
        let scaleSequence   = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if (livesNumber == 0){
            runGameOver()
        }
    }
    
    func gainALife(){
        livesNumber        += 1
        livesLabel.text     = "Lives: \(livesNumber)"
        
        let scaleUp         = SKAction.scale(to: 1.25, duration: 0.2)
        let scaleDown       = SKAction.scale(to: 1.0, duration: 0.2)
        let scaleSequence   = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
    }
    
    func gainACoin(){
        gameCoins          += 1
        coinsLabel.text     = "🔸\(gameCoins)"
        
        let scaleUp         = SKAction.scale(to: 1.25, duration: 0.2)
        let scaleDown       = SKAction.scale(to: 1.0, duration: 0.2)
        let scaleSequence   = SKAction.sequence([scaleUp, scaleDown])
        coinsLabel.run(scaleSequence)
    }
    
    
    func addScore(){
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if(gameScore%5 == 0){
            gainACoin()
        }
        
        if(gameScore%10 == 0){
            gainALife()
            startNewLevel()
        }
    }
    
    
    func runGameOver(){
        
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet"){
            bullet, stop in
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy"){
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction       = SKAction.run(changeScene)
        let waitToChangeScene       = SKAction.wait(forDuration: 1)
        let changeSceneSequence     = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func changeScene(){
        let sceneToMoveTo           = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode     = self.scaleMode
        let myTransition            = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        
        // Lower category number will be body 1, higher category number will be 2
        // Player   = 1
        // Bullet   = 2
        // Enemy    = 4
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        
        // If player has hit enemy
        if (body1.categoryBitMask == PhysicsCategories.Player &&
            body2.categoryBitMask == PhysicsCategories.Enemy){
            
            if(body1.node != nil){
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            if(body2.node != nil){
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            runGameOver()
            
        }
        
        // If  bullet has hit enemy
        if (body1.categoryBitMask == PhysicsCategories.Bullet &&
            body2.categoryBitMask == PhysicsCategories.Enemy){
            
            addScore()
            
            
            
            if(body2.node != nil){
                if(body2.node!.position.y > self.size.height){
                   return
                }
                else{
                    spawnExplosion(spawnPosition: body2.node!.position)
                }
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
        }
        
    }
    
    
    func spawnExplosion(spawnPosition: CGPoint){
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete  = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    
    func startNewLevel(){
        levelNumber        += 1
        levelLabel.text = "\(levelNumber)"
        
        if(self.action(forKey: "spawningEnemies") != nil){
            // here you could add a pause between levels
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration   = TimeInterval()
        
        switch levelNumber{
        case 1:     levelDuration = 1.0
        case 2:     levelDuration = 0.8
        case 3:     levelDuration = 0.6
        case 4:     levelDuration = 0.4
        default:    levelDuration = 0.2
                    print("Cannot find level info")
        }
        
        let spawn           = SKAction.run(spawnEnemy)
        let waitToSpawn     = SKAction.wait(forDuration: levelDuration)
        let spawnSequence   = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever    = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningEnemies")
    }
    
    
    func fireBullet(){
        let bullet                              = SKSpriteNode(imageNamed: "redbullet1")
        bullet.name                             = "Bullet"
        bullet.setScale(1)
        bullet.position                         = player.position
        bullet.zPosition                        = 1
        
        bullet.physicsBody                      = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity   = false
        bullet.physicsBody!.categoryBitMask     = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask    = PhysicsCategories.None    // bullet can't collide
        bullet.physicsBody!.contactTestBitMask  = PhysicsCategories.Enemy   // bullet can hit enemy
        
        self.addChild(bullet)
        
        let moveBullet      = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet    = SKAction.removeFromParent()
        let bulletSequence  = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    
    
    
    
    
    /*func fireHomingBullet(){
        let bullet2                              = SKSpriteNode(imageNamed: "bluebullet1")
        bullet2.name                             = "Bullet2"
        bullet2.setScale(1)
        bullet2.position                         = player.position
        bullet2.zPosition                        = 1
        
        bullet2.physicsBody                      = SKPhysicsBody(rectangleOf: bullet2.size)
        bullet2.physicsBody!.affectedByGravity   = false
        bullet2.physicsBody!.categoryBitMask     = PhysicsCategories.Bullet
        bullet2.physicsBody!.collisionBitMask    = PhysicsCategories.None    // bullet can't collide
        bullet2.physicsBody!.contactTestBitMask  = PhysicsCategories.Enemy   // bullet can hit enemy
        
        let enemyLocation: CGPoint = self.childNode(withName: "Enemy")!.position
        
        self.addChild(bullet2)
        
        let moveBullet      = SKAction.move(to: enemyLocation, duration: 0.5)
        let deleteBullet    = SKAction.removeFromParent()
        let bulletSequence  = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet2.run(bulletSequence)
    }*/
    
    func pickRandomImage() -> UInt32{
        let randomNum:UInt32 = arc4random_uniform(19)
        return randomNum
    }
    
    
    func spawnEnemy(){
        let randomXStart    = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd      = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint      = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint        = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy                               = SKSpriteNode(imageNamed: "\(pickRandomImage())")
        enemy.name                              = "Enemy"
        enemy.setScale(1.5)
        enemy.position                          = startPoint
        enemy.zPosition                         = 2
        
        enemy.physicsBody                       = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity    = false
        enemy.physicsBody!.categoryBitMask      = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask     = PhysicsCategories.None    // enemy can't collide
        enemy.physicsBody!.contactTestBitMask   = PhysicsCategories.Player | PhysicsCategories.Bullet
                                                                        // enemy can hit player/bullet
        
        self.addChild(enemy)
        
        let moveEnemy       = SKAction.move(to: endPoint, duration: 5)
        let deleteEnemy     = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence   = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        
        if(currentGameState == gameState.inGame){
            enemy.run(enemySequence)
        }
        
        let dx              = endPoint.x - startPoint.x
        let dy              = endPoint.y - startPoint.y
        let amountToRotate  = atan2(dy, dx)
        enemy.zRotation     = amountToRotate
    }
    
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch        = touch.location(in: self)
            
            if pauseLabel.contains(pointOfTouch){
                
                if(self.view!.isPaused == false){
                    self.view!.isPaused = true
                }
                else if(self.view!.isPaused == true){
                    self.view!.isPaused = false
                    
                }
            }
            
            
        }
       
        if(currentGameState == gameState.preGame){
            startGame()
        }
        
        else if(currentGameState == gameState.inGame){
            fireBullet()
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch            = touch.location(in: self)
            let previousPointOfTouch    = touch.previousLocation(in: self)
            
            let amountDraggedX = pointOfTouch.x - previousPointOfTouch.x
            let amountDraggedY = pointOfTouch.y - previousPointOfTouch.y
            
            
            if(currentGameState == gameState.inGame){
                player.position.x += amountDraggedX
                player.position.y += amountDraggedY
            }
            
            
            if(player.position.x > gameArea.maxX - player.size.width/2){
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            if(player.position.x < gameArea.minX + player.size.width/2){
                player.position.x = gameArea.minX + player.size.width/2
            }
            
            if(player.position.y > gameArea.maxY - player.size.height/2){
                player.position.y = gameArea.maxY - player.size.height/2
            }
            
            if(player.position.y < gameArea.minY + player.size.height/2){
                player.position.y = gameArea.minY + player.size.height/2
            }
        }
    }
}
