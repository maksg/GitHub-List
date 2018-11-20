//
//  DownloadableImageView.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadableImageView: UIImageView {
    
    var imageUrl: String = "" {
        didSet {
            self.image = nil
            
            guard let url = URL(string: self.imageUrl) else {
                return
            }
            
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        if let imageToCache = UIImage(data: data) {
                            imageCache.setObject(imageToCache, forKey: url as AnyObject)
                            if url.absoluteString == self.imageUrl {
                                self.image = imageToCache
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
}
