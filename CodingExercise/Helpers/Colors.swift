//
//  Colors.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit

// MARK: - Colors
extension UIColor {
    
    // Textfield Background Color
    public static var placeholderBackgroundColor: UIColor = .init(hex: "#F0EFFF")
    // Status Text Color
    public static var statusLabelColor: UIColor = .init(hex: "#6C63FF", alpha: 0.8)
    // User name color
    public static var nameColor: UIColor = .init(hex: "#1D1C1D")
    // User username color
    public static var usernameColor: UIColor = .init(hex: "#616061")
    // Divider color
    public static var dividerColor: UIColor = .init(hex: "#DDDDDD")
    // Placeholder text color
    public static var placeholderColor: UIColor = .init(hex: "#3C3C43", alpha: 0.6)
}

// MARK: - Utility
extension UIColor {

    /// Initialize a color according to the hexadecimal string value
    /// - Parameters:
    ///     - hex: string representing the color in hexadecimal format
    ///     - alpha: alpha value of the color to be generated
    /// - Note: the hexadecimal string must be valid (including `#` and `6` hexadecimal digits
    public convenience init(hex: String, alpha: CGFloat = 1) {

        guard hex.hasPrefix("#") else { fatalError() }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        guard hexColor.count == 6 else { fatalError() }

        let scanner = Scanner(string: hexColor)

        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { fatalError() }

        let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255

        self.init(displayP3Red: r, green: g, blue: b, alpha: alpha)
    }
}

