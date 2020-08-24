//
//  AutocompleteViewController.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import UIKit
import Stevia

final class AutocompleteViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: AutocompleteViewModelInterface
    private let dataSource = AutocompleteTableViewDataSource()
    private let autoCompleteView = AutocompleteView()
    
    // MARK: - View Lifecycle Methods
    init(viewModel: AutocompleteViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = autoCompleteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DenyListManager.shared.retrieveList()
    }
    
    // MARK: - UI Functions
    private func setupUI() {
        autoCompleteView.searchTextField.delegate = self
        autoCompleteView.searchTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        
        autoCompleteView.searchResultsTableView.dataSource = dataSource
        
        viewModel.delegate = self
        dataSource.viewModel = viewModel
    }
}

// MARK: - TextField Delegate Methods
extension AutocompleteViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.updateSearchText(text: self.autoCompleteView.searchTextField.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - AutoComplete View Model Delegate Methods
extension AutocompleteViewController: AutocompleteViewModelDelegate {
    func usersDataUpdated() {
        autoCompleteView.searchResultsTableView.reloadData()
    }
    
    func updateStatusUI(with state: ResultState) {
        switch state {
        case .empty:
            autoCompleteView.searchResultsTableView.isHidden = true
            autoCompleteView.statusLabel.text = Constants.Strings.emptyStateText
            autoCompleteView.statusImageView.image = .emptyStateImage
        case .noResults:
            autoCompleteView.searchResultsTableView.isHidden = true
            autoCompleteView.statusLabel.text = Constants.Strings.noResultsText
            autoCompleteView.statusImageView.image = .noResultsImage
        case .warning:
            autoCompleteView.searchResultsTableView.isHidden = true
            autoCompleteView.statusLabel.text = Constants.Strings.warningStateText
            autoCompleteView.statusImageView.image = .warningStateImage
        case .results:
            autoCompleteView.searchResultsTableView.isHidden = false
        }
    }
}
