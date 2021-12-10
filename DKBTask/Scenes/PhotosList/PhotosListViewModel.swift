//
//  PhotosListViewModel.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Foundation
import CryptoKit

final class PhotosListViewModel: ViewModelType {
    // MARK: - Propeties
    
    private(set) var photosList: [Photo]?
    var photosListLoaded: (() -> Void)?
    var errorOccured: ((APIError) -> Void)?
    weak var coordinator: CoordinatorType?
    private var repository: PhotosRepositoryType
    
    // MARK: - Initialization
    
    init(withCoordinator coordinator: CoordinatorType, repository: PhotosRepositoryType) {
        self.coordinator = coordinator
        self.repository = repository
    }
    
    func viewWillAppear() {
        fetchPhotosList()
    }
    
    // MARK: - API Calls
    
    private func fetchPhotosList() {
        repository.requestPhotosList { [weak self] result in
            switch result {
            case .success(let photosList):
                self?.photosList = photosList.data
                self?.photosListLoaded?()
            case .failure(let error):
                self?.errorOccured?(error)
            }
        }
    }
    
    // MARK: - Navigation
    
    func photoSelected(atIndex index: Int) {
        coordinator?.navigate(to: .photo(photoId: photosList?[index].id ?? 0))
    }
}
