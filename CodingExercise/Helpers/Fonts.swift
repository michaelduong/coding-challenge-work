//
//  Fonts.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit

extension UIFont {
    
    // User name font
    public static var name: UIFont = UIFont(name: .latoBold, size: 16)!
    // User username font
    public static var username: UIFont = UIFont(name: .latoRegular, size: 16)!
    // Status font
    public static var status: UIFont = UIFont(name: .latoBold, size: 24)!
    // Placeholder font
    public static var placeholder: UIFont = UIFont(name: .latoRegular, size: 16)!
}

// MARK: - Font names
extension String {
    
    fileprivate static let latoBold: String = "Lato-Bold"
    fileprivate static let latoRegular: String = "Lato-Regular"
}
