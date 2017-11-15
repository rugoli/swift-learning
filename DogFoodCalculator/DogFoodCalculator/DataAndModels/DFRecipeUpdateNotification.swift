//
//  DFRecipeUpdateNotification.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeUpdateModel : NSObject {
  let model: DFIngredientModel
  let indexPathRow: Int
  static let notificationName: NSNotification.Name = NSNotification.Name("recipe-update")
  
  init(model: DFIngredientModel, indexPath: Int) {
    self.model = model
    self.indexPathRow = indexPath
  }
}

@objc protocol DFRecipeUpdateListener : class {
  @objc func observeRecipeUpdate(notification: NSNotification)
}
