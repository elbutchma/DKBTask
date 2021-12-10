//
//  ViewModelType.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Reusable
import Foundation

protocol ViewModelType: Coordinated {
    func viewWillAppear()
}

protocol ViewModelBased: AnyObject {
    associatedtype T: ViewModelType
    var viewModel: T! { get set }
}

extension ViewModelBased where Self: StoryboardBased & UIViewController {
    static func instantiate(with viewModel: T) -> Self {
        let viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
