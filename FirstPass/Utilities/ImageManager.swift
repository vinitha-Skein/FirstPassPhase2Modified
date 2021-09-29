//
//  ImageManager.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 16/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import UIKit
typealias JSON = [String : Any]
fileprivate let imageCache = NSCache<NSString, UIImage>()
extension NSError {
    static func generalParsingError(domain: String) -> Error {
        return NSError(domain: domain, code: 400, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Error retrieving data", comment: "General Error")])
    }
}
class ImageClient {
    //MARK: - Public
    
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            ImageClient.downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                }
            }
        }
    }

    //MARK: - Private
     static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        var request = URLRequest(url: url)
               request.addValue(UserDefaults.standard.string(forKey: "Authorization") ?? "", forHTTPHeaderField: "Authorization")
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    fileprivate static func convertToJSON(with data: Data) -> JSON? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            return nil
        }
    }
}


 var currentTask: URLSessionTask?
extension UIViewController{
        
        static func getImage(url:URL, completion: @escaping(_ image: UIImage?, _ error: Error? ) -> Void){
                    weak var oldTask = currentTask
                    currentTask = nil
                    oldTask?.cancel()

    //                imageUrlString = urlString
    //
    //                image = nil
                    
            if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
                        completion(cachedImage,nil)
                        return
                    }
                    
            if let url = URL(string: url.absoluteString) {
                        let request = URLRequest(url: url)
            //            request.setValue(UserDefaults.standard.string(forKey: "Authorization") ?? "", forHTTPHeaderField: "Authorization")
                        let session = URLSession.shared
                        let dataTask = session.dataTask(with: request) { (data, response, error) in
                            if let unwrappedError = error {
                                print(unwrappedError)
                                return
                            }
                            var imageUrlString: String?
                            imageUrlString = url.absoluteString
                            if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                                DispatchQueue.main.async(execute: {
                                    ImageCache.shared.save(image: downloadedImage, forKey: url.absoluteString)
                                    if imageUrlString == url.absoluteString {
                                        completion(downloadedImage,nil)
                                    }
                                })
                            }else{
                                completion(nil,nil)
                            }
                            
                        }
                        
                        currentTask = dataTask
                        dataTask.resume()
            }else{
                completion(nil,nil)
            }
        }
}
