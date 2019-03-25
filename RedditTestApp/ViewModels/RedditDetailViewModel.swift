//
//  RedditDetailViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation
import UIKit

class RedditDetailViewModel:RedditBaseViewModel {
    
    var title:String
    var author:String
    var detailImage:UIImage?

    override init(redditModel:RedditModel) {
        self.title = redditModel.title
        self.author = redditModel.author
        super.init(redditModel: redditModel)
    }
}
