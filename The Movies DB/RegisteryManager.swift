//
//  RegisteryManager.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

final class RegisteryManager: NSObject {
    
    static let sharedInstance = RegisteryManager()
    
    fileprivate var currentViewController:UIViewController?
    
    fileprivate let services = [Constants.SEARCH_SERVICE:NSObject.self, Constants.POPULAR_ACTORS_SERVICE:NSObject.self]

    func registerMe(_ view:UIViewController,withServices services:[String]) {
        self.currentViewController = view
        
    }

    
}
