//
//  MockCoordinator.swift
//  DKBTaskTests
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import UIKit
@testable import DKBTask

class MockAppCoordinator: CoordinatorType {
    var children: [CoordinatorType] = []
    let rootController = UIViewController()
    
    var navigateCount: Int = 0
    
    func navigate(to state: AppState) {
        navigateCount += 1
    }
}

