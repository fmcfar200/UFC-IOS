//
//  ShopItem.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 24/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class ShopItem: Decodable {
    
    let itemid:String?
    let name:String?
    let cost:String?
    let featured:Int?
    let refundable:Int?
    let lastupdate:Int?
    let item:ShopImage?
    
    let capital:String?
    let type:String?
    let rarity:String?
    let obtained_type:String?
}

class ShopImage: Decodable{
    let image:String?
    let images:ShopImages?
    
}

class ShopImages: Decodable{
    let transparent:String?
    let background:String?
    let featured:ShopImages?
}




