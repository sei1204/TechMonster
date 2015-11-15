//
//  Player.swift
//  TechDra
//
//  Created by Master on 2015/03/24.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit

class Player {
    
    var name: String! = "勇者"
    var maxHP: Float! = 100
    var currentHP: Float! = 100
    var attackPoint: Float! = 30
    var speed: Float! = 1.2
    var currentTP: Float! = 100//技を繰り出すためのゲージの値
    var maxTP: Float! = 100
    var currentMovePoint: Float! = 0 //行動するためのゲージの値
    var maxMovePoint: Float! = 20
    var image: UIImage! = UIImage(named: "yusya.png")
    
    init(name:String,imageName:String) {

        self.name = name
        self.image = UIImage(named: imageName)
        
    }
    
}
