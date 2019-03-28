//
//  RedditBaseViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 25/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation
import UIKit

class RedditBaseViewModel {
    
    var redditModel:RedditModel?
    let imageCache = NSCache<AnyObject, AnyObject>()

    init(redditModel:RedditModel) {
        self.redditModel = redditModel
    }
    
    func getImage(handler: @escaping (UIImage) -> ()) {
        if let imageFromCache = imageCache.object(forKey:  self.redditModel?.thumbnailUrl as AnyObject) as? UIImage {
            handler(imageFromCache)
            return
        }
        guard let imageUrl =  self.redditModel?.thumbnailUrl else {
            handler(UIImage(named: "defaultRedditImage")!)
            return
        }
        let imageHandler = {[unowned self] (image:UIImage?) -> () in
            if image != nil {
                self.imageCache.setObject(image!, forKey: self.redditModel?.thumbnailUrl as AnyObject)
                handler(image!)
            } else {
                handler(UIImage(named: "defaultRedditImage")!)
            }
        }
        UIImage.downloaded(from: imageUrl, completionHandler: imageHandler)
    }
}
