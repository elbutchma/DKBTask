//
//  MockAPIClient.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation
@testable import DKBTask

class MockAPIClient: APIClientType {
    func request(service: Service, completion: @escaping NetworkingCompletion) {
        switch service {
        case is PhotosListService:
            guard let url = Bundle.main.url(forResource: "PhotosList", withExtension: ".json"), let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load response from file")
            }
            completion(.success(data))
            
        case is PhotoDetailsService:
            guard let url = Bundle.main.url(forResource: "PhotoDetails", withExtension: ".json"), let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load response from file")
            }
            completion(.success(data))
        default:
            completion(.failure(.networkingError(nil)))
        }
    }

    func request<R>(resource: R, completion: @escaping (Result<R.Payload, APIError>) -> Void) where R : Resource {
        self.request(service: resource) { result in
            switch result {
            case .success(let data):
                let payload = resource.parse(data)
                completion(payload)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

