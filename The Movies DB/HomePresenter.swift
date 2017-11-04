//
//  HomePresenter.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

enum LastRequestType {
    case Search;
    case LoadPopActors;
}

// Protocol to all state for the home view
protocol HomeViewDelegate: ViewDelegate  {
    
    // Loading
    func startLoading()
    func finishLoading()
    
    // Error
    func someThingWrongHappend()
    func noActors()
    func error()
    
    // UpdateData
    func clearActorsList()
    func readyToReciveData()
    func requestFinished()
    // TODO will be updated
    func insertActors(_ actors: [Actor])
}

protocol HomeViewActions: Presenter {
    
    func searchForActorName(_ name:String)
    func viewFirstLauch()
    func reloadPopActors()
    func lastItemWillReach()
    
}

class HomePresenter: NSObject {
    
    fileprivate var view:HomeViewDelegate?
    fileprivate var movieDBApi:TheMovieDBApiManager?
    fileprivate var searchPage = 0
    fileprivate var actorPage = 0
    fileprivate var lastRequestType:LastRequestType = .LoadPopActors
    fileprivate var lastSearchStr = ""
    var lastRequestID:String?
    
    func handleResponse(_ actors:[Actor], _ status:ResponseStatus, _ requestID:String ,_ numberOfPages:Int, _ totalResults:Int ) {
        
        self.view?.finishLoading()
        
        if status == ResponseStatus.Error {
            self.view?.someThingWrongHappend()
        } else if status == ResponseStatus.NoActors {
            self.view?.noActors()
        } else if status == ResponseStatus.ActorFound {
            self.view?.insertActors(actors)
        }
    }

}


extension HomePresenter : HomeViewActions {
    
    
    
    func attachView(_ viewDelegate:ViewDelegate){
        self.view = viewDelegate as? HomeViewDelegate
        movieDBApi = TheMovieDBApiManager()
        searchPage = 1
        actorPage = 1
    }
    
    func detachView(_ viewDelegate:ViewDelegate){
        self.view = nil
        
    }
    
    // MARK:- Reachability
    
    func startReachabilityNotifier()
    {
        NotificationCenter.default.addObserver(self, selector:Selector(("checkForReachability:")), name: NSNotification.Name.reachabilityChanged, object: nil)
        let reachability: Reachability = Reachability.forInternetConnection()
        reachability.startNotifier()
    }
    
    func checkForReachability(notification:NSNotification)
    {
        let networkReachability = notification.object as! Reachability;
        let remoteHostStatus = networkReachability.currentReachabilityStatus()
        
        
        if (remoteHostStatus == NotReachable)
        {
            print("Not Reachable")
        }
        else
        {
            print("Reachable")
        }
    }
    
    func searchForActorName(_ name:String) {
        
        view?.clearActorsList()
        view?.startLoading()
        self.view?.clearActorsList()
        lastRequestID = String(Date().timeIntervalSince1970)
        searchPage = 1
        movieDBApi?.requestID = lastRequestID
        lastSearchStr = name
        movieDBApi?.searchForActor(name, withPage: searchPage, complition: { (actors, status, requestID, totalNumberOfPages, totalResults) in
            self.handleResponse(actors, status, requestID, totalNumberOfPages, totalResults)
            
        })
        
    }
    
    func viewFirstLauch() {
        view?.startLoading()
        lastRequestType = .LoadPopActors
        lastRequestID = String(Date().timeIntervalSince1970)
        movieDBApi?.requestID = lastRequestID
        actorPage = 1
        movieDBApi?.getPopularActorsWithPage(actorPage, complition: { (actors, status, requestID, totalNumberOfPages, totalResults) in
            self.handleResponse(actors, status, requestID, totalNumberOfPages, totalResults)
        })
        
    }
    
    func lastItemWillReach(){

        if lastRequestType == .LoadPopActors {
            actorPage += 1
            movieDBApi?.getPopularActorsWithPage(actorPage, complition: { (actors, status, requestID, totalNumberOfPages, totalResults) in
                self.handleResponse(actors, status, requestID, totalNumberOfPages, totalResults)
            })} else {
                searchPage += 1
                movieDBApi?.searchForActor(lastSearchStr, withPage: searchPage, complition: { (actors, status, requestID, totalNumberOfPages, totalResults) in
                    self.handleResponse(actors, status, requestID, totalNumberOfPages, totalResults)
                    
                })
            }
        
    }
    
    func reloadPopActors() {
        
        view?.clearActorsList()
        lastRequestID = String(Date().timeIntervalSince1970)
        movieDBApi?.requestID = lastRequestID
        view?.startLoading()
        lastRequestType = .LoadPopActors
        actorPage = 1
        movieDBApi?.getPopularActorsWithPage(actorPage, complition: { (actors, status, requestID, totalNumberOfPages, totalResults) in
            self.handleResponse(actors, status, requestID, totalNumberOfPages, totalResults)
        })
        
    }
}
