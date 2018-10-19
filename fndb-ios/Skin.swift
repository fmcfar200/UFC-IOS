//
//  Skin.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 18/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

class Skin
{
    var id:String?
    var name:String?
    var rarity:String?
    var desc:String?
    var cost:String?
    var imageLinkSmall:String?
    
    init() {
        
    }
    
    init(id:String, name:String, rarity:String, desc:String, imageLinkSmall:String)
    {
        self.id = id
        self.name = name
        self.rarity = rarity
        self.desc = desc
        self.imageLinkSmall = imageLinkSmall
        
        switch rarity {
        case "Uncommon":
            self.cost = "800"
        case "Rare":
            self.cost = "1200"
        case "Epic":
            self.cost = "1500"
        case "Legendary":
            self.cost = "2000"
            
        default:
            self.cost = "1000"
        }
        
    }
    
    
}
