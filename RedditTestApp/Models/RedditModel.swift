//
//  RedditModel.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation


class RedditModel {
    
    let title:String
    let author:String
    let dateCreated:Date
    let thumbnailUrl:URL?
    let numberOfComments:Int
 //   let unreadStatus:Bool
    
    
    init?(data:Dictionary<String, Any>) {
        print("creo modelo")
        guard let title = data["title"] as? String else {
            return nil
        }
        self.title = title
        
        guard let author = data["author"] as? String else {
            return nil
        }
        self.author = author
        
        guard let thumbnailUrl = data["thumbnail"] as? String else {
            return nil
        }
        self.thumbnailUrl = URL(string: thumbnailUrl)

        guard let numberOfComments = data["num_comments"] as? Int else {
            return nil
        }
        self.numberOfComments = numberOfComments
        
        guard let dateCreated = data["created"] as? Int else {
            return nil
        }
        self.dateCreated = Date(timeIntervalSince1970: Double(dateCreated))
        print(self.dateCreated)
        
    }
    
}
