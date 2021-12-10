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

final class AppCoordinator: CoordinatorType {
    lazy var rootController: UIViewController = {
        let repository = PhotosRepository(apiClient: APIClient())
        let viewModel = PhotosListViewModel(withCoordinator: self, repository: repository)
        let viewController = PhotosListViewController.instantiate(with: viewModel)
        return UINavigationController(rootViewController: viewController)
    }()
    var children: [CoordinatorType] = []
    
    func coordinate(inWindow window: UIWindow) {
        window.rootViewController = rootController
    }
    
    func navigate(to state: AppState) {
        switch state {
        case .photo(let photoId):
            let repository = PhotosRepository(apiClient: APIClient())
            let viewModel = PhotoDetailsViewModel(withCoordinator: self, repository: repository, photoId: photoId)
            let viewController = PhotoDetailsViewController.instantiate(with: viewModel)
            (rootController as? UINavigationController)?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
