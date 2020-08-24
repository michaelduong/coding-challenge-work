//
//  CacheManager.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

protocol CacheManagarInterface {
    func lookupCache(key: String) -> Bool
    func retrieveCache(key: String) -> [UserSearchResult]?
    func saveCache(cache: [String: [UserSearchResult]])
    func addToCache(searchString: String, result: [UserSearchResult])
}

final class CacheManager: CacheManagarInterface {
    
    var cache = [String: [UserSearchResult]]()
    
    let defaults = UserDefaults.standard
    
    init() {
        if let data = defaults.object(forKey: Constants.UserDefaultKeys.cache) as? Data {
            if let cachedData = try? JSONDecoder().decode([String: [UserSearchResult]].self, from: data) {
                self.cache = cachedData
            }
        }
    }
    
    func lookupCache(key: String) -> Bool {
        if cache.keys.contains(key.lowercased()) {
            return true
        } else {
            return false
        }
    }
    
    func retrieveCache(key: String) -> [UserSearchResult]? {
        if lookupCache(key: key.lowercased()) {
            return cache[key.lowercased()]!
        }
        
        return nil
    }
    
    func saveCache(cache: [String: [UserSearchResult]]) {
        if let data = try? JSONEncoder().encode(cache) {
            defaults.set(data, forKey: Constants.UserDefaultKeys.cache)            
        }
    }
    
    func addToCache(searchString: String, result: [UserSearchResult]) {
        cache[searchString.lowercased()] = result
        saveCache(cache: cache)
    }
}

