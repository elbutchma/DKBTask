//
//  PhotosRepositoryTests.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import XCTest

import XCTest
@testable import DKBTask

class PhotosRepositoryTests: XCTestCase {
    var sut: MockPhotosRepository!
    
    override func setUp() {
        let apiClient = MockAPIClient()
        sut = MockPhotosRepository(apiClient: apiClient)
    }
    
    override func tearDown() {
        sut = nil
    }

    func testFetchPhotosList() {
        let expectation = expectation(description: "Photos list fetched")
        
        sut.requestPhotosList { result in
            switch result {
            case .success(let photosList):
                self.assertPhotosList(photosList: photosList)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    private func assertPhotosList(photosList: PhotosList) {
        let photos = photosList.data
        XCTAssertEqual(photos.count, 3)
        XCTAssertEqual(photos[0].id, 1)
        XCTAssertEqual(photos[0].albumId, 1)
        XCTAssertEqual(photos[0].title, "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssertEqual(photos[0].url, "https://via.placeholder.com/600/92c952")
        XCTAssertEqual(photos[0].thumbnailUrl, "https://via.placeholder.com/150/92c952")
        
        XCTAssertEqual(photos[1].id, 2)
        XCTAssertEqual(photos[1].albumId, 1)
        XCTAssertEqual(photos[1].title, "reprehenderit est deserunt velit ipsam")
        XCTAssertEqual(photos[1].url, "https://via.placeholder.com/600/771796")
        XCTAssertEqual(photos[1].thumbnailUrl, "https://via.placeholder.com/150/771796")
        
        XCTAssertEqual(photos[2].id, 3)
        XCTAssertEqual(photos[2].albumId, 1)
        XCTAssertEqual(photos[2].title, "officia porro iure quia iusto qui ipsa ut modi")
        XCTAssertEqual(photos[2].url, "https://via.placeholder.com/600/24f355")
        XCTAssertEqual(photos[2].thumbnailUrl, "https://via.placeholder.com/150/24f355")
    }
    
    func testFetchPhotoDetails() {
        let expectation = expectation(description: "Photo details fetched")
        
        sut.requestPhoto(photoId: 1, completion: { result in
            switch result {
            case .success(let photo):
                self.assertPhotoDetails(photo: photo)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0)
    }
    
    private func assertPhotoDetails(photo: Photo) {
        XCTAssertEqual(photo.id, 1)
        XCTAssertEqual(photo.albumId, 1)
        XCTAssertEqual(photo.title, "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssertEqual(photo.url, "https://via.placeholder.com/600/92c952")
        XCTAssertEqual(photo.thumbnailUrl, "https://via.placeholder.com/150/92c952")
    }
}
