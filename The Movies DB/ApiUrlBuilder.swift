//
//  ApiUrlBuilder.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit


enum RequestType:String {
    case Search = "search"
    case SearchPerson = "search/person"
    case PopularPerson = "person/popular"
}

class ApiUrlBuilder: NSObject {
    
    fileprivate let BASE_URL = "https://api.themoviedb.org/3/"
    fileprivate let API_KEY_PARAM = "?api_key="
    fileprivate let API_KEY = "60062ad42616666d14c556dc96573c7e"
    static let Query_PARAM = "&query="
    static let Page_PARAM = "&page="
    fileprivate let Adult_PARAM = "&include_adult=false"
    
    fileprivate var requestType:RequestType = RequestType.Search
    fileprivate var params:[String:Any] = [String:Any]()
    
    
    func requestType(_ type:RequestType) -> ApiUrlBuilder {
        self.requestType = type
        return self
    }
    
    func addParamter(_ param:String, _ value:String) -> ApiUrlBuilder {
        params[param] = value
        return self
    }
    
    func buildUrl() -> String {
        var url = "\(BASE_URL)\(String(describing: requestType.rawValue))\(API_KEY_PARAM)\(API_KEY)"
        for key in params.keys {
            url = "\(url)\(key)\(params[key] as! String)"
        }
        
        return "\(url)\(Adult_PARAM)"
    }
}
