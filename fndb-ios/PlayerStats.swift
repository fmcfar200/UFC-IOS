//
//  PlayerStats.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class PlayerStats: Decodable {
    let p2:statSet?
    let p10:statSet?
    let p9:statSet?
    let curr_p2:statSet?
    let curr_p10:statSet?
    let curr_p9:statSet?
    

}

class statSet:Decodable{
    let trnRating: stat?
    let score:stat?
    let top1:stat?
    let top3:stat?
    let top5:stat?
    let top6:stat?
    let top10:stat?
    let top12:stat?
    let top25:stat?
    let kd:stat?
    let winRatio:stat?
    let matches:stat?
    let kills:stat?
    let kpg:stat?
    let scorePerMatch:stat?
    
    
}

class stat: Decodable{
    let label:String?
    let field:String?
    let category:String?
    let valueInt:Int?
    let value:String?
    let rank:Int?
    let percentile:Int?
    let displayValue:String?
}
