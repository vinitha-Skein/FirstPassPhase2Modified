//
//  CustomImageView.swift
//  ReUsableComponents
//
//  Created by SkeinTechnologies on 22/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    private var currentTask: URLSessionTask?
    
    var imageUrlString: String?
    
    func loadImageWithUrl(urlString: String) {
        
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()
        
        imageUrlString = urlString
        
        image = nil
        
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
//            request.setValue(UserDefaults.standard.string(forKey: "Authorization") ?? "", forHTTPHeaderField: "Authorization")
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        ImageCache.shared.save(image: downloadedImage, forKey: urlString)
                        if self.imageUrlString == urlString {
                            self.image = downloadedImage
                        }
                    })
                }
                
            }
            
            currentTask = dataTask
            dataTask.resume()
        }
    }
}
