//
//  AutocompleteTableViewDataSource.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import UIKit

final class AutocompleteTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    var viewModel: AutocompleteViewModelInterface!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usernamesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.cellIdentifier, for: indexPath)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        let username = viewModel.username(at: indexPath.row)

        cell.textLabel?.text = username
        cell.accessibilityLabel = username
        return cell
    }
}