//
//  GameViewController.swift
//  Galaxy Shooter
//
//  Created by Martin Kowaleff on 4/28/17.
//  Copyright © 2017 Martin Kowaleff. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath    = Bundle.main.path(forResource: "terranTheme1", ofType: "mp3")
        let audioNSURL  = URL(fileURLWithPath: filePath!)
        
        do{
            backingAudio = try AVAudioPlayer(contentsOf: audioNSURL)
        }
        catch{
            print("Cannot find audio.")
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
        
        
        let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            // Configure the view.
            let skView = self.view as! SKView
        
            // set to true if you want to see nodes & frames
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.showsPhysics = false
        
            /* Sprite Kit applies additional optimizations to improve rendering performance*/
            skView.ignoresSiblingOrder = true
        
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
