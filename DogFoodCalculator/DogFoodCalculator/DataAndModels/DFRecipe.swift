//
//  DFRecipe.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipe: NSObject {
  var ingredients: [DFIngredientModel] = []
  
  func addIngredient(_ ingredient: DFIngredientModel) {
    self.ingredients.append(ingredient)
  }
  
  func removeIngredient(_ ingredient: DFIngredientModel) {
    if self.ingredients.contains(ingredient) {
      self.ingredients = self.ingredients.filter{$0 != ingredient}
    }
  }
  
  func removeAllIngredients() {
    self.ingredients.removeAll()
  }
}
