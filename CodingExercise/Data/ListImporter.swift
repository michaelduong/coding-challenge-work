//
//  ListImporter.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

protocol ListImporterInterface {
    func importDenyList() -> String
}

final class ListImporter: ListImporterInterface {
    
    func importDenyList() -> String {
        if let wordsURL = Bundle.main.url(forResource: Constants.Strings.denyList, withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                return words
            }
        }
        return ""
    }
}
