//
//  UIImageViewExtension.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func downloaded(from url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                completionHandler(image)
            }
            }.resume()
    }
}
