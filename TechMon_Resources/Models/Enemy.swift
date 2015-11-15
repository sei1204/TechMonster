//
//  Enemy.swift
//  techMon
//
//  Created by Yuki.F on 2015/10/27.
//  Copyright © 2015年 Yuki Futagami. All rights reserved.
//

import UIKit

class Enemy {
    
    var name: String! = "ドラゴン"
    var maxHP: Float! = 400
    var currentHP: Float! = 400
    var attackPoint: Float! = 20
    var speed: Float! = 1.2
    var currentMovePoint: Float! = 0//行動するためのゲージの値
    var maxMovePoint: Float! = 35
    
    var image: UIImage! = UIImage(named: "monster.png")
    
    init(name:String,imageName:String) {
        
        self.name = name
        self.image = UIImage(named: imageName)
    }
}

