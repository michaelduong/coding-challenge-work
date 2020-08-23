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
    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = .avatarCornerRadius
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel = UILabel(font: .name,
                                    textColor: .nameColor,
                                    textAlignment: .left,
                                    numberOfLines: 1)
    
    let usernameLabel = UILabel(font: .username,
                                        textColor: .usernameColor,
                                        textAlignment: .left,
                                        numberOfLines: 1)
    
    var userDetails: (String, String, URL)! {
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
    }
    
    private func bind() {
        nameLabel.text = userDetails.0
        usernameLabel.text = userDetails.1
        accessibilityLabel = userDetails.1
        
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: userDetails.2, placeholder: UIImage.placeholderImage, options: [.transition(.fade(0.2))])
    }
}
