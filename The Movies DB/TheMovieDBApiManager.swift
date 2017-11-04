//
//  TheMovieDBApiManager.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

enum ResponseStatus {
    case Error;
    case NoActors;
    case ActorFound;
}

class TheMovieDBApiManager: NSObject {

    var requestID:String?
    
    func searchForActor(_ actorName:String,withPage page:Int, complition: @escaping( _ result : [Actor] ,_ status:ResponseStatus, _ requestID:String ,_ numberOfPages:Int, _ totalResults:Int) -> Void)  {
        // Build URL
        let builder = ApiUrlBuilder()
        let url = builder.requestType(.SearchPerson).addParamter(ApiUrlBuilder.Query_PARAM, actorName).addParamter(ApiUrlBuilder.Page_PARAM, "\(page)").buildUrl()
        
        
        var totalResults = 0
        var totalPages = 0
        
        // Make request
        Alamofire.request(url).responseObject { (response: DataResponse<ActorResponse>) in
            
            if let actorsResponse = response.result.value {
                var actors:[Actor] = [Actor]()
                totalResults = actorsResponse.total_results!
                totalPages = actorsResponse.total_pages!
                
                if totalResults == 0 {
                    complition([Actor](), .NoActors, self.requestID!, totalPages, totalResults)
                } else {
                    for result in actorsResponse.results! {
                        let actor = Actor()
                        actor.id = result.id!
                        actor.name = result.name!
                        actor.popularity = result.popularity!
//                        actor.profilePth = result.profile_path!
                        
                        actors.append(actor)
                    }
                    
                    
                    complition(actors, .ActorFound, self.requestID!, totalPages, totalResults)
                }
                
                
                
            } else {
                complition([Actor](), .Error, self.requestID!, totalPages, totalResults)
            }
            
        }
        
    }
    
    func getPopularActorsWithPage(_ page:Int,  complition: @escaping( _ result : [Actor] ,_ status:ResponseStatus, _ requestID:String ,_ numberOfPages:Int, _ totalResults:Int) -> Void) {
        // Build URL
        let builder = ApiUrlBuilder()
        let url = builder.requestType(.PopularPerson).addParamter(ApiUrlBuilder.Page_PARAM, "\(page)").buildUrl()
        
        
        var totalResults = 0
        var totalPages = 0
        
        // Make request
        Alamofire.request(url).responseObject { (response: DataResponse<ActorResponse>) in
            
            if let actorsResponse = response.result.value {
                var actors:[Actor] = [Actor]()
                totalResults = actorsResponse.total_results!
                totalPages = actorsResponse.total_pages!
                
                if totalResults == 0 {
                    complition([Actor](), .NoActors, self.requestID!, totalPages, totalResults)
                } else {
                    for result in actorsResponse.results! {
                        let actor = Actor()
                        actor.id = result.id!
                        actor.name = result.name!
                        actor.popularity = result.popularity!
                        actor.profilePth = result.profile_path!
                        
                        actors.append(actor)
                    }
                    
                    
                    complition(actors, .ActorFound, self.requestID!, totalPages, totalResults)
                }
                
                
                
            } else {
                complition([Actor](), .Error, self.requestID!, totalPages, totalResults)
            }
            
        }
    }
    
}
