//
//  RedditListViewModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

class RedditListViewModel {
    
    
    var redditsFetchedWithSuccess: (() -> ())?
    var redditsFetchedWithFailed: ((RedditApiError) -> ())?
    var redditRemovedAtIndex:((Int) -> ())?
    let apiConnector = RedditApiConnector.shared
    var redditsContainer:RedditsContainer?
    
    func getRedditCellViewModelAt(index:Int) -> RedditCellViewModel? {
        return self.redditsContainer != nil ? self.redditsContainer!.getRedditAt(index:index) : nil
    }
    
    func getReddits() -> [RedditCellViewModel]{
        return self.redditsContainer != nil ? self.redditsContainer!.redditsArray : []
    }
    
    func redditsCount() -> Int {
        return self.redditsContainer?.redditsArray != nil ? self.redditsContainer!.redditsArray.count : 0
    }
    
    func getTopReddits(queryObj:RedditQueryObject) {
        
        let completionHandler = {[unowned self] (redditsContainer:RedditsContainer?, error:RedditApiError?) -> () in
            if let redditsContainer = redditsContainer {
                if self.redditsContainer == nil {
                    self.redditsContainer = redditsContainer
                } else {
                    self.redditsContainer?.update(container: redditsContainer)
                }
                self.redditsContainer?.redditremovedAction = {[unowned self] (index) ->() in
                    self.redditRemovedAtIndex?(index)
                }
                
                self.redditsFetchedWithSuccess?()
            } else {
                switch error! {
                case .MALFORMED_DATA:
                    self.redditsFetchedWithFailed?(error!)
                default:
                    return
                }
            }
        }
        
        if self.redditsContainer != nil {
            queryObj.after = self.redditsContainer?.after
        }
        apiConnector.fetchReddits(queryObject: queryObj, completionHandler: completionHandler)
    }
    
    func removeAllReddits() {
        self.redditsContainer?.redditsArray = []
        self.redditsFetchedWithSuccess?()
    }
    
}
