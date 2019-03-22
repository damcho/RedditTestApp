//
//  RedditDetailViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

class RedditDetailViewModel {
    
    var redditModel:RedditModel?
    
    var title:String
    
    init(redditModel:RedditModel) {
        self.redditModel = redditModel
        self.title = redditModel.title
    }
    
}
