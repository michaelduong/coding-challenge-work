//
//  AutocompleteViewController.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import UIKit

final class AutocompleteViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: AutocompleteViewModelInterface

    private let searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = Constants.Strings.textFieldPlaceholder
        textField.accessibilityLabel = Constants.Strings.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .cellRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dataSource = AutocompleteTableViewDataSource()
    
    // MARK: - View Lifecycle Methods
    init(viewModel: AutocompleteViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Functions
    private func setupUI() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        searchResultsTableView.dataSource = dataSource
        searchResultsTableView.delegate = self
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Strings.cellIdentifier)
        
        viewModel.delegate = self
        dataSource.viewModel = viewModel
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentView.addSubview(searchTextField)
        contentView.addSubview(searchResultsTableView)
        view.addSubview(contentView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3),

            searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .leftSpacing),
            searchTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: .rightSpacing),

            searchResultsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: .bottomSpacing),
            searchResultsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            searchResultsTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .leftSpacing),
            searchResultsTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: .rightSpacing)
            ])
    }
}

// MARK: - TextField Delegate Methods
extension AutocompleteViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        viewModel.updateSearchText(text: searchTextField.text)
    }
}

// MARK: - AutoComplete View Model Delegate Methods
extension AutocompleteViewController: AutocompleteViewModelDelegate {
    func usersDataUpdated() {
        searchResultsTableView.reloadData()
    }
}

// MARK: - Table View Delegate Methods
extension AutocompleteViewController: UITableViewDelegate {}
