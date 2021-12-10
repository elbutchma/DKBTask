//
//  PhotosService.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation

final class PhotosListService: Resource {
    typealias Payload = PhotosList

    var endpoint: String {
        return "photos"
    }
}

final class PhotoDetailsService: Resource {
    private let photoId: Int
    typealias Payload = Photo

    init(with photoId: Int) {
        self.photoId = photoId
    }
    
    var endpoint: String {
        get {
            return "photos/\(photoId)"
        }
    }
}
