//
//  DFRecipeUpdateNotification.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

enum DFRecipeUpdateType : String {
  case add
  case update
  case remove
}

class DFRecipeUpdateModel : NSObject {
  let updateType: DFRecipeUpdateType
  let indexPathRow: Int
  static let notificationName: NSNotification.Name = NSNotification.Name("recipe-update")
  
  init(updateType: DFRecipeUpdateType, indexPath: Int) {
    self.updateType = updateType
    self.indexPathRow = indexPath
  }
}

@objc protocol DFRecipeUpdateListener : class {
  @objc func observeRecipeUpdate(notification: NSNotification)
}
