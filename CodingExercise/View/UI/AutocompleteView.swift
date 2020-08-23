//
//  AutocompleteView.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit
import Stevia

final class AutocompleteView: UIView {
    
    let searchTextField: UITextField = {
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
    
    let searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .cellRowHeight
        tableView.separatorColor = .dividerColor
        tableView.isHidden = true
        tableView.register(AutocompleteTableViewCell.self, forCellReuseIdentifier: Constants.Strings.cellIdentifier)
        return tableView
    }()
    
    let statusLabel = UILabel(font: .status, textColor: .statusLabelColor, textAlignment: .center, numberOfLines: 0, text: Constants.Strings.emptyStateText)
    
    let statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: Constants.Images.emptyState)
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.subviews(
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
