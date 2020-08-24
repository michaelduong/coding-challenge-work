//
//  ListImporter.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

protocol ListImporterInterface {
    func importList() -> String
}

class ListImporter: ListImporterInterface {
    
    func importList() -> String {
        if let wordsURL = Bundle.main.url(forResource: "denylist", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                return words
            }
        }
        return ""
    }
}
