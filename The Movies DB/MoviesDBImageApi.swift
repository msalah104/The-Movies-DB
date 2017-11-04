//
//  MoviesDBImageApi.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class MoviesDBImageApi: NSObject {
    
    static let IconSize = "/w92/"
    static let OriginanlSize = "/orignal/"
    static let BaseUrl = "http://image.tmdb.org/t/p"
    
    class func getOrignialImageOfPath(_ path:String) -> String{
        return "\(BaseUrl)\(OriginanlSize)\(path)"
    }
    
   class func getIconImageOfPath(_ path:String)  -> String{
        return "\(BaseUrl)\(IconSize)\(path)"
    }

}
