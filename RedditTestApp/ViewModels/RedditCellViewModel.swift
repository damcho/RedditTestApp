//
//  RedditCellViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation
import UIKit
class RedditCellViewModel {
    
    var redditModel:RedditModel?
    
    var title:String
    var author:String
    var redditImage:UIImage
    var comments:String
    var readState:Bool
    
    var dismissCellAction:((RedditCellViewModel) ->())?
    
    init(redditModel:RedditModel) {
        self.redditModel = redditModel
        self.title = redditModel.title
        self.author = redditModel.author
        self.redditImage = UIImage(named: "defaultRedditImage")!
        self.comments = "\(redditModel.numberOfComments) comments"
        self.readState = false
    }
    
    func getImage(handler: @escaping (UIImage) -> ()) -> UIImage {
        guard let imageUrl =  self.redditModel?.thumbnailUrl else {
            return self.redditImage
        }
        let imageHandler = {(image:UIImage?) -> () in
            if image != nil {
                handler(image!)
            }
        }
        UIImage.downloaded(from: imageUrl, completionHandler: imageHandler)
        return self.redditImage
    }
    
    func dismissCellTapped() {
        self.dismissCellAction?(self)
    }
    
    
}
