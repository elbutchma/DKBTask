//
//  PhotoDetailsViewController.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Reusable
import UIKit

class PhotoDetailsViewController: UIViewController, ViewModelBased, StoryboardBased {
    // MARK: - Outlets
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var albumIdLabel: UILabel!
    @IBOutlet private var photoIdLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: PhotoDetailsViewModel!
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    // MARK: - ViewModel binding
    
    private func bindViewModel() {
        viewModel.photoDetailsLoaded = { [weak self] image in
            self?.setupViews(withImage: image)
        }
    }
    
    // MARK: - Views setup
    
    private func setupViews(withImage image: UIImage?) {
        imageView.image = image
        titleLabel.text = viewModel.photo?.title
        albumIdLabel.text = "\(viewModel.photo?.albumId ?? 0)"
        photoIdLabel.text = "\(viewModel.photo?.id ?? 0)"
    }
}

