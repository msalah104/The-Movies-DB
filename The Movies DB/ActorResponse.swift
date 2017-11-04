//
//  ActorResponse.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import ObjectMapper


class ActorResponse: Mappable {

    var page:Int?
    var total_results:Int?
    var total_pages:Int?
    var results:[Results]?
    var status_code:Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        total_results <- map["total_results"]
        total_pages <- map["total_pages"]
        results <- map["results"]
        status_code <- map["status_code"]
    }
    
}


class Results: Mappable {
    
    var popularity:Double?
    var id:Int?
    var profile_path:String?
    var name:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        popularity <- map["popularity"]
        id <- map["id"]
        profile_path <- map["profile_path"]
        name <- map["name"]
    }
    
}
