//
//  Constants.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Strings {
        static let textFieldPlaceholder = NSLocalizedString("Search Username...", comment: "")
        static let cellIdentifier = "Result-Cell"
        static let emptyStateText = NSLocalizedString("Start typing a username to get results here.", comment: "")
        static let noResultsText = NSLocalizedString("No results found.", comment: "")
        static let warningStateText = NSLocalizedString("Search term found in deny list.", comment: "")
    }
    
    struct Images {
        static let emptyState = "empty-state"
        static let noResults = "no-results"
        static let warningState = "warning-state"
        static let placeholder = "avatar-placeholder"
    }
    
}
