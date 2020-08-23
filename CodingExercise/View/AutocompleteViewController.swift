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
    
    private let searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.accessibilityLabel = Constants.Strings.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .placeholderBackgroundColor
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor,
                          .font : UIFont.placeholder, NSAttributedString.Key.paragraphStyle: centeredParagraphStyle]
        textField.attributedPlaceholder = NSAttributedString(string: Constants.Strings.textFieldPlaceholder, attributes: attributes)
        textField.layer.cornerRadius = .textFieldCornerRadius
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.placeholderBackgroundColor.cgColor
        return textField
    }()
    
    private let searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .cellRowHeight
        tableView.separatorColor = .dividerColor
        return tableView
    }()
    
    private let statusLabel = UILabel(font: .status, textColor: .statusLabelColor, textAlignment: .center, numberOfLines: 0, text: Constants.Strings.emptyStateText)
    
    private let statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: Constants.Images.emptyState)
        return iv
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
        
        searchResultsTableView.isHidden = true
        searchResultsTableView.dataSource = dataSource
        searchResultsTableView.delegate = self
        searchResultsTableView.register(AutocompleteTableViewCell.self, forCellReuseIdentifier: Constants.Strings.cellIdentifier)
        
        viewModel.delegate = self
        dataSource.viewModel = viewModel
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.subviews(
            searchTextField,
            statusLabel,
            statusImageView,
            searchResultsTableView
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchTextField
            .leading(.leadingSpacing)
            .trailing(.trailingSpacing)
            .top(.textFieldTopPadding)
            .height(40)
        
        statusLabel
            .leading(.statusLabelSidePadding)
            .trailing(.statusLabelSidePadding)
            .Top == searchTextField.Bottom + .statusLabelTopPadding
        
        statusImageView
            .leading(.leadingSpacing)
            .trailing(.trailingSpacing)
            .height(.statusImageViewHeight)
            .Top == statusLabel.Bottom + .statusImageViewTopPadding
        
        searchResultsTableView
            .bottom(0)
            .leading(0)
            .trailing(0)
            .Top == searchTextField.Bottom + .textFieldBottomSpacing
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
    
    func updateStatusUI(with state: ResultState) {
        switch state {
        case .empty:
            searchResultsTableView.isHidden = true
            statusLabel.text = Constants.Strings.emptyStateText
            statusImageView.image = UIImage(named: Constants.Images.emptyState)
        case .noResults:
            searchResultsTableView.isHidden = true
            statusLabel.text = Constants.Strings.noResultsText
            statusImageView.image = UIImage(named: Constants.Images.noResults)
        case .warning:
            searchResultsTableView.isHidden = true
            statusLabel.text = Constants.Strings.warningStateText
            statusImageView.image = UIImage(named: Constants.Images.warningState)
        case .results:
            searchResultsTableView.isHidden = false
        }
    }
}

// MARK: - Table View Delegate Methods
extension AutocompleteViewController: UITableViewDelegate {}

