//
//  ViewController.swift
//  Techmonster
//
//  Created by 三城勝美 on 2015/10/18.
//  Copyright © 2015年 sei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var moveValueUpTimer: NSTimer!
    var enemyTimer: NSTimer!
    var enemy: Enemy = Enemy(name: "ドラゴン", imageName: "monster.png")
    var player: Player = Player(name: "紙", imageName: "yusya.png")
    
    //    Make TechDraUtility
    let util: TechDraUtility = TechDraUtility()
    
    var isPlayerMoveValueMax: Bool! = true
    
    
    @IBOutlet var attackButton: UIButton!
    @IBOutlet var fireButton: UIButton!
    @IBOutlet var tameruButton: UIButton!
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var enemyMoveBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    @IBOutlet var playerMoveBar: UIProgressView!
    @IBOutlet var playerTPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0,4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0,4.0)
        initStatus()
        
        moveValueUpTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "moveValueUp", userInfo: nil, repeats: true)
        moveValueUpTimer.fire()
    }
    
    
    func initStatus() {
        
        
        enemyNameLabel.text = enemy.name
        playerNameLabel.text = player.name
        
        enemyImageView.image = enemy.image
        playerImageView.image = player.image
        
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        playerHPBar.progress = player.currentHP / player.maxHP
        playerTPBar.progress = player.currentHP / player.maxHP
        
        cureHP()
    }
    
    override func viewDidAppear(animated: Bool) {
        util.playBGM("BGM_battle001")
    }
    
    func moveValueUp() {
        
        player.currentMovePoint = player.currentMovePoint + 1
        playerMoveBar.progress = player.currentMovePoint / player.maxMovePoint
        
        if player.currentMovePoint >= player.maxMovePoint {
            isPlayerMoveValueMax = true
            player.currentMovePoint = player.maxMovePoint
        }else{
            isPlayerMoveValueMax = false
        }
        
        enemy.currentMovePoint = enemy.currentMovePoint + 1
        enemyMoveBar.progress = enemy.currentMovePoint / enemy.maxMovePoint
        
        if enemy.currentMovePoint >= enemy.maxMovePoint {
            self.enemyAttack()
            enemy.currentMovePoint = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerAttack() {
        TechDraUtility.damageAnimation(enemyImageView)
        util.playSE("SE_attack")
        
        enemy.currentHP = enemy.currentHP - player.attackPoint
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        
        if enemy.currentHP <= 0.0 {
            finishBattle(enemyImageView, winplayer: true)
        }
    }
    
    func enemyAttack() {
        TechDraUtility.damageAnimation(playerImageView)
        util.playSE("SE_attack")
        
        player.currentHP = player.currentHP - enemy.attackPoint
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        
        if player.currentHP <= 0.0 {
            finishBattle(playerImageView, winplayer: false)
        }
    }

    
    @IBAction func attackAction() {
        
        if isPlayerMoveValueMax == true {
            TechDraUtility.damageAnimation(enemyImageView)
            util.playSE("SE_attack")
            
            enemy.currentHP = enemy.currentHP - player.attackPoint
            enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
            
            player.currentTP = player.currentTP + 10
            if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            playerTPBar.progress = player.currentTP / player.maxTP
            
            
            player.currentMovePoint = 0
            
            if player.currentHP <= 0.0 {
                finishBattle(playerImageView, winplayer: true)
            }
        }
    }
    
    @IBAction func fireAction() {
        if isPlayerMoveValueMax == true && player.currentTP >= 40 {
            
            TechDraUtility.damageAnimation(enemyImageView)
            util.playSE("SE_fire")
            
            enemy.currentHP = enemy.currentHP - 100
            enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
            
            player.currentTP = player.currentTP - 40
            if player.currentTP <= 0 {
                player.currentTP = 0
            }
            playerTPBar.progress = player.currentTP / player.maxTP
            
            player.currentMovePoint = 0
            
            if enemy.currentHP <= 0.0 {
                finishBattle(enemyImageView, winplayer: true)
            }
        }
    }
    
    @IBAction func tameruAction() {
        if isPlayerMoveValueMax == true && player.currentTP >= 20{
            player.attackPoint = player.attackPoint + 30
            util.playSE("SE_change")
        }
    }
    
    
    
    func finishBattle(vanishImageView: UIImageView, winplayer: Bool) {
        TechDraUtility.vanishAnimation(vanishImageView)
        util.stopBGM()
        moveValueUpTimer.invalidate()
        isPlayerMoveValueMax = false
        
        var finishedMesseage: String
        
        if attackButton.hidden != true {
            attackButton.hidden = true
        }
        
        if fireButton.hidden != true{
            fireButton.hidden = true
        }
        
        if tameruButton.hidden != true{
            tameruButton.hidden = true
        }
        
        
        if winplayer == true {
            util.playSE("SE_fanfare")
            finishedMesseage = "YOU WIN!"
            
            
        }else{
            util.playSE("SE_gameover")
            finishedMesseage = "YOU LOSE.."
            
        }
        
        let alert =  UIAlertController(title: "battle finish!", message: finishedMesseage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Cure
    func cureHP() {
        moveValueUpTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateHPValue", userInfo: nil, repeats: true)
        moveValueUpTimer.fire()
    }
    
    func updateHPValue() {
        if enemy.currentHP < enemy.maxHP {
            enemy.currentHP = enemy.currentHP + enemy.defencePoint
            enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        }
        
        if player.currentHP < player.maxHP {
            player.currentHP = player.currentHP + player.defencePoint
            playerHPBar.progress = player.currentHP / player.maxHP
        }
    }
}




























