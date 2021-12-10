//
//  PhotosListViewController.swift
//  DKBTask
//
//  Created by Mostafa Alaa Elbutch on 10.12.21.
//

import Reusable
import UIKit

class PhotosListViewController: UIViewController, StoryboardBased, ViewModelBased {
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: PhotosListViewModel!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    // MARK: - ViewModel binding
    
    private func bindViewModel() {
        viewModel.photosListLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.errorOccured = { [weak self] error in
            self?.showErrorAler(error: error)
        }
    }
    
    // MARK: - Setup tableView
    
    private func setupTableView() {
        tableView.register(cellType: PhotosListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension PhotosListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photosList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PhotosListTableViewCell
        cell.configure(withPhoto: viewModel.photosList?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.photoSelected(atIndex: indexPath.row)
    }
}

extension PhotosListViewController {
    func showErrorAler(error: APIError) {
        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
