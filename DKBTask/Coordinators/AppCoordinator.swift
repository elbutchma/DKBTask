//
//  AppCoordinator.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var children: [CoordinatorType] { get set }
    var rootController: UIViewController { get }
    func navigate(to state: AppState)
}

protocol ChildCoordinatorType: CoordinatorType {
    var parent: CoordinatorType { get }
    func removeFromParent()
}

extension ChildCoordinatorType {
    func removeFromParent() {
        parent.children = parent.children.filter { $0 !== self }
    }
}

protocol Coordinated {
    var coordinator: CoordinatorType? { get }
}

enum AppState {
    case photosList
    case photo(photoId: Int)
}
