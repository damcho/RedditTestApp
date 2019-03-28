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
    var redditsContainer: RedditsContainer = RedditsContainer()
    
    func getRedditCellViewModelAt(index:Int) -> RedditCellViewModel? {
        return self.redditsContainer.getRedditAt(index:index)
    }
    
    func getReddits() -> [RedditCellViewModel]{
        return self.redditsContainer.redditsArray
    }
    
    func redditsCount() -> Int {
       return self.redditsContainer.redditsArray.count
    }
    
    func getTopReddits(queryObj:RedditQueryObject) {
        
        let completionHandler = {[unowned self] (redditsContainer:RedditsContainer?, error:RedditApiError?) -> () in
            if let redditsContainer = redditsContainer {

                self.redditsContainer.update(container: redditsContainer)
                queryObj.after = self.redditsContainer.after

                self.redditsContainer.redditremovedAction = {[unowned self] (index) ->() in
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
        if queryObj.after == nil {
            self.redditsContainer.refresh()
        }
        apiConnector.fetchReddits(queryObject: queryObj, completionHandler: completionHandler)
    }
    
    func removeAllReddits() {
        self.redditsContainer.refresh()
        self.redditsFetchedWithSuccess?()
    }
    
}
