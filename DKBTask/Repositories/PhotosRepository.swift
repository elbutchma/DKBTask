//
//  PhotosRepository.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation

protocol PhotosRepositoryType {
    func requestPhotosList(completion: @escaping (_ result: Result<PhotosList, APIError>) -> Void)
    func requestPhoto(photoId: Int, completion: @escaping (_ result: Result<Photo, APIError>) -> Void)
}

final class PhotosRepository: PhotosRepositoryType {
    let apiClient: APIClientType

    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }

    func requestPhotosList(completion: @escaping (_ result: Result<PhotosList, APIError>) -> Void) {
        apiClient.request(resource: PhotosListService()) { result in
            switch result {
            case .success(let payload):
                completion(.success(payload))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestPhoto(photoId: Int, completion: @escaping (Result<Photo, APIError>) -> Void) {
        apiClient.request(resource: PhotoDetailsService(with: photoId)) { result in
            switch result {
            case .success(let payload):
                completion(.success(payload))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
