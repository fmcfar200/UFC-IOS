//
//  News.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 19/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

class News {
    
    var title:String?
    var body:String?
    var imageUrl:String?
    var timeMillis:CLong?
    
    init() {
        
    }
    
    init(title: String, body:String, imageUrl:String,timeMillis:CLong) {
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
        self.timeMillis = timeMillis
    }
    

}
