//
//  Weapon.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 23/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class Weapon:Decodable{
    let hash:String?
    let name:String?
    let rarity:String?
    let images:Image?
    let stats:Stats?
}
class Image:Decodable{
    let image:String?
    let background:String?
    
}
class Stats:Decodable{
    let damage:Damage?
    let dps:String?
    let firerate:String?
    let magazine:Magazine?
    let ammocost:String?
}
class Damage:Decodable{
    let body:String?
    let head:String?
}
class Magazine:Decodable{
    let reload:String?
    let size:String?
}
