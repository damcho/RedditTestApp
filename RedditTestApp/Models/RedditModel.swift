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
    //let created:Date
   // let thumbnailUrl:String?
  //  let numberOfComments:Int
 //   let unreadStatus:Bool
    
    
    init?(data:Dictionary<String, Any>) {
        print("creo modelo")
        print(data)
        guard let title = data["title"] as? String else {
            return nil
        }
        self.title = title
        
        guard let author = data["author"] as? String else {
            return nil
        }
        self.author = author
    }
    
}
