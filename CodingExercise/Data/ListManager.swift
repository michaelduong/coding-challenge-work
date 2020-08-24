//
//  ListManager.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

protocol ListManagerInterface {
    func retrieveList()
    func writeToList(addition: String)
    func saveListToDisk(_ list: [String])
}

class ListManager: ListManagerInterface {
    
    static let shared = ListManager()
    
    private init() {}
    
    var searchTerms = [String]()
    
    lazy var importer = ListImporter()
    
    let defaults = UserDefaults.standard
    
    func retrieveList() {
        // Load list of search terms from device/local storage if exists
        if let listOfWords = defaults.stringArray(forKey: Constants.UserDefaultKeys.savedTermsList) {
            searchTerms = listOfWords
        } else { // Otherwise we have to load it from the bundle
            let words = importer.importList()
            if !words.isEmpty {
                searchTerms = words.components(separatedBy: "\n")
                saveListToDisk(searchTerms) // Save it now so we can reload it later and not have to re-import
            }
        }
        initializeTrieValidator()
    }
    
    func saveListToDisk(_ list: [String]) {
        guard !list.isEmpty else { return }
        defaults.set(list, forKey: Constants.UserDefaultKeys.savedTermsList)
    }
    
    func writeToList(addition: String) {
        guard !addition.isEmpty else { return }
        if !Validator.shared.contains(addition) {
            searchTerms.append(addition.lowercased())
            Validator.shared.insert(addition.lowercased())
            saveListToDisk(searchTerms)
        }
    }
    
    func initializeTrieValidator() {
        for term in searchTerms {
            Validator.shared.insert(term)
        }
    }
}
