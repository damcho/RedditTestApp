//
//  RedditApiConnector.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 21/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation

enum RedditApiError : Error {
    case REQUEST_FAILURE(reason:String)
    case MALFORMED_DATA
    case NO_CONNECTION
}

class RedditApiConnector {
    
    static let shared = RedditApiConnector()
    let scheme = "https"
    let host = "www.reddit.com"
    let path = "/r/popular/top.json"
    let defaultSession =  URLSession(configuration: .default)
    typealias QueryResut = ([RedditModel]?, RedditApiError?) -> ()
    var dataTask: URLSessionDataTask?
    
    
    public func fetchReddits( queryObject:RedditQueryObject,completionHandler: @escaping QueryResut) {
        
        guard let url = createURL(queryItems: nil) else {
            return
        }
        self.performRequest(url: url, completionHandler: completionHandler)
    }
    
    private func createURL( queryItems:[URLQueryItem]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        if queryItems != nil {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    private func performRequest(url: URL, completionHandler: @escaping  QueryResut){
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer {
                self.dataTask = nil
            }
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil, .MALFORMED_DATA)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let mainDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    guard let dataDictionary = mainDictionary?["data"] as? Dictionary<String, Any> else {
                        DispatchQueue.main.async {
                            completionHandler(nil, .MALFORMED_DATA )
                        }
                        return
                    }
                    guard let dataArray = dataDictionary["children"] as? Array<Dictionary<String, Any>> else {
                        DispatchQueue.main.async {
                            completionHandler(nil, .MALFORMED_DATA )
                        }
                        return
                    }
                    let redditModels = self.createRedditModels(dataArray: dataArray)
                    completionHandler(redditModels, nil)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask?.resume()
    }
    
    
    func createRedditModels(dataArray:Array<Dictionary<String, Any>>) -> [RedditModel] {
        var redditModelsArray: [RedditModel] = []
        for redditDictionary in dataArray {
            if let redditData = redditDictionary["data"] as? Dictionary<String, Any> {
                if let reddit = RedditModel(data:redditData ) {
                    redditModelsArray.append(reddit)
                }
            }
        }
        
        return redditModelsArray
    }
    
    
}

