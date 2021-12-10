//
//  MockPhotosRepository.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation
@testable import DKBTask

class MockPhotosRepository: PhotosRepositoryType {
    private let apiClient: APIClientType
    var requestPhotosListsCount: Int = 0
    var requestPhotoDetailsCount: Int = 0
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    
    func requestPhotosList(completion: @escaping (_ result: Result<PhotosList, APIError>) -> Void) {
        requestPhotosListsCount += 1
        apiClient.request(resource: PhotosListService()) { result in
            completion(result)
        }
    }
    
    func requestPhoto(photoId: Int, completion: @escaping (_ result: Result<Photo, APIError>) -> Void) {
        requestPhotoDetailsCount += 1
        apiClient.request(resource: PhotoDetailsService(with: 1)) { result in
            completion(result)
        }
    }
}
