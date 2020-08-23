//
//  AutocompleteTableViewCell.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit
import Stevia
import Kingfisher

final class AutocompleteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = .avatarCornerRadius
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let nameLabel = UILabel(font: .name,
                                    textColor: .nameColor,
                                    textAlignment: .left,
                                    numberOfLines: 1)
    
    private let usernameLabel = UILabel(font: .username,
                                        textColor: .usernameColor,
                                        textAlignment: .left,
                                        numberOfLines: 1)
    
    var resultViewModel: AutocompleteViewModel! {
        didSet {
            bind()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.subviews(
            avatarImageView,
            nameLabel,
            usernameLabel
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        avatarImageView
            .top(.cellTopPadding)
            .bottom(.cellBottomPadding)
            .leading(.avatarLeadingPadding)
            .size(.avatarSize)
        
        nameLabel
            .top(.cellTopPadding)
            .bottom(.cellBottomPadding)
            .Leading == avatarImageView.Trailing + .avatarLeadingPadding
        
        usernameLabel
            .top(.cellTopPadding)
            .bottom(.cellBottomPadding)
            .Leading == nameLabel.Trailing + .usernameLeadingPadding
        usernameLabel.Trailing == contentView.Trailing - .usernameTrailingPadding
    }
    
    private func bind() {
        
    }
}
