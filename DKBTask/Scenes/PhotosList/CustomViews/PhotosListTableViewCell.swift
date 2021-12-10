//
//  PhotosListTableViewCell.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Reusable
import UIKit

class PhotosListTableViewCell: UITableViewCell, NibReusable {
    // MARK: - Outlets
    
    @IBOutlet private var displayImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    // MARK: - Cell lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
    
    private func resetContent() {
        displayImageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Configuration
    
    func configure(withPhoto photo: Photo?) {
        guard let photo = photo else { return }
        
        titleLabel.text = photo.title
        PhotoDownloader.shared.downloadPhoto(with: photo.url) { [weak self] image, error in
            self?.displayImageView.image = image
        }
    }
}
