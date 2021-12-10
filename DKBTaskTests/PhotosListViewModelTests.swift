//
//  PhotosListViewModelTests.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import XCTest
@testable import DKBTask

class PhotosListViewModelTests: XCTestCase {
    var coordinator: MockAppCoordinator?
    let apiClient = MockAPIClient()
    lazy var repository = {
        MockPhotosRepository(apiClient: apiClient)
    }()
    var sut: PhotosListViewModel!
    
    override func setUp() {
        coordinator = MockAppCoordinator()
        sut = PhotosListViewModel(withCoordinator: coordinator!, repository: repository)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func viewWillAppear() {
        let expectation = expectation(description: "photos loaded")
        
        repository.requestPhotosList { [weak self] result in
            XCTAssertEqual(self?.repository.requestPhotosListsCount, 1)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testDataLoading() {
        viewWillAppear()
    }
    
    func testOpenDetails() {
        sut.photoSelected(atIndex: 0)
        XCTAssertEqual(coordinator?.navigateCount, 1)
    }
}
