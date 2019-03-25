//
//  RedditCellViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation
import UIKit
class RedditCellViewModel:RedditBaseViewModel {
    
    
    var title:String
    var author:String
    var redditImage:UIImage
    var comments:String
    var readState:Bool
    var redditPostTime:String
    var dismissCellAction:((RedditCellViewModel) ->())?
    
    override init(redditModel:RedditModel) {
        self.title = redditModel.title
        self.author = redditModel.author
        self.redditImage = UIImage(named: "defaultRedditImage")!
        self.comments = "\(redditModel.numberOfComments) comments"
        self.readState = false
        let hoursAgo = Calendar.current.dateComponents([.hour], from: redditModel.dateCreated, to: Date()).hour ?? 0
        self.redditPostTime = "\(hoursAgo) hours ago"
        super.init(redditModel: redditModel)
    }
    
    func dismissCellTapped() {
        self.dismissCellAction?(self)
    }
    
    
}
