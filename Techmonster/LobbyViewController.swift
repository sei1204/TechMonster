//
//  LobbyViewController.swift
//  Techmonster
//
//  Created by 三城勝美 on 2015/10/18.
//  Copyright © 2015年 sei. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController,AVAudioPlayerDelegate {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levellabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "紙", imageName: "yusya.png")
        
        staminaBar.transform = CGAffineTransformMakeScale(1.0,4.0)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let level: Int = userDefaults.integerForKey("level")
        
        nameLabel.text = player.name
        levellabel.text = String(format: "Lv. 15", level + 1)
        stamina = 100
        
        util = TechDraUtility()
        
        cureStamina()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
    }
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    
    @IBAction func battle() {
        
        if stamina >= 50 {
            stamina = stamina - 50
            staminaBar.progress = stamina / 100
            
            self.performSegueWithIdentifier("battle", sender: nil)
        }else{
            let aleat = UIAlertController(title: "バトルに行けません", message: "スタミナを溜めて下さい", preferredStyle: UIAlertControllerStyle.Alert)
            aleat.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(aleat, animated: true, completion: nil)
        }
    }
    
    
    
    //    MARK: Cure
    func cureStamina() {
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateStaminaValue", userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue() {
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }
    
    
    
    // Do any additional setup after loading the view.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/


