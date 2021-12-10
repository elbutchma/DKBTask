//
//  PhotoDetailsViewModelTests.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import XCTest
@testable import DKBTask

class PhotoDetailsViewModelTests: XCTestCase {
    var coordinator: MockAppCoordinator?
    let apiClient = MockAPIClient()
    lazy var repository = {
        MockPhotosRepository(apiClient: apiClient)
    }()
    var sut: PhotoDetailsViewModel!
    
    override func setUp() {
        coordinator = MockAppCoordinator()
        sut = PhotoDetailsViewModel(withCoordinator: coordinator!, repository: repository, photoId: 1)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func viewWillAppear() {
        let expectation = expectation(description: "photo details loaded")
        
        repository.requestPhoto(photoId: 1) { [weak self] result in
            XCTAssertEqual(self?.repository.requestPhotoDetailsCount, 1)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testDataLoading() {
        viewWillAppear()
    }
}
