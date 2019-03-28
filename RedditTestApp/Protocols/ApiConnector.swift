//
//  ApiConnector.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 28/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

typealias QueryResut = (RedditsContainer?, RedditApiError?) -> ()

protocol ApiConnector {
    func fetchReddits( queryObject:RedditQueryObject,completionHandler: @escaping QueryResut)
}
