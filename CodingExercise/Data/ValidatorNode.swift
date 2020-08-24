//
//  ValidatorNode.swift
//  CodingExercise
//
//  Created by Swift Team Six on 8/23/20.
//  Copyright © 2020 slack. All rights reserved.
//

import Foundation

class ValidatorNode<T: Hashable> {
  var value: T?
  weak var parent: ValidatorNode?
  var children: [T: ValidatorNode] = [:]
  var isTerminating = false
  
  init(value: T? = nil, parent: ValidatorNode? = nil) {
    self.value = value
    self.parent = parent
  }
  
  func add(child: T) {
    guard children[child] == nil else { return }
    children[child] = ValidatorNode(value: child, parent: self)
  }
}
