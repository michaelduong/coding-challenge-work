//
//  AutocompleteViewModel.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

enum ResultState {
    case empty
    case noResults
    case warning
    case results
}

protocol AutocompleteViewModelDelegate: class {
    func usersDataUpdated()
    func updateStatusUI(with state: ResultState)
}

// MARK: - Interfaces
protocol AutocompleteViewModelInterface {
    /*
     * Fetches users from that match a given a search term
     */
    func fetchUserNamesAndNames(_ searchTerm: String?, completionHandler: @escaping ([UserSearchResult]) -> Void)

    /*
     * Updates usernames according to given update string.
     */
    func updateSearchText(text: String?)

    /*
    * Returns a username at the given position.
    */
    func username(at index: Int) -> String

    /*
     * Returns the count of the current usernames array.
     */
    func usersCount() -> Int
    
    /*
     * Returns the full name at the given position.
     */
    func userFullName(at index: Int) -> String
    
    /*
     * Returns the user avatar image URL at the given position.
     */
    func userAvatarUrl(at index: Int) -> URL

    /*
     * Returns whether text is valid or found within the denylist
     */
    func validateText(_ text: String) -> Bool
    
    /*
     Delegate that allows to send data updates through callback.
 */
    var delegate: AutocompleteViewModelDelegate? { get set }
}

class AutocompleteViewModel: AutocompleteViewModelInterface {
    private let resultsDataProvider: UserSearchResultDataProviderInterface
    private var users: [UserSearchResult] = []
    public weak var delegate: AutocompleteViewModelDelegate?

    init(dataProvider: UserSearchResultDataProviderInterface) {
        self.resultsDataProvider = dataProvider
    }

    func updateSearchText(text: String?) {
        if validateText(text ?? "") {
            self.fetchUserNamesAndNames(text) { [weak self] users in
                DispatchQueue.main.async {
                    self?.users = users
                    self?.delegate?.updateStatusUI(with: .results)
                    self?.delegate?.usersDataUpdated()
                }
            }
        }
    }
    
    func validateText(_ text: String) -> Bool {
        if text.isEmpty {
            self.delegate?.updateStatusUI(with: .empty)
            return false
        }
        
        if Validator.shared.contains(text) || Validator.shared.startsWith(text) {
            self.delegate?.updateStatusUI(with: .warning)
            return false
        }
        
        return true
    }

    func usersCount() -> Int {
        return users.count
    }

    func username(at index: Int) -> String {
        return users[index].username
    }
    
    func userFullName(at index: Int) -> String {
        return users[index].name
    }
    
    func userAvatarUrl(at index: Int) -> URL {
        return URL(string: users[index].avatarUrl)!
    }

    func fetchUserNamesAndNames(_ searchTerm: String?, completionHandler: @escaping ([UserSearchResult]) -> Void) {
        guard let term = searchTerm, !term.isEmpty else {
            completionHandler([])
            return
        }

        self.resultsDataProvider.fetchUsers(term) { users in
            completionHandler(users.compactMap { $0 })
        }
    }
}
