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

    init(redditModel:RedditModel) {
        self.redditModel = redditModel
    }
    
    func getImage(handler: @escaping (UIImage) -> ()) {
        guard let imageUrl =  self.redditModel?.thumbnailUrl else {
            return
        }
        let imageHandler = {(image:UIImage?) -> () in
            if image != nil {
                handler(image!)
            } else {
                handler(UIImage(named: "defaultRedditImage")!)
            }
        }
        UIImage.downloaded(from: imageUrl, completionHandler: imageHandler)
    }
}
