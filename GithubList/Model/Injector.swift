//
//  Injector.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class Injector: InjectorProtocol {
    
    // MARK: Private(set) Properties
    
    private(set) var apiRequest: APIRequestProtocol
    private(set) var imageCache: NSCache<AnyObject, AnyObject>
    
    // MARK: Initialization
    
    init(withApiRequest apiRequest: APIRequestProtocol, andImageCache imageCache: NSCache<AnyObject, AnyObject>) {
        self.apiRequest = apiRequest
        self.imageCache = imageCache
    }
    
}
