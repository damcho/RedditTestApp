//
//  RedditQueryObject.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

class RedditQueryObject {
    
    var after:String?
    
    func queryItems() -> [URLQueryItem] {
        var queryItems:[URLQueryItem] = []
        if after != nil {
            queryItems.append(URLQueryItem(name: "after", value: self.after))
        }
        queryItems.append(URLQueryItem(name: "limit", value: "50"))

        return queryItems
    }
    
}
