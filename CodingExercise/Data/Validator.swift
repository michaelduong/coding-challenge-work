//
//  Validator.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

final class Validator {
    typealias Node = ValidatorNode<Character>
    let root: Node
    
    static let shared = Validator()
    
    private init() {
        root = Node()
    }
}

extension Validator {
    func insert(_ word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        
        let characters = Array(word.lowercased())
        var currentIndex = 0
        
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
            
            currentIndex += 1
            
            if currentIndex == characters.count {
                currentNode.isTerminating = true
            }
        }
    }
    
    func contains(_ word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        var currentNode = root
        
        let characters = Array(word.lowercased())
        var currentIndex = 0
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentIndex += 1
            currentNode = child
        }
        
        if currentIndex == characters.count && currentNode.isTerminating {
            return true
        } else {
            return false
        }
    }
    
    func startsWith(_ prefix: String) -> Bool {
        guard !prefix.isEmpty else { return false }
        var startsWithBool = false
        
        let wordCount = prefix.count
        
        for i in 1..<wordCount {
            startsWithBool = contains(String(prefix.prefix(i)))
            if startsWithBool {
                return true
            }
        }
        
        return false
    }
}
