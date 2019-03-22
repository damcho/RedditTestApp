//
//  RedditCellViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

class RedditCellViewModel {
    
    var redditModel:RedditModel?
    
    var title:String
    var author:String
    
    init(redditModel:RedditModel) {
        self.redditModel = redditModel
        self.title = redditModel.title
        self.author = redditModel.author
    }
}
