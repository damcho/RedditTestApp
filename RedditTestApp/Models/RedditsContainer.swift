//
//  RedditsContainer.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

class RedditsContainer {
    
    var redditsArray:[RedditCellViewModel] = []
    var after:String?
    
    init?(data:Array<Dictionary<String, Any>>) {
        self.createRedditModels(dataArray: data)
    }
    
    func createRedditModels(dataArray:Array<Dictionary<String, Any>>){
        var redditCellViewModelsArray: [RedditCellViewModel] = []
        for redditDictionary in dataArray {
            if let redditData = redditDictionary["data"] as? Dictionary<String, Any> {
                if let redditModel = RedditModel(data:redditData ) {
                    let redditCellViewModel = RedditCellViewModel(redditModel: redditModel)
                    redditCellViewModelsArray.append(redditCellViewModel)
                    self.redditsArray = redditCellViewModelsArray
                }
            }
        }
        
    }
    
    func getRedditAt(index:Int) -> RedditCellViewModel? {
        return index < self.redditsArray.count ? self.redditsArray[index] : nil
    }
}
