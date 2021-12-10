//
//  PhotoDetailsViewModel.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation
import UIKit

final class PhotoDetailsViewModel: ViewModelType {
    // MARK: - Propeties
    
    private let photoId: Int
    private(set) var photo: Photo?
    weak var coordinator: CoordinatorType?
    private var repository: PhotosRepositoryType
    var photoDetailsLoaded: ((_ image: UIImage?) -> Void)?
    var errorOccured: ((APIError) -> Void)?
    
    // MARK: - Initialization
    
    init(withCoordinator coordinator: CoordinatorType, repository: PhotosRepositoryType, photoId: Int) {
        self.coordinator = coordinator
        self.repository = repository
        self.photoId = photoId
    }
    
    func viewWillAppear() {
        fetchPhotoDetails()
    }
    
    // MARK: - API Calls
    
    private func fetchPhotoDetails() {
        repository.requestPhoto(photoId: photoId) { [weak self] result in
            switch result {
            case .success(let photo):
                self?.photo = photo
                self?.downloadPhoto()
            case .failure(let error):
                self?.errorOccured?(error)
            }
        }
    }
    
    private func downloadPhoto() {
        PhotoDownloader.shared.downloadPhoto(with: photo?.url ?? "") { [weak self] image, error in
            self?.photoDetailsLoaded?(image)
        }
    }
}
