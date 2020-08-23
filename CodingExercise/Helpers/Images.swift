//
//  Images.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Placeholder image
    public static var placeholderImage: UIImage = .init(imageLiteralResourceName: Constants.Images.placeholder)
    // Empty state image
    public static var emptyStateImage: UIImage = .init(imageLiteralResourceName: Constants.Images.emptyState)
    // No results image
    public static var noResultsImage: UIImage = .init(imageLiteralResourceName: Constants.Images.noResults)
    // Warning state image
    public static var warningStateImage: UIImage = .init(imageLiteralResourceName: Constants.Images.warningState)
}
