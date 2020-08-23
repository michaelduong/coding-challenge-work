//
//  UILabel+Extension.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit

extension UILabel {
    convenience public init(font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    func setLineHeight(lineHeight: CGFloat) {
            let text = self.text
            if let text = text {
                let attributeString = NSMutableAttributedString(string: text)
                let style = NSMutableParagraphStyle()
                
                style.lineSpacing = lineHeight
                attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
                self.attributedText = attributeString
            }
        }
}
