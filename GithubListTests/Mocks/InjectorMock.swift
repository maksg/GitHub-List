//
//  InjectorMock.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 22/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class InjectorMock: InjectorProtocol {
    
    // MARK: Properties
    
    var apiRequest: APIRequestProtocol
    var imageCache: NSCache<AnyObject, AnyObject>
    
    // MARK: Initialization
    
    init(withApiRequest apiRequest: APIRequestProtocol, andImageCache imageCache: NSCache<AnyObject, AnyObject>) {
        self.apiRequest = apiRequest
        self.imageCache = imageCache
    }
    
}
