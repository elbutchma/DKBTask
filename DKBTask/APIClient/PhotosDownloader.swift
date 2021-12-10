//
//  PhotosDownloader.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import UIKit

final class PhotoDownloader {
    
    static let shared = PhotoDownloader()
    
    private var cachedPhotos: [String: UIImage] = [:]
    private var photosDownloadTasks: [String: URLSessionDataTask] = [:]
    
    let photosQueue = DispatchQueue(label: "photos.queue", attributes: .concurrent)
    let dataTasksQueue = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)
    
    func downloadPhoto(with photoUrlString: String,
                       completionHandler: @escaping (UIImage?, Bool) -> Void) {
        
        if let image = getCachedImageFrom(urlString: photoUrlString) {
            completionHandler(image, true)
        } else {
            guard let url = URL(string: photoUrlString) else {
                completionHandler(nil, true)
                return
            }
            
            if let _ = getDataTaskFrom(urlString: photoUrlString) {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else {
                    return
                }
                
                if let _ = error {
                    DispatchQueue.main.async {
                        completionHandler(nil, true)
                    }
                    return
                }
                
                let image = UIImage(data: data)
                
                self.photosQueue.sync(flags: .barrier) {
                    self.cachedPhotos[photoUrlString] = image
                }
                
                _ = self.dataTasksQueue.sync(flags: .barrier) {
                    self.photosDownloadTasks.removeValue(forKey: photoUrlString)
                }
                
                // Always execute completion handler explicitly on main thread
                DispatchQueue.main.async {
                    completionHandler(image, false)
                }
            }
            
            self.dataTasksQueue.sync(flags: .barrier) {
                photosDownloadTasks[photoUrlString] = task
            }
            
            task.resume()
        }
    }
    
    private func getCachedImageFrom(urlString: String) -> UIImage? {
        photosQueue.sync {
            return cachedPhotos[urlString]
        }
    }
    
    private func getDataTaskFrom(urlString: String) -> URLSessionTask? {
        dataTasksQueue.sync {
            return photosDownloadTasks[urlString]
        }
    }
}

