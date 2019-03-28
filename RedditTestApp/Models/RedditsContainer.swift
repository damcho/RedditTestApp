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
    var redditremovedAction:((Int) -> ())?
    
    init() {
        
    }
    
    init?(data:Array<Dictionary<String, Any>>) {
        self.createRedditCellModels(dataArray: data)
    }
    
    func createRedditCellModels(dataArray:Array<Dictionary<String, Any>>){
        var redditCellViewModelsArray: [RedditCellViewModel] = []
        for redditDictionary in dataArray {
            if let redditData = redditDictionary["data"] as? Dictionary<String, Any> {
                if let redditModel = RedditModel(data:redditData ) {
                    let redditCellViewModel = RedditCellViewModel(redditModel: redditModel)
                    redditCellViewModelsArray.append(redditCellViewModel)
                }
            }
        }
        self.redditsArray = redditCellViewModelsArray
    }
    
    func getRedditAt(index:Int) -> RedditCellViewModel? {
        return index < self.redditsArray.count ? self.redditsArray[index] : nil
    }
    
    func setDismissAction(redditsArray:[RedditCellViewModel]) {
        let dismissCellAction =  {[weak self] (redditCellViewModel:RedditCellViewModel) -> () in
            let index = self?.redditsArray.firstIndex(where: {$0 === redditCellViewModel})
            self?.redditsArray.remove(at: index!)
            self?.redditremovedAction?(index!)
        }
        
        for redditCellModel in redditsArray {
            redditCellModel.dismissCellAction = dismissCellAction
        }
    }
    
    func update(container:RedditsContainer) {
        self.after = container.after
        self.setDismissAction(redditsArray: container.redditsArray)
        self.redditsArray.append(contentsOf: container.redditsArray)
    }
    
    func refresh() {
        self.after = nil
        self.redditsArray = []
    }
}
